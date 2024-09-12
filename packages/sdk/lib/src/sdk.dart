import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_configuration.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/egld_transfer.dart';
import 'package:multiversx_sdk/src/transaction/esdt/esdt_nft_transfer.dart';
import 'package:multiversx_sdk/src/transaction/esdt/esdt_transfer.dart';
import 'package:multiversx_sdk/src/transaction/esdt/multi_esdt_nft_transfer.dart';
import 'package:multiversx_sdk/src/wallet.dart';

class Sdk {
  final ElrondApi _api;

  NetworkConfiguration networkConfiguration;

  Sdk(
    this._api, {
    this.networkConfiguration = const DevnetNetworkConfiguration(),
  });

  Future<SendTransactionResponse> sendTransaction({
    required WalletPair walletPair,
    required Transaction transaction,
  }) async {
    // Sign with main wallet
    var signedTransaction = walletPair.mainWallet.signTransaction(transaction);

    // If there's a guardian, sign with guardian wallet as well
    if (walletPair.hasGuardian) {
      signedTransaction =
          walletPair.guardianWallet.signTransaction(signedTransaction);
    }

    return _api.transactions.sendTransaction(signedTransaction.toRequest());
  }

  Future<SendTransactionResponse> egldTransfer({
    required WalletPair walletPair,
    required Balance amount,
    required PublicKey receiver,
  }) async {
    //  TODO(kevin): we should get nonce from blockchain
    final nonceSender = Nonce(1);

    final transaction = EgldTransferTransaction(
      networkConfiguration: networkConfiguration,
      nonce: nonceSender,
      sender: walletPair.mainWallet.publicKey,
      value: amount,
      receiver: receiver,
    );
    return sendTransaction(walletPair: walletPair, transaction: transaction);
  }

  Future<SendTransactionResponse> esdtTransfer({
    required WalletPair walletPair,
    required final PublicKey receiver,
    required final String identifier,
    required final Balance amount,
    final String methodName = '',
    final List<String> methodArguments = const [],
  }) async {
    //  TODO(kevin): we should get nonce from blockchain
    final nonceSender = Nonce.zero();

    final transaction = EsdtTransferTransaction(
      networkConfiguration: networkConfiguration,
      nonce: nonceSender,
      sender: walletPair.mainWallet.publicKey,
      receiver: receiver,
      identifier: identifier,
      amount: amount,
      methodName: methodName,
      methodArguments: methodArguments,
    );

    return sendTransaction(walletPair: walletPair, transaction: transaction);
  }

  Future<SendTransactionResponse> esdtNftTransfer({
    required WalletPair walletPair,
    required final PublicKey receiver,
    required final String identifier,
    required final Nonce nonce,
    required final Balance quantity,
  }) async {
    //  TODO(kevin): we should get nonce from blockchain
    final nonceSender = Nonce(2);

    final transaction = EsdtNftTransferTransaction(
      networkConfiguration: networkConfiguration,
      nonce: nonceSender,
      sender: walletPair.mainWallet.publicKey,
      receiver: receiver,
      identifier: identifier,
      nftNonce: nonce,
      quantity: quantity,
    );

    return sendTransaction(walletPair: walletPair, transaction: transaction);
  }

  Future<SendTransactionResponse> multiEsdtNftTransfer({
    required WalletPair walletPair,
    required final PublicKey receiver,
    required final List<TransferTokenWithQuantityAndNonce> tokens,
    final String methodName = '',
    final List<String> methodArguments = const [],
  }) async {
    //  TODO(kevin): we should get nonce from blockchain
    final nonceSender = Nonce(4);

    final transaction = MultiEsdtNftTransferTransaction(
      networkConfiguration: networkConfiguration,
      nonce: nonceSender,
      receiver: receiver,
      sender: walletPair.mainWallet.publicKey,
      tokens: tokens,
      methodName: methodName,
      methodArguments: methodArguments,
    );
    return sendTransaction(walletPair: walletPair, transaction: transaction);
  }
}

extension ToSendTransactionRequest on Transaction {
  SendTransactionRequest toRequest() {
    return SendTransactionRequest.fromJson(toMap());
  }
}
