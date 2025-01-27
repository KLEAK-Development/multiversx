import 'package:meta/meta.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';
import 'package:multiversx_sdk/src/transaction/smart_contract/function.dart';

/// A transaction class used to call smart contract functions on the MultiversX blockchain.
@immutable
final class CallSmartContractTransaction extends TransactionWithData {
  /// Creates a new smart contract call transaction.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address of the caller
  /// - [receiver]: The address of the smart contract
  /// - [function]: The name of the function to call
  /// - [arguments]: Optional list of arguments for the function call
  /// - [gasLimit]: Additional gas limit to add to base limit
  /// - [value]: Optional value to send with call (default is 0)
  CallSmartContractTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.receiver,
    required ContractFunction function,
    super.gasLimit = const GasLimit(0),
    Balance? value,
  }) : super(
          value: value ?? Balance.zero(),
          data: CallSmartContractTransactionData(
            function: function.name,
            arguments: function.arguments,
          ),
        );
}

/// Transaction data class specifically for smart contract calls.
@immutable
final class CallSmartContractTransactionData extends CustomTransactionData {
  /// Creates transaction data for calling a smart contract function.
  ///
  /// Parameters:
  /// - [function]: The name of the function to call
  /// - [arguments]: Optional list of arguments for the function call
  factory CallSmartContractTransactionData({
    required String function,
    List<dynamic> arguments = const [],
  }) {
    return CallSmartContractTransactionData._(
      command: function,
      arguments: arguments,
    );
  }

  CallSmartContractTransactionData._({
    required super.command,
    super.arguments,
  });
}
