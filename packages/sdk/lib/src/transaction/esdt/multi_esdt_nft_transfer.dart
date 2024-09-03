import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// Represents a token transfer with quantity and nonce information.
class TransferTokenWithQuantityAndNonce {
  /// The identifier of the token.
  final String identifier;

  /// The nonce of the token.
  final Nonce nonce;

  /// The quantity of the token to be transferred.
  final Balance quantity;

  /// Creates a new instance of [TransferTokenWithQuantityAndNonce].
  ///
  /// [identifier]: The token identifier.
  /// [nonce]: The token nonce.
  /// [quantity]: The quantity of the token to transfer.
  const TransferTokenWithQuantityAndNonce({
    required this.identifier,
    required this.nonce,
    required this.quantity,
  });
}

/// Represents a multi ESDT/NFT transfer transaction.
final class MultiEsdtNftTransferTransaction
    extends TransactionWithNetworkConfiguration {
  /// Creates a new instance of [MultiEsdtNftTransferTransaction].
  ///
  /// [networkConfiguration]: The network configuration for the transaction.
  /// [nonce]: The nonce of the sender's account.
  /// [sender]: The address of the sender.
  /// [receiver]: The public key of the receiver.
  /// [tokens]: A list of tokens to be transferred.
  /// [gasLimit]: The gas limit for the transaction (default is 0).
  /// [methodName]: The name of the method to be called (optional).
  /// [methodArguments]: The arguments for the method call (optional).
  MultiEsdtNftTransferTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required PublicKey receiver,
    required final List<TransferTokenWithQuantityAndNonce> tokens,
    final GasLimit gasLimit = const GasLimit(0),
    final String methodName = '',
    final List<dynamic> methodArguments = const [],
  }) : super(
          receiver: sender,
          gasLimit: gasLimit +
              (GasLimit(1100000) * tokens.length) +
              (methodName.isNotEmpty ? GasLimit(6000000) : GasLimit(0)),
          value: Balance.fromEgld(0),
          data: MultiEsdtNftTranferTransactionData(
            receiver,
            tokens,
            methodName: methodName,
            methodArguments: methodArguments,
          ),
        );
}

/// Represents the data for a multi ESDT/NFT transfer transaction.
final class MultiEsdtNftTranferTransactionData extends CustomTransactionData {
  /// Creates a new instance of [MultiEsdtNftTranferTransactionData].
  ///
  /// [receiver]: The public key of the receiver.
  /// [tokens]: A list of tokens to be transferred.
  /// [methodName]: The name of the method to be called (optional).
  /// [methodArguments]: The arguments for the method call (optional).
  factory MultiEsdtNftTranferTransactionData(
    final PublicKey receiver,
    final List<TransferTokenWithQuantityAndNonce> tokens, {
    final String methodName = '',
    final List<dynamic> methodArguments = const [],
  }) {
    final arguments = [
      receiver,
      tokens.length,
      for (final token in tokens) ...[
        token.identifier,
        token.nonce,
        token.quantity
      ],
      if (methodName.isNotEmpty) methodName,
      if (methodArguments.isNotEmpty) ...methodArguments
    ];
    return MultiEsdtNftTranferTransactionData._(
      command: 'MultiESDTNFTTransfer',
      arguments: arguments,
    );
  }

  /// Private constructor for [MultiEsdtNftTranferTransactionData].
  MultiEsdtNftTranferTransactionData._({
    required super.command,
    super.arguments,
  });
}
