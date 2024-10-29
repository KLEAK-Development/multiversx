import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';
import 'package:multiversx_sdk/src/transaction/token/token_properties.dart';

/// A transaction for issuing a new ESDT token on the MultiversX blockchain.
///
/// This transaction requires a fixed fee of 0.05 EGLD and has a base gas limit
/// of 60,000,000 gas units.
@immutable
final class IssueEsdtTransaction extends TransactionWithData {
  /// Creates a new ESDT token issuance transaction.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration to use
  /// - [nonce]: The sender's account nonce
  /// - [sender]: The transaction sender's address
  /// - [tokenName]: The name of the token to issue
  /// - [tokenTicker]: The ticker/symbol for the token
  /// - [initialSupply]: Initial token supply
  /// - [numDecimals]: Number of decimals for the token
  /// - [properties]: Additional token properties/configuration
  /// - [gasLimit]: Additional gas limit on top of base 60M units
  IssueEsdtTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenName,
    required String tokenTicker,
    required int initialSupply,
    required int numDecimals,
    required EsdtTokenProperties properties,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0.05),
          data: IssueEsdtTransactionData(
            tokenName: tokenName,
            tokenTicker: tokenTicker,
            initialSupply: initialSupply,
            numDecimals: numDecimals,
            properties: properties,
          ),
        );
}

/// The transaction data payload for an ESDT token issuance transaction.
@immutable
final class IssueEsdtTransactionData extends CustomTransactionData {
  /// Creates the transaction data for issuing a new ESDT token.
  ///
  /// Parameters:
  /// - [tokenName]: The name of the token to issue
  /// - [tokenTicker]: The ticker/symbol for the token
  /// - [initialSupply]: Initial token supply
  /// - [numDecimals]: Number of decimals for the token
  /// - [properties]: Additional token properties/configuration
  factory IssueEsdtTransactionData({
    required String tokenName,
    required String tokenTicker,
    required int initialSupply,
    required int numDecimals,
    required EsdtTokenProperties properties,
  }) {
    final propertiesMap = properties.toMap();
    final arguments = [
      tokenName,
      tokenTicker,
      initialSupply,
      numDecimals,
      ...propertiesMap.entries.expand((entry) => [entry.key, entry.value])
    ];

    return IssueEsdtTransactionData._(
      command: 'issue',
      arguments: arguments,
    );
  }

  IssueEsdtTransactionData._({
    required super.command,
    super.arguments,
  });
}
