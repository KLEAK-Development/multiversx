import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_configuration.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/token/egld/egld_transfer.dart';
import 'package:multiversx_sdk/src/transaction/token/esdt/esdt_transfer.dart';
import 'package:multiversx_sdk/src/transaction/token/esdt_nft_transfer.dart';
import 'package:multiversx_sdk/src/transaction/token/multi_esdt_nft_transfer.dart';
import 'package:multiversx_sdk/src/transaction/token/nft_sft/issue_non_fungible.dart';
import 'package:multiversx_sdk/src/wallet.dart';

/// A class that provides methods for interacting with the MultiversX blockchain.
///
/// This class includes functionality for creating and sending various types of transactions,
/// including EGLD transfers, ESDT transfers, NFT transfers, and more.
class Sdk {
  final MultiverXApi _api;

  /// The network configuration used for transactions.
  final NetworkConfiguration networkConfiguration;

  /// Creates a new instance of the Sdk class.
  ///
  /// [_api]: The MultiversX API instance to use for network operations.
  /// [networkConfiguration]: The network configuration to use. Defaults to DevnetNetworkConfiguration.
  Sdk(
    this._api, {
    this.networkConfiguration = const DevnetNetworkConfiguration(),
  });

  /// Creates an EGLD transfer transaction.
  ///
  /// [walletPair]: The wallet pair to use for the transaction.
  /// [nonce]: The nonce of the transaction.
  /// [amount]: The amount of EGLD to transfer.
  /// [receiver]: The public key of the receiver.
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

  /// Creates an ESDT transfer transaction.
  ///
  /// [walletPair]: The wallet pair to use for the transaction.
  /// [nonce]: The nonce of the transaction.
  /// [receiver]: The public key of the receiver.
  /// [identifier]: The identifier of the ESDT token.
  /// [amount]: The amount of ESDT tokens to transfer.
  /// [methodName]: Optional method name for smart contract calls.
  /// [methodArguments]: Optional method arguments for smart contract calls.
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

  /// Creates an ESDT NFT transfer transaction.
  ///
  /// [walletPair]: The wallet pair to use for the transaction.
  /// [receiver]: The public key of the receiver.
  /// [identifier]: The identifier of the ESDT NFT.
  /// [nonce]: The nonce of the transaction.
  /// [nftNonce]: The nonce of the NFT.
  /// [quantity]: The quantity of NFTs to transfer.
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

