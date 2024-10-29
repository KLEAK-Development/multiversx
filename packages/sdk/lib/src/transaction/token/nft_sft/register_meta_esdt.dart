import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';
import 'package:multiversx_sdk/src/transaction/token/token_properties.dart';

/// A transaction class used to register Meta ESDT tokens on the MultiversX blockchain.
///
/// This class provides functionality to create a transaction that will register a new Meta ESDT token.
/// The transaction requires a fixed fee of 0.05 EGLD and has a base gas limit of 60,000,000.
@immutable
final class RegisterMetaEsdtTransaction extends TransactionWithData {
  /// Creates a new Meta ESDT registration transaction.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration to use for the transaction
  /// - [nonce]: The sender's account nonce
  /// - [sender]: The address of the account registering the Meta ESDT
  /// - [tokenName]: The name of the Meta ESDT token
  /// - [tokenTicker]: The ticker symbol for the Meta ESDT token
  /// - [numDecimals]: The number of decimals for the token
  /// - [properties]: The properties defining the Meta ESDT token characteristics
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 60,000,000
  RegisterMetaEsdtTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenName,
    required String tokenTicker,
    required int numDecimals,
    required NftTokenProperties properties,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0.05),
          data: RegisterMetaEsdtTransactionData(
            tokenName: tokenName,
            tokenTicker: tokenTicker,
            numDecimals: numDecimals,
            properties: properties,
          ),
        );
}

/// Transaction data class specifically for Meta ESDT registration transactions.
///
/// This class handles the formatting of Meta ESDT registration data into the required
/// transaction data format, including the command and all necessary arguments.
@immutable
final class RegisterMetaEsdtTransactionData extends CustomTransactionData {
  /// Creates transaction data for registering a Meta ESDT token.
  ///
  /// Parameters:
  /// - [tokenName]: The name of the Meta ESDT token
  /// - [tokenTicker]: The ticker symbol for the Meta ESDT token
  /// - [numDecimals]: The number of decimals for the token
  /// - [properties]: The properties defining the Meta ESDT token characteristics
  factory RegisterMetaEsdtTransactionData({
    required String tokenName,
    required String tokenTicker,
    required int numDecimals,
    required NftTokenProperties properties,
  }) {
    final propertiesMap = properties.toMap();
    final arguments = [
      tokenName,
      tokenTicker,
      numDecimals,
      ...propertiesMap.entries.expand((entry) => [entry.key, entry.value])
    ];

    return RegisterMetaEsdtTransactionData._(
      command: 'registerMetaESDT',
      arguments: arguments,
    );
  }

  RegisterMetaEsdtTransactionData._({
    required super.command,
    super.arguments,
  });
}
