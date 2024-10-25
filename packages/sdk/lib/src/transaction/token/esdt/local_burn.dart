import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// Represents a transaction for burning ESDT tokens locally
final class EsdtLocalBurnTransaction extends TransactionWithData {
  /// Creates a new [EsdtLocalBurnTransaction] instance.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address of the sender
  /// - [identifier]: The identifier of the ESDT token to burn
  /// - [supply]: The amount of tokens to burn
  /// - [gasLimit]: Optional gas limit for the transaction (default is 0)
  EsdtLocalBurnTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String identifier,
    required int supply,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: sender,
          gasLimit: gasLimit + const GasLimit(300000),
          value: Balance.fromEgld(0),
          data: EsdtLocalBurnTransactionData(
            identifier: identifier,
            supply: supply,
          ),
        );
}

/// Represents the data for an ESDT local burn transaction
final class EsdtLocalBurnTransactionData extends CustomTransactionData {
  /// Creates a new [EsdtLocalBurnTransactionData] instance.
  ///
  /// Parameters:
  /// - [identifier]: The identifier of the ESDT token to burn
  /// - [supply]: The amount of tokens to burn
  factory EsdtLocalBurnTransactionData({
    required String identifier,
    required int supply,
  }) {
    final arguments = [
      identifier,
      supply,
    ];

    return EsdtLocalBurnTransactionData._(
      command: 'ESDTLocalBurn',
      arguments: arguments,
    );
  }

  /// Private constructor for [EsdtLocalBurnTransactionData]
  EsdtLocalBurnTransactionData._({
    required super.command,
    super.arguments,
  });
}
