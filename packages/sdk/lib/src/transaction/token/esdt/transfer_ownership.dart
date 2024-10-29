import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// Represents a transaction for transferring token ownership
@immutable
final class TransferOwnershipTransaction extends TransactionWithData {
  /// Creates a new [TransferOwnershipTransaction] instance.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address of the sender
  /// - [identifier]: The identifier of the token
  /// - [newOwner]: The address of the new token manager
  /// - [gasLimit]: Optional gas limit for the transaction (default is 0)
  TransferOwnershipTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String identifier,
    required String newOwner,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0),
          data: TransferOwnershipTransactionData(
            identifier: identifier,
            newOwner: newOwner,
          ),
        );
}

/// Represents the data for a transfer ownership transaction
@immutable
final class TransferOwnershipTransactionData extends CustomTransactionData {
  /// Creates a new [TransferOwnershipTransactionData] instance.
  ///
  /// Parameters:
  /// - [identifier]: The identifier of the token
  /// - [newOwner]: The address of the new token manager
  factory TransferOwnershipTransactionData({
    required String identifier,
    required String newOwner,
  }) {
    final arguments = [
      identifier,
      newOwner,
    ];

    return TransferOwnershipTransactionData._(
      command: 'transferOwnership',
      arguments: arguments,
    );
  }

  /// Private constructor for [TransferOwnershipTransactionData]
  TransferOwnershipTransactionData._({
    required super.command,
    super.arguments,
  });
}
