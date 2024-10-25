import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// Represents a transaction for minting ESDT tokens locally
final class EsdtLocalMintTransaction extends TransactionWithData {
  /// Creates a new [EsdtLocalMintTransaction] instance.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address of the sender
  /// - [identifier]: The identifier of the ESDT token to mint
  /// - [supply]: The amount of tokens to mint
  /// - [gasLimit]: Optional gas limit for the transaction (default is 0)
  EsdtLocalMintTransaction({
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
          data: EsdtLocalMintTransactionData(
            identifier: identifier,
            supply: supply,
          ),
        );
}

/// Represents the data for an ESDT local mint transaction
final class EsdtLocalMintTransactionData extends CustomTransactionData {
  /// Creates a new [EsdtLocalMintTransactionData] instance.
  ///
  /// Parameters:
  /// - [identifier]: The identifier of the ESDT token to mint
  /// - [supply]: The amount of tokens to mint
  factory EsdtLocalMintTransactionData({
    required String identifier,
    required int supply,
  }) {
    final arguments = [
      identifier,
      supply,
    ];

    return EsdtLocalMintTransactionData._(
      command: 'ESDTLocalMint',
      arguments: arguments,
    );
  }

  /// Private constructor for [EsdtLocalMintTransactionData]
  EsdtLocalMintTransactionData._({
    required super.command,
    super.arguments,
  });
}
