import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';
import 'package:multiversx_sdk/src/transaction/token/token_roles.dart';

/// Base class for token special role transactions
@immutable
abstract base class TokenSpecialRoleTransaction extends TransactionWithData {
  /// Creates a new [TokenSpecialRoleTransaction] instance.
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
@immutable
base class TokenSpecialRoleTransactionData extends CustomTransactionData {
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

// ESDT Special Role Transactions
@immutable
final class SetEsdtSpecialRoleTransaction extends TokenSpecialRoleTransaction {
  SetEsdtSpecialRoleTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.identifier,
    required String addressToSetRole,
    required List<EsdtTokenRole> roles,
    super.gasLimit,
  }) : super(
          targetAddress: addressToSetRole,
          command: 'setSpecialRole',
          roles: roles.map((role) => role.value).toList(),
        );
}

@immutable
final class UnsetEsdtSpecialRoleTransaction
    extends TokenSpecialRoleTransaction {
  UnsetEsdtSpecialRoleTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.identifier,
    required String addressToUnsetRole,
    required List<EsdtTokenRole> roles,
    super.gasLimit,
  }) : super(
          targetAddress: addressToUnsetRole,
          command: 'unSetSpecialRole',
          roles: roles.map((role) => role.value).toList(),
        );
}

// NFT Special Role Transactions
@immutable
final class SetNftSpecialRoleTransaction extends TokenSpecialRoleTransaction {
  SetNftSpecialRoleTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.identifier,
    required String addressToSetRole,
    required List<NftTokenRole> roles,
    super.gasLimit,
  }) : super(
          targetAddress: addressToSetRole,
          command: 'setSpecialRole',
          roles: roles.map((role) => role.value).toList(),
        );
}

@immutable
final class UnsetNftSpecialRoleTransaction extends TokenSpecialRoleTransaction {
  UnsetNftSpecialRoleTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.identifier,
    required String addressToUnsetRole,
    required List<NftTokenRole> roles,
    super.gasLimit,
  }) : super(
          targetAddress: addressToUnsetRole,
          command: 'unSetSpecialRole',
          roles: roles.map((role) => role.value).toList(),
        );
}

// SFT Special Role Transactions
@immutable
final class SetSftSpecialRoleTransaction extends TokenSpecialRoleTransaction {
  SetSftSpecialRoleTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.identifier,
    required String addressToSetRole,
    required List<SftTokenRole> roles,
    super.gasLimit,
  }) : super(
          targetAddress: addressToSetRole,
          command: 'setSpecialRole',
          roles: roles.map((role) => role.value).toList(),
        );
}

@immutable
final class UnsetSftSpecialRoleTransaction extends TokenSpecialRoleTransaction {
  UnsetSftSpecialRoleTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.identifier,
    required String addressToUnsetRole,
    required List<SftTokenRole> roles,
    super.gasLimit,
  }) : super(
          targetAddress: addressToUnsetRole,
          command: 'unSetSpecialRole',
          roles: roles.map((role) => role.value).toList(),
        );
}
