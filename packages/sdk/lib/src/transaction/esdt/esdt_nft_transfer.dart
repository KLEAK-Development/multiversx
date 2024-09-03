import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class for transferring ESDT NFTs (Non-Fungible Tokens).
///
/// This class extends [TransactionWithData] and is used to create transactions
/// for transferring ESDT NFTs on the MultiversX blockchain.
final class EsdtNftTransferTransaction extends TransactionWithData {
  /// Creates a new [EsdtNftTransferTransaction].
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction.
  /// - [nonce]: The nonce of the sender's account.
  /// - [sender]: The address of the sender.
  /// - [receiver]: The public key of the receiver.
  /// - [identifier]: The identifier of the ESDT NFT.
  /// - [nftNonce]: The nonce of the NFT.
  /// - [quantity]: The quantity of NFTs to transfer.
  /// - [gasLimit]: The gas limit for the transaction (default is 0).
  /// - [methodName]: The name of the method to call on the receiver (optional).
  /// - [methodArguments]: The arguments for the method call (optional).
  EsdtNftTransferTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required final PublicKey receiver,
    required final String identifier,
    required final Nonce nftNonce,
    required final Balance quantity,
    GasLimit gasLimit = const GasLimit(0),
    final String methodName = '',
    final List<dynamic> methodArguments = const [],
  }) : super(
          gasLimit: gasLimit + GasLimit(1000000),
          receiver: sender,
          value: Balance.fromEgld(0),
          data: EsdtNftTranferTransactionData(
            identifier,
            nftNonce,
            quantity,
            receiver,
            methodName: methodName,
            methodArguments: methodArguments,
          ),
        );
}

/// A custom transaction data class for ESDT NFT transfers.
///
/// This class extends [CustomTransactionData] and is used to create
/// the data payload for ESDT NFT transfer transactions.
final class EsdtNftTranferTransactionData extends CustomTransactionData {
  /// Creates a new [EsdtNftTranferTransactionData] instance.
  ///
  /// Parameters:
  /// - [identifier]: The identifier of the ESDT NFT.
  /// - [nonce]: The nonce of the NFT.
  /// - [quantity]: The quantity of NFTs to transfer.
  /// - [receiver]: The public key of the receiver.
  /// - [methodName]: The name of the method to call on the receiver (optional).
  /// - [methodArguments]: The arguments for the method call (optional).
  factory EsdtNftTranferTransactionData(
    final String identifier,
    final Nonce nonce,
    final Balance quantity,
    final PublicKey receiver, {
    final String methodName = '',
    final List<dynamic> methodArguments = const [],
  }) {
    final arguments = [
      identifier,
      nonce,
      quantity,
      receiver,
      if (methodName.isNotEmpty) methodName,
      if (methodArguments.isNotEmpty) ...methodArguments
    ];
    return EsdtNftTranferTransactionData._(
      command: 'ESDTNFTTransfer',
      arguments: arguments,
    );
  }

  /// Private constructor for [EsdtNftTranferTransactionData].
  ///
  /// This constructor is used internally by the factory constructor.
  EsdtNftTranferTransactionData._({
    required super.command,
    super.arguments,
  });
}
