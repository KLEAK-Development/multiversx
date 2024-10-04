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

  final NetworkConfiguration networkConfiguration;

  Sdk(
    this._api, {
    this.networkConfiguration = const DevnetNetworkConfiguration(),
  });

  Transaction createEGLDTransaction({
    required WalletPair walletPair,
    required Nonce nonce,
    required Balance amount,
    required PublicKey receiver,
  }) =>
      EgldTransferTransaction(
        networkConfiguration: networkConfiguration,
        nonce: nonce,
        sender: walletPair.mainWallet.publicKey,
        value: amount,
        receiver: receiver,
      );

  Transaction createESDTTransaction({
    required final WalletPair walletPair,
    required final Nonce nonce,
    required final PublicKey receiver,
    required final String identifier,
    required final Balance amount,
    final String methodName = '',
    final List<String> methodArguments = const [],
  }) =>
      EsdtTransferTransaction(
        networkConfiguration: networkConfiguration,
        nonce: nonce,
        sender: walletPair.mainWallet.publicKey,
        receiver: receiver,
        identifier: identifier,
        amount: amount,
        methodName: methodName,
        methodArguments: methodArguments,
      );

  Transaction createESDTNFTTransaction({
    required final WalletPair walletPair,
    required final PublicKey receiver,
    required final String identifier,
    required final Nonce nonce,
    required final Nonce nftNonce,
    required final Balance quantity,
  }) =>
      EsdtNftTransferTransaction(
        networkConfiguration: networkConfiguration,
        nonce: nonce,
        sender: walletPair.mainWallet.publicKey,
        receiver: receiver,
        identifier: identifier,
        nftNonce: nftNonce,
        quantity: quantity,
      );

  Transaction createMultiESDTNFTTransaction({
    required final WalletPair walletPair,
    required final PublicKey receiver,
    required final List<MultiTokenTransfer> tokens,
    required final Nonce nonce,
    final String methodName = '',
    final List<String> methodArguments = const [],
  }) =>
      MultiEsdtNftTransferTransaction(
        networkConfiguration: networkConfiguration,
        nonce: nonce,
        receiver: receiver,
        sender: walletPair.mainWallet.publicKey,
        tokens: tokens,
        methodName: methodName,
        methodArguments: methodArguments,
      );

  Transaction signTransaction({
    required final WalletPair walletPair,
    required final Transaction transaction,
  }) =>
      walletPair.signTransaction(transaction);

  Future<SendTransactionResponse> sendSignedTransaction({
    required final Transaction signedTransaction,
  }) =>
      _api.transactions.sendTransaction(signedTransaction.toRequest());

  Future<SendTransactionResponse> signAndSendTransaction({
    required final WalletPair walletPair,
    required final Transaction transaction,
  }) async {
    var signedTransaction = signTransaction(
      walletPair: walletPair,
      transaction: transaction,
    );
    return sendSignedTransaction(signedTransaction: signedTransaction);
  }

  @Deprecated('use sendEGLD instead')
  Future<SendTransactionResponse> egldTransfer({
    required final WalletPair walletPair,
    required final Balance amount,
    required final PublicKey receiver,
  }) =>
      sendEGLD(walletPair: walletPair, amount: amount, receiver: receiver);

  Future<SendTransactionResponse> sendEGLD({
    required final WalletPair walletPair,
    required final Balance amount,
    required final PublicKey receiver,
  }) async {
    //  TODO(kevin): we should get nonce from blockchain
    final nonce = Nonce(1);

    return signAndSendTransaction(
      walletPair: walletPair,
      transaction: createEGLDTransaction(
        walletPair: walletPair,
        amount: amount,
        receiver: receiver,
        nonce: nonce,
      ),
    );
  }

  @Deprecated('use sendESDT instead')
  Future<SendTransactionResponse> esdtTransfer({
    required final WalletPair walletPair,
    required final PublicKey receiver,
    required final String identifier,
    required final Balance amount,
    final String methodName = '',
    final List<String> methodArguments = const [],
  }) =>
      sendESDT(
        walletPair: walletPair,
        receiver: receiver,
        identifier: identifier,
        amount: amount,
        methodName: methodName,
        methodArguments: methodArguments,
      );

  Future<SendTransactionResponse> sendESDT({
    required final WalletPair walletPair,
    required final PublicKey receiver,
    required final String identifier,
    required final Balance amount,
    final String methodName = '',
    final List<String> methodArguments = const [],
  }) async {
    //  TODO(kevin): we should get nonce from blockchain
    final nonce = Nonce(20);

    return signAndSendTransaction(
      walletPair: walletPair,
      transaction: createESDTTransaction(
        walletPair: walletPair,
        receiver: receiver,
        identifier: identifier,
        amount: amount,
        nonce: nonce,
      ),
    );
  }

  @Deprecated('use sendESDTNFT instead')
  Future<SendTransactionResponse> esdtNftTransfer({
    required final WalletPair walletPair,
    required final Nonce nonce,
    required final PublicKey receiver,
    required final String identifier,
    required final Balance quantity,
  }) =>
      sendESDTNFT(
        walletPair: walletPair,
        receiver: receiver,
        identifier: identifier,
        nftNonce: nonce,
        quantity: quantity,
      );

  Future<SendTransactionResponse> sendESDTNFT({
    required final WalletPair walletPair,
    required final PublicKey receiver,
    required final String identifier,
    required final Nonce nftNonce,
    required final Balance quantity,
  }) async {
    //  TODO(kevin): we should get nonce from blockchain
    final nonce = Nonce(2);

    return signAndSendTransaction(
      walletPair: walletPair,
      transaction: createESDTNFTTransaction(
        walletPair: walletPair,
        receiver: receiver,
        identifier: identifier,
        nonce: nonce,
        nftNonce: nftNonce,
        quantity: quantity,
      ),
    );
  }

  @Deprecated('use sendMultiESDTNFT instead')
  Future<SendTransactionResponse> multiEsdtNftTransfer({
    required WalletPair walletPair,
    required final PublicKey receiver,
    required final List<MultiTokenTransfer> tokens,
    final String methodName = '',
    final List<String> methodArguments = const [],
  }) =>
      sendMultiESDTNFT(
        walletPair: walletPair,
        receiver: receiver,
        tokens: tokens,
        methodName: methodName,
        methodArguments: methodArguments,
      );

  Future<SendTransactionResponse> sendMultiESDTNFT({
    required WalletPair walletPair,
    required final PublicKey receiver,
    required final List<MultiTokenTransfer> tokens,
    final String methodName = '',
    final List<String> methodArguments = const [],
  }) async {
    //  TODO(kevin): we should get nonce from blockchain
    final nonce = Nonce(25);

    return signAndSendTransaction(
      walletPair: walletPair,
      transaction: createMultiESDTNFTTransaction(
        walletPair: walletPair,
        receiver: receiver,
        tokens: tokens,
        nonce: nonce,
      ),
    );
  }
}

extension ToSendTransactionRequest on Transaction {
  SendTransactionRequest toRequest() {
    return SendTransactionRequest.fromJson(toMap());
  }
}
