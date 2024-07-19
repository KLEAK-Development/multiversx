import 'dart:convert';

import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/signature.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';

class Wallet {
  static Future<Wallet> fromMnemonic(final String mnemonic) async {
    final bip44 = Bip44.fromMnemonic(mnemonic);
    final signingKey = await SigningKey.fromEntropy(bip44.entropy);
    return Wallet._(bip44, signingKey);
  }

  final Bip44 _bip44;
  final SigningKey _signingKey;

  Wallet._(this._bip44, this._signingKey);

  String get entropy => _bip44.entropy;

  String get mnemonic => _bip44.mnemonic;

  PublicKey get publicKey => _signingKey.publicKey;

  Future<void> init() async {}

  Transaction signTransaction(final Transaction transaction) {
    final signature = _signingKey.sign(
      utf8.encode(json.encode(transaction.toMap())),
    );
    return transaction.copyWith(
      newSignature: Signature.fromBytes(signature),
    );
  }
}
