import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:test/test.dart';
import 'package:multiversx_sdk/src/wallet.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';

import '../mnemonic.dart';

final class MockTransaction extends Transaction {
  MockTransaction()
      : super(
          nonce: Nonce(0),
          value: Balance.zero(),
          sender: PublicKey.zero(),
          receiver: PublicKey.zero(),
          gasPrice: GasPrice(0),
          gasLimit: GasLimit(0),
          chainId: ChainId('1'),
          version: TransactionVersion(1),
        );

  @override
  Map<String, dynamic> toMap({PublicKey? signedBy}) {
    return {
      'nonce': nonce.value,
      'value': value.toDenominated,
      'sender': sender.bech32,
      'receiver': receiver.bech32,
      'gasPrice': gasPrice.value,
      'gasLimit': gasLimit.value,
      'chainID': chainId.value,
      'version': version.value,
    };
  }
}

void main() {
  group('EmptyWallet', () {
    test('publicKey should be zero', () {
      final emptyWallet = EmptyWallet();
      expect(emptyWallet.publicKey.bech32, equals(PublicKey.zero().bech32));
    });

    test('signTransaction should return the same transaction', () {
      final emptyWallet = EmptyWallet();
      final transaction = MockTransaction();
      final signedTransaction = emptyWallet.signTransaction(transaction);
      expect(signedTransaction, equals(transaction));
    });
  });

  group('Wallet', () {
    test('fromMnemonic creates a valid wallet', () async {
      final wallet = await Wallet.fromMnemonic(mnemonic: mnemonic);

      expect(wallet.mnemonic, equals(mnemonic));
      expect(wallet.publicKey, isNotNull);
      expect(wallet.isGuardian, isFalse);
    });

    test('signTransaction with non-guardian wallet', () async {
      final wallet = await Wallet.fromMnemonic(mnemonic: mnemonic);
      final transaction = MockTransaction();
      final signedTransaction = wallet.signTransaction(transaction);

      expect(signedTransaction.signature, isNotNull);
      expect(signedTransaction.guardianSignature, isNull);
    });

    test('signTransaction with guardian wallet', () async {
      final wallet =
          await Wallet.fromMnemonic(mnemonic: mnemonic, isGuardian: true);
      final transaction = MockTransaction();
      final signedTransaction = wallet.signTransaction(transaction);

      expect(signedTransaction.signature.hex, isEmpty);
      expect(signedTransaction.guardianSignature?.hex ?? '', isNotEmpty);
    });
  });

  group('WalletPair', () {
    test('creation with main wallet only', () {
      final mainWallet = EmptyWallet();
      final walletPair = WalletPair(mainWallet);

      expect(walletPair.mainWallet, equals(mainWallet));
      expect(walletPair.guardianWallet, isA<EmptyWallet>());
      expect(walletPair.hasGuardian, isFalse);
    });

    test('creation with main and guardian wallets', () {
      final mainWallet = EmptyWallet();
      final guardianWallet = EmptyWallet(isGuardian: true);
      final walletPair = WalletPair(mainWallet, guardianWallet: guardianWallet);

      expect(walletPair.mainWallet, equals(mainWallet));
      expect(walletPair.guardianWallet, equals(guardianWallet));
      expect(walletPair.hasGuardian, isFalse);
    });

    test('empty wallet pair', () {
      final emptyWalletPair = WalletPair.empty();

      expect(emptyWalletPair.mainWallet, isA<EmptyWallet>());
      expect(emptyWalletPair.guardianWallet, isA<EmptyWallet>());
      expect(emptyWalletPair.hasGuardian, isFalse);
    });

    test('signTransaction with main and guardian wallets', () async {
      final mainWallet = await Wallet.fromMnemonic(mnemonic: mnemonic);
      final guardianWallet =
          await Wallet.fromMnemonic(mnemonic: mnemonic, isGuardian: true);
      final walletPair = WalletPair(mainWallet, guardianWallet: guardianWallet);

      final transaction = MockTransaction();
      final signedTransaction = walletPair.signTransaction(transaction);

      expect(signedTransaction.signature.hex, isNotEmpty);
      expect(signedTransaction.guardianSignature?.hex ?? '', isNotEmpty);
    });
  });
}
