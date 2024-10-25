import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// Base class for token special role transactions
abstract base class TokenSpecialRoleTransaction extends TransactionWithData {
  /// Creates a new [TokenSpecialRoleTransaction] instance.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address of the sender
  /// - [identifier]: The identifier of the token
  /// - [targetAddress]: The address to modify roles for
  /// - [roles]: The list of roles to modify
  /// - [command]: The command to execute (setSpecialRole/unSetSpecialRole)
  /// - [gasLimit]: Optional gas limit for the transaction (default is 0)
  TokenSpecialRoleTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String identifier,
    required String targetAddress,
    required List<String> roles,
    required String command,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0),
          data: TokenSpecialRoleTransactionData(
            identifier: identifier,
            targetAddress: targetAddress,
            roles: roles,
            command: command,
          ),
        );
}

/// Base class for token special role transaction data
base class TokenSpecialRoleTransactionData extends CustomTransactionData {
  /// Creates a new [TokenSpecialRoleTransactionData] instance.
  ///
  /// Parameters:
  /// - [identifier]: The identifier of the token
  /// - [targetAddress]: The address to modify roles for
  /// - [roles]: The list of roles to modify
  /// - [command]: The command to execute (setSpecialRole/unSetSpecialRole)
  TokenSpecialRoleTransactionData({
    required String identifier,
    required String targetAddress,
    required List<String> roles,
    required super.command,
  }) : super(
          arguments: [
            identifier,
            targetAddress,
            ...roles,
          ],
        );
}

/// Represents a transaction for setting special roles for a token
final class SetSpecialRoleTransaction extends TokenSpecialRoleTransaction {
  /// Creates a new [SetSpecialRoleTransaction] instance.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address of the sender
  /// - [identifier]: The identifier of the token
  /// - [addressToSetRole]: The address to set roles for
  /// - [roles]: The list of roles to set
  /// - [gasLimit]: Optional gas limit for the transaction (default is 0)
  SetSpecialRoleTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.identifier,
    required String addressToSetRole,
    required super.roles,
    super.gasLimit,
  }) : super(
          targetAddress: addressToSetRole,
          command: 'setSpecialRole',
        );
}

/// Represents a transaction for unsetting special roles for a token
final class UnsetSpecialRoleTransaction extends TokenSpecialRoleTransaction {
  /// Creates a new [UnsetSpecialRoleTransaction] instance.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address of the sender
  /// - [identifier]: The identifier of the token
  /// - [addressToUnsetRole]: The address to unset roles for
  /// - [roles]: The list of roles to unset
  /// - [gasLimit]: Optional gas limit for the transaction (default is 0)
  UnsetSpecialRoleTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.identifier,
    required String addressToUnsetRole,
    required super.roles,
    super.gasLimit,
  }) : super(
          targetAddress: addressToUnsetRole,
          command: 'unSetSpecialRole',
        );
}
