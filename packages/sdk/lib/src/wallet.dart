import 'dart:convert';

import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/sdk.dart';
import 'package:multiversx_sdk/src/signature.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/egld_transfer.dart';
import 'package:multiversx_sdk/src/transaction/esdt/esdt_nft_transfer.dart';
import 'package:multiversx_sdk/src/transaction/esdt/esdt_transfer.dart';
import 'package:multiversx_sdk/src/transaction/esdt/multi_esdt_nft_transfer.dart';

class Wallet {
  static Future<Wallet> fromMnemonic({
    required final Sdk sdk,
    required final String mnemonic,
  }) async {
    final bip44 = Bip44.fromMnemonic(mnemonic);
    final signingKey = await SigningKey.fromEntropy(bip44.entropy);

    //
    return Wallet._(bip44, signingKey, sdk);
  }

  final Bip44 _bip44;
  final SigningKey _signingKey;
  final Sdk _sdk;

  Wallet._(this._bip44, this._signingKey, this._sdk);

  String get entropy => _bip44.entropy;

  String get mnemonic => _bip44.mnemonic;

  PublicKey get publicKey => _signingKey.publicKey;

  Transaction signTransaction(final Transaction transaction) {
    final signature = _signingKey.sign(
      utf8.encode(json.encode(transaction.toMap())),
    );
    return transaction.copyWith(newSignature: Signature.fromBytes(signature));
  }

  Future<SendTransactionResponse> egldTransfer({
    required Balance amount,
    required PublicKey receiver,
  }) async {
    //  TODO(kevin): we should get nonce from blockchain
    final nonceSender = Nonce(1);

    final transaction = EgldTransferTransaction(
      networkConfiguration: _sdk.networkConfiguration,
      nonce: nonceSender,
      sender: publicKey,
      value: amount,
      receiver: receiver,
    );
    final signedTransaction = signTransaction(transaction);
    return _sdk.sendTransaction(signedTransaction: signedTransaction);
  }

  Future<SendTransactionResponse> esdtTransfer({
    required final PublicKey receiver,
    required final String identifier,
    required final Balance amount,
    final String methodName = '',
    final List<String> methodArguments = const [],
  }) async {
    //  TODO(kevin): we should get nonce from blockchain
    final nonceSender = Nonce.zero();

    final transaction = EsdtTransferTransaction(
      networkConfiguration: _sdk.networkConfiguration,
      nonce: nonceSender,
      sender: publicKey,
      receiver: receiver,
      identifier: identifier,
      amount: amount,
      methodName: methodName,
      methodArguments: methodArguments,
    );

    final signedTransaction = signTransaction(transaction);
    return _sdk.sendTransaction(signedTransaction: signedTransaction);
  }

  Future<SendTransactionResponse> esdtNftTransfer({
    required final PublicKey receiver,
    required final String identifier,
    required final Nonce nonce,
    required final Balance quantity,
  }) async {
    //  TODO(kevin): we should get nonce from blockchain
    final nonceSender = Nonce(2);

    final transaction = EsdtNftTransferTransaction(
      networkConfiguration: _sdk.networkConfiguration,
      nonce: nonceSender,
      sender: publicKey,
      receiver: receiver,
      identifier: identifier,
      nftNonce: nonce,
      quantity: quantity,
    );

    final signedTransaction = signTransaction(transaction);
    return _sdk.sendTransaction(signedTransaction: signedTransaction);
  }

  Future<SendTransactionResponse> multiEsdtNftTransfer({
    required final PublicKey receiver,
    required final List<TransferTokenWithQuantityAndNonce> tokens,
    final String methodName = '',
    final List<String> methodArguments = const [],
  }) async {
    //  TODO(kevin): we should get nonce from blockchain
    final nonceSender = Nonce(4);

    final transaction = MultiEsdtNftTransferTransaction(
      networkConfiguration: _sdk.networkConfiguration,
      nonce: nonceSender,
      receiver: receiver,
      sender: publicKey,
      tokens: tokens,
      methodName: methodName,
      methodArguments: methodArguments,
    );
    final signedTransaction = signTransaction(transaction);
    return _sdk.sendTransaction(signedTransaction: signedTransaction);
  }
}
