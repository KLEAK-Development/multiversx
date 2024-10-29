import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';
import 'package:multiversx_sdk/src/transaction/token/token_properties.dart';

/// A transaction class used to issue semi-fungible tokens (SFTs) on the MultiversX blockchain.
///
/// This class provides functionality to create a transaction that will issue a new SFT collection.
/// The transaction requires a fixed fee of 0.05 EGLD and has a base gas limit of 60,000,000.
@immutable
final class IssueSemiFungibleTransaction extends TransactionWithData {
  /// Creates a new SFT issuance transaction.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration to use for the transaction
  /// - [nonce]: The sender's account nonce
  /// - [sender]: The address of the account issuing the SFT
  /// - [tokenName]: The name of the SFT collection
  /// - [tokenTicker]: The ticker symbol for the SFT collection
  /// - [properties]: The properties defining the SFT collection characteristics
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 60,000,000
  IssueSemiFungibleTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenName,
    required String tokenTicker,
    required NftTokenProperties properties,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0.05),
          data: IssueSemiFungibleTransactionData(
            tokenName: tokenName,
            tokenTicker: tokenTicker,
            properties: properties,
          ),
        );
}

/// Transaction data class specifically for SFT issuance transactions.
///
/// This class handles the formatting of SFT issuance data into the required
/// transaction data format, including the command and all necessary arguments.
@immutable
final class IssueSemiFungibleTransactionData extends CustomTransactionData {
  /// Creates transaction data for issuing an SFT collection.
  ///
  /// Parameters:
  /// - [tokenName]: The name of the SFT collection
  /// - [tokenTicker]: The ticker symbol for the SFT collection
  /// - [properties]: The properties defining the SFT collection characteristics
  factory IssueSemiFungibleTransactionData({
    required String tokenName,
    required String tokenTicker,
    required NftTokenProperties properties,
  }) {
    final propertiesMap = properties.toMap();
    final arguments = [
      tokenName,
      tokenTicker,
      ...propertiesMap.entries.expand((entry) => [entry.key, entry.value])
    ];

    return IssueSemiFungibleTransactionData._(
      command: 'issueSemiFungible',
      arguments: arguments,
    );
  }

  IssueSemiFungibleTransactionData._({
    required super.command,
    super.arguments,
  });
}
