import 'package:meta/meta.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';

/// Represents a custom transaction on the MultiversX blockchain.
///
/// This class extends [TransactionWithData] to provide functionality
/// for creating transactions with custom commands and arguments.
@immutable
base class CustomTransaction extends TransactionWithData {
  /// Creates a new [CustomTransaction] instance.
  ///
  /// [networkConfiguration]: The network configuration for the transaction.
  /// [nonce]: The sender's account nonce.
  /// [value]: The amount of EGLD to transfer.
  /// [sender]: The address of the sender.
  /// [receiver]: The address of the receiver.
  /// [gasLimit]: The maximum amount of gas units allowed for the transaction.
  /// [command]: The custom command to be executed.
  /// [arguments]: Optional list of arguments for the command (default is an empty list).
  CustomTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.value,
    required super.sender,
    required super.receiver,
    required super.gasLimit,
    required final String command,
    final List<String> arguments = const [],
  }) : super(
          data: CustomTransactionData(
            command: command,
            arguments: arguments,
          ),
        );
}

/// Represents the data for a custom transaction.
///
/// This class extends [TransactionData] to handle the specific
/// data format required for custom transactions.
@immutable
base class CustomTransactionData extends TransactionData {
  /// Creates a new [CustomTransactionData] instance.
  ///
  /// [command]: The custom command to be executed.
  /// [arguments]: Optional list of arguments for the command (default is an empty list).
  CustomTransactionData({
    required final String command,
    final List<dynamic> arguments = const [],
  }) : super(
          transactionDataFromCommandAndArguments(
            command,
            arguments: mapTransactionDataArgumentsToString(arguments),
          ),
        );
}
