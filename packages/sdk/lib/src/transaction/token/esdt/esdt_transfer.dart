import 'package:meta/meta.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// Represents an ESDT transfer transaction on the MultiversX blockchain.
///
/// This class extends [TransactionWithData] to create a transaction
/// specifically for transferring ESDT tokens.
@immutable
final class EsdtTransferTransaction extends TransactionWithData {
  /// Creates a new ESDT transfer transaction.
  ///
  /// [networkConfiguration] The network configuration for the transaction.
  /// [nonce] The nonce of the sender's account.
  /// [sender] The address of the sender.
  /// [receiver] The address of the receiver.
  /// [identifier] The identifier of the ESDT token.
  /// [amount] The amount of ESDT tokens to transfer.
  /// [gasLimit] The gas limit for the transaction (default is 0).
  /// [methodName] The name of the method to call on the receiver (optional).
  /// [methodArguments] The arguments for the method call (optional).
  EsdtTransferTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.receiver,
    required final String identifier,
    required final Balance amount,
    final GasLimit gasLimit = const GasLimit(0),
    final String methodName = '',
    final List<dynamic> methodArguments = const [],
  }) : super(
          gasLimit: gasLimit + GasLimit(500000),
          value: Balance.fromEgld(0),
          data: EsdtTranferTransactionData(
            identifier,
            amount,
            methodName: methodName,
            methodArguments: methodArguments,
          ),
        );
}

/// Represents the data for an ESDT transfer transaction.
///
/// This class extends [CustomTransactionData] to create the specific
/// data structure required for ESDT transfers.
@immutable
final class EsdtTranferTransactionData extends CustomTransactionData {
  /// Creates a new ESDT transfer transaction data object.
  ///
  /// [identifier] The identifier of the ESDT token.
  /// [balance] The amount of ESDT tokens to transfer.
  /// [methodName] The name of the method to call on the receiver (optional).
  /// [methodArguments] The arguments for the method call (optional).
  factory EsdtTranferTransactionData(
    final String identifier,
    final Balance balance, {
    final String methodName = '',
    final List<dynamic> methodArguments = const [],
  }) {
    final arguments = [
      identifier,
      balance,
      if (methodName.isNotEmpty) methodName,
      if (methodArguments.isNotEmpty) ...methodArguments
    ];
    return EsdtTranferTransactionData._(
      command: 'ESDTTransfer',
      arguments: arguments,
    );
  }

  /// Private constructor for creating an ESDT transfer transaction data object.
  ///
  /// [command] The command for the ESDT transfer (always 'ESDTTransfer').
  /// [arguments] The list of arguments for the ESDT transfer.
  EsdtTranferTransactionData._({required super.command, super.arguments});
}
