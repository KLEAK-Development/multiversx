import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';
import 'package:multiversx_sdk/src/transaction/token/token_properties.dart';

/// A transaction that upgrades a token's properties on the MultiversX network.
///
/// This transaction is used to modify the properties of an existing token by sending
/// a transaction to the system smart contract responsible for token management.
@immutable
final class UpgradeTokenTransaction extends TransactionWithData {
  /// Creates a new token upgrade transaction.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The sender's account nonce
  /// - [sender]: The address of the sender
  /// - [identifier]: The token identifier to upgrade
  /// - [properties]: The new properties to set for the token
  /// - [gasLimit]: Optional gas limit for the transaction (default is 0)
  UpgradeTokenTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String identifier,
    required EsdtTokenProperties properties,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0),
          data: UpgradeTokenTransactionData(
            identifier: identifier,
            properties: properties,
          ),
        );
}

/// Represents the data payload for a token upgrade transaction.
///
/// This class encapsulates the data needed to upgrade a token's properties,
/// formatting it appropriately for the blockchain transaction.
@immutable
final class UpgradeTokenTransactionData extends CustomTransactionData {
  /// Creates a new token upgrade transaction data payload.
  ///
  /// Parameters:
  /// - [identifier]: The token identifier to upgrade
  /// - [properties]: The new properties to set for the token
  factory UpgradeTokenTransactionData({
    required String identifier,
    required EsdtTokenProperties properties,
  }) {
    final propertiesMap = properties.toMap();
    final arguments = [
      identifier,
      ...propertiesMap.entries.expand((entry) => [entry.key, entry.value]),
    ];

    return UpgradeTokenTransactionData._(
      command: 'controlChanges',
      arguments: arguments,
    );
  }

  UpgradeTokenTransactionData._({
    required super.command,
    super.arguments,
  });
}
