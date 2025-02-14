import 'dart:convert';
import 'dart:typed_data';

import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/message/base.dart';
import 'package:multiversx_sdk/src/signature.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';

/// An interface defining the basic functionality of a wallet.
abstract class WalletInterface {
  /// The public key associated with this wallet.
  PublicKey get publicKey;

  /// Indicates whether this wallet is a guardian wallet.
  bool get isGuardian;

  /// Signs a transaction using the wallet's private key.
  ///
  /// [transaction] The transaction to be signed.
  /// Returns the signed transaction.
  Transaction signTransaction(final Transaction transaction);

  Signature signMessage(final Message message);
}

/// Represents an empty wallet that implements the WalletInterface.
/// This is primarily used for placeholder or testing purposes.
class EmptyWallet implements WalletInterface {
  @override
  final bool isGuardian;

  const EmptyWallet({this.isGuardian = false});

  @override
  PublicKey get publicKey => PublicKey.zero();

  @override
  Transaction signTransaction(final Transaction transaction) => transaction;

  @override
  Signature signMessage(final Message message) => Signature.empty();
}

/// Implements the WalletInterface and provides wallet functionality.
class Wallet implements WalletInterface {
  /// Creates a new Wallet instance from a mnemonic phrase.
  ///
  /// [mnemonic] The mnemonic phrase to generate the wallet from.
  /// [isGuardian] Whether this wallet is a guardian wallet (default: false).
  /// Returns a Future that resolves to a new Wallet instance.
  static Future<Wallet> fromMnemonic({
    required final String mnemonic,
    bool isGuardian = false,
  }) async {
    final bip44 = Bip44.fromMnemonic(mnemonic);
    final signingKey = await SigningKey.fromEntropy(bip44.entropy);

    return Wallet._(bip44, signingKey, isGuardian);
  }

  /// The BIP-44 implementation used for mnemonic and entropy management.
  final Bip44? _bip44;

  /// The signing key used for cryptographic operations like signing transactions.
  final SigningKey _signingKey;

  /// Indicates whether this wallet is a guardian wallet.
  @override
  final bool isGuardian;

  /// Creates a new Wallet instance from a raw seed.
  ///
  /// [seed] The raw seed bytes to generate the wallet from.
  /// [isGuardian] Whether this wallet is a guardian wallet (default: false).
  Wallet.fromSeed({
    required final Uint8List seed,
    this.isGuardian = false,
  })  : _bip44 = null,
        _signingKey = SigningKey.fromSeed(seed: seed);

  /// Creates a wallet directly from the signing key without using a mnemonic phrase.
  ///
  /// [signingKey] The signing key used for wallet operations (required).
  /// [isGuardian] Whether this wallet is a guardian wallet (default: false).
  Wallet.fromSigninKey({
    required final SigningKey signingKey,
    this.isGuardian = false,
  })  : _bip44 = null,
        _signingKey = signingKey;

  Wallet._(this._bip44, this._signingKey, this.isGuardian);

  /// The entropy used to generate this wallet.
  String? get entropy => _bip44?.entropy;

  /// The mnemonic phrase associated with this wallet.
  String? get mnemonic => _bip44?.mnemonic;

  /// The public key associated with this wallet.
  @override
  PublicKey get publicKey => _signingKey.publicKey;

  /// Signs a transaction using this wallet's private key.
  ///
  /// [transaction] The transaction to be signed.
  /// Returns the signed transaction.
  @override
  Transaction signTransaction(final Transaction transaction) {
    final signature = _signingKey.sign(
      utf8.encode(json.encode(transaction.toMap())),
    );

    if (isGuardian) {
      return transaction.copyWith(
        newGuardianSignature: Signature.fromBytes(signature),
      );
    }
    return transaction.copyWith(
      newSignature: Signature.fromBytes(signature),
    );
  }

  @override
  Signature signMessage(final Message message) {
    return Signature.fromBytes(_signingKey.sign(message.bytes));
  }
}

/// Represents a pair of wallets, including a main wallet and an optional guardian wallet.
class WalletPair {
  /// The main wallet of the pair.
  final WalletInterface mainWallet;

  /// The optional guardian wallet of the pair.
  final WalletInterface guardianWallet;

  /// Creates a new WalletPair instance.
  ///
  /// [mainWallet] The main wallet (required).
  /// [guardianWallet] The guardian wallet (optional).
  WalletPair(this.mainWallet, {this.guardianWallet = const EmptyWallet()});

  WalletPair.empty()
      : mainWallet = EmptyWallet(),
        guardianWallet = EmptyWallet();

  /// Indicates whether this wallet pair has a guardian wallet.
  bool get hasGuardian => switch (guardianWallet) {
        EmptyWallet() => false,
        _ => true,
      };

  /// Signs a transaction using this wallet pair.
  ///
  /// [transaction] The transaction to be signed.
  /// Returns the signed transaction.
  Transaction signTransaction(final Transaction transaction) {
    final signedTransaction = mainWallet.signTransaction(transaction);
    if (!hasGuardian) {
      return signedTransaction;
    }
    return guardianWallet.signTransaction(signedTransaction);
  }
}
