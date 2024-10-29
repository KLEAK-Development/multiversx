import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// Base class for token freeze/unfreeze transactions
@immutable
abstract base class TokenFreezeStateTransaction extends TransactionWithData {
  /// Creates a new [TokenFreezeStateTransaction] instance.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address of the sender
  /// - [identifier]: The identifier of the token
  /// - [targetAddress]: The address of the account to modify freeze state
  /// - [command]: The command to execute (freeze/unFreeze)
  /// - [gasLimit]: Optional gas limit for the transaction (default is 0)
  TokenFreezeStateTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String identifier,
    required String targetAddress,
    required String command,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0),
          data: TokenFreezeStateTransactionData(
            identifier: identifier,
            targetAddress: targetAddress,
            command: command,
          ),
        );
}

/// Base class for token freeze/unfreeze transaction data
@immutable
base class TokenFreezeStateTransactionData extends CustomTransactionData {
  /// Creates a new [TokenFreezeStateTransactionData] instance.
  ///
  /// Parameters:
  /// - [identifier]: The identifier of the token
  /// - [targetAddress]: The address of the account to modify freeze state
  /// - [command]: The command to execute (freeze/unFreeze)
  TokenFreezeStateTransactionData({
    required String identifier,
    required String targetAddress,
    required super.command,
  }) : super(
          arguments: [identifier, targetAddress],
        );
}

/// Represents a transaction for freezing an ESDT token for a specific account
@immutable
final class FreezeTokenTransaction extends TokenFreezeStateTransaction {
  /// Creates a new [FreezeTokenTransaction] instance.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address of the sender
  /// - [identifier]: The identifier of the token to freeze
  /// - [addressToFreeze]: The address of the account to freeze the token for
  /// - [gasLimit]: Optional gas limit for the transaction (default is 0)
  FreezeTokenTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.identifier,
    required String addressToFreeze,
    super.gasLimit,
  }) : super(
          targetAddress: addressToFreeze,
          command: 'freeze',
        );
}

/// Represents a transaction for unfreezing an ESDT token for a specific account
@immutable
final class UnfreezeTokenTransaction extends TokenFreezeStateTransaction {
  /// Creates a new [UnfreezeTokenTransaction] instance.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address of the sender
  /// - [identifier]: The identifier of the token to unfreeze
  /// - [addressToUnfreeze]: The address of the account to unfreeze the token for
  /// - [gasLimit]: Optional gas limit for the transaction (default is 0)
  UnfreezeTokenTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.identifier,
    required String addressToUnfreeze,
    super.gasLimit,
  }) : super(
          targetAddress: addressToUnfreeze,
          command: 'unFreeze',
        );
}
