import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to convert SFT tokens to Meta ESDT tokens on the MultiversX blockchain.
///
/// This class provides functionality to create a transaction that will convert an existing SFT
/// to a Meta ESDT token. The transaction requires no fee but has a base gas limit of 60,000,000.
@immutable
final class ConvertSftToMetaEsdtTransaction extends TransactionWithData {
  /// Creates a new SFT to Meta ESDT conversion transaction.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration to use for the transaction
  /// - [nonce]: The sender's account nonce
  /// - [sender]: The address of the token manager
  /// - [tokenIdentifier]: The identifier of the SFT token to convert
  /// - [numDecimals]: The number of decimals for the resulting Meta ESDT token
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 60,000,000
  ConvertSftToMetaEsdtTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenIdentifier,
    required int numDecimals,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0),
          data: ConvertSftToMetaEsdtTransactionData(
            tokenIdentifier: tokenIdentifier,
            numDecimals: numDecimals,
          ),
        );
}

/// Transaction data class specifically for SFT to Meta ESDT conversion transactions.
///
/// This class handles the formatting of conversion data into the required
/// transaction data format, including the command and all necessary arguments.
@immutable
final class ConvertSftToMetaEsdtTransactionData extends CustomTransactionData {
  /// Creates transaction data for converting an SFT to Meta ESDT token.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the SFT token to convert
  /// - [numDecimals]: The number of decimals for the resulting Meta ESDT token
  factory ConvertSftToMetaEsdtTransactionData({
    required String tokenIdentifier,
    required int numDecimals,
  }) {
    final arguments = [
      tokenIdentifier,
      numDecimals,
    ];

    return ConvertSftToMetaEsdtTransactionData._(
      command: 'changeSFTToMetaESDT',
      arguments: arguments,
    );
  }

  ConvertSftToMetaEsdtTransactionData._({
    required super.command,
    super.arguments,
  });
}