  /// Creates a multi ESDT NFT transfer transaction.
  ///
  /// [walletPair]: The wallet pair to use for the transaction.
  /// [nonce]: The nonce of the transaction.
  /// [receiver]: The public key of the receiver.
  /// [tokens]: A list of MultiTokenTransfer objects representing the tokens to transfer.
  /// [methodName]: Optional method name for smart contract calls.
  /// [methodArguments]: Optional method arguments for smart contract calls.
  Transaction createMultiESDTNFTTransaction({
    required final WalletPair walletPair,
    required final Nonce nonce,
    required final PublicKey receiver,
    required final List<MultiTokenTransfer> tokens,
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

  /// Creates a transaction to issue a non-fungible token.
  ///
  /// [walletPair]: The wallet pair to use for the transaction.
  /// [nonce]: The nonce of the transaction.
  /// [tokenName]: The name of the token to issue.
  /// [tokenTicker]: The ticker of the token to issue.
  /// [canFreeze], [canWipe], [canPause], [canTransferNFTCreateRole], [canChangeOwner], [canUpgrade], [canAddSpecialRoles]:
  /// Optional boolean flags to set various permissions for the token.
  Transaction issueNonFungibleTransaction({
    required final WalletPair walletPair,
    required final Nonce nonce,
    required final String tokenName,
    required final String tokenTicker,
    final bool? canFreeze,
    final bool? canWipe,
    final bool? canPause,
    final bool? canTransferNFTCreateRole,
    final bool? canChangeOwner,
    final bool? canUpgrade,
    final bool? canAddSpecialRoles,
  }) =>
      IssueNonFungibleTransaction(
        networkConfiguration: networkConfiguration,
        sender: walletPair.mainWallet.publicKey,
        nonce: nonce,
        tokenName: tokenName,
        tokenTicker: tokenTicker,
        canFreeze: canFreeze,
        canWipe: canWipe,
        canPause: canPause,
        canTransferNFTCreateRole: canTransferNFTCreateRole,
        canChangeOwner: canChangeOwner,
        canUpgrade: canUpgrade,
        canAddSpecialRoles: canAddSpecialRoles,
      );

  /// Signs a transaction with the given wallet pair.
  ///
  /// [walletPair]: The wallet pair to use for signing.
  /// [transaction]: The transaction to sign.
  Transaction signTransaction({
    required final WalletPair walletPair,
    required final Transaction transaction,
  }) =>
      walletPair.signTransaction(transaction);

  /// Sends a signed transaction to the network.
  ///
  /// [signedTransaction]: The signed transaction to send.
  Future<SendTransactionResponse> sendSignedTransaction({
    required final Transaction signedTransaction,
  }) =>
      _api.transactions.sendTransaction(signedTransaction.toRequest());

  /// Signs and sends a transaction to the network.
  ///
  /// [walletPair]: The wallet pair to use for signing.
  /// [transaction]: The transaction to sign and send.
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

  /// Submits a transaction to issue a non-fungible token.
  ///
  /// This method combines creating, signing, and sending the transaction.
  ///
  /// Parameters are the same as in [issueNonFungibleTransaction].
  Future<SendTransactionResponse> submitIssueNonFungibleTransaction({
    required final WalletPair walletPair,
    required final Nonce nonce,
    required final String tokenName,
    required final String tokenTicker,
    final bool? canFreeze,
    final bool? canWipe,
    final bool? canPause,
    final bool? canTransferNFTCreateRole,
    final bool? canChangeOwner,
    final bool? canUpgrade,
    final bool? canAddSpecialRoles,
  }) async {
    return signAndSendTransaction(
      walletPair: walletPair,
      transaction: issueNonFungibleTransaction(
        walletPair: walletPair,
        nonce: nonce,
        tokenName: tokenName,
        tokenTicker: tokenTicker,
        canFreeze: canFreeze,
        canWipe: canWipe,
        canPause: canPause,
        canTransferNFTCreateRole: canTransferNFTCreateRole,
        canChangeOwner: canChangeOwner,
        canUpgrade: canUpgrade,
        canAddSpecialRoles: canAddSpecialRoles,
      ),
    );
  }

  /// Sends EGLD to a receiver.
  ///
  /// This method combines creating, signing, and sending the transaction.
  ///
  /// [walletPair]: The wallet pair to use for the transaction.
  /// [nonce]: The nonce of the transaction.
  /// [amount]: The amount of EGLD to send.
  /// [receiver]: The public key of the receiver.
  Future<SendTransactionResponse> sendEGLD({
    required final WalletPair walletPair,
    required final Nonce nonce,
    required final Balance amount,
    required final PublicKey receiver,
  }) async {
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

  /// Sends ESDT tokens to a receiver.
  ///
  /// This method combines creating, signing, and sending the transaction.
  ///
  /// Parameters are the same as in [createESDTTransaction].
  Future<SendTransactionResponse> sendESDT({
    required final WalletPair walletPair,
    required final Nonce nonce,
    required final PublicKey receiver,
    required final String identifier,
    required final Balance amount,
    final String methodName = '',
    final List<String> methodArguments = const [],
  }) async {
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

  /// Sends ESDT NFT tokens to a receiver.
  ///
  /// This method combines creating, signing, and sending the transaction.
  ///
  /// Parameters are the same as in [createESDTNFTTransaction].
  Future<SendTransactionResponse> sendESDTNFT({
    required final WalletPair walletPair,
    required final Nonce nonce,
    required final PublicKey receiver,
    required final String identifier,
    required final Nonce nftNonce,
    required final Balance quantity,
  }) async {
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

  /// Sends multiple ESDT NFT tokens to a receiver.
  ///
  /// This method combines creating, signing, and sending the transaction.
  ///
  /// Parameters are the same as in [createMultiESDTNFTTransaction].
  Future<SendTransactionResponse> sendMultiESDTNFT({
    required WalletPair walletPair,
    required final Nonce nonce,
    required final PublicKey receiver,
    required final List<MultiTokenTransfer> tokens,
    final String methodName = '',
    final List<String> methodArguments = const [],
  }) async {
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

/// Extension on Transaction to convert it to a SendTransactionRequest.
extension ToSendTransactionRequest on Transaction {
  /// Converts the transaction to a SendTransactionRequest.
  SendTransactionRequest toRequest() {
    return SendTransactionRequest.fromJson(toMap());
  }
}
