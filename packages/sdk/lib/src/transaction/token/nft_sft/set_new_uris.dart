import 'package:meta/meta.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to set new URIs for an ESDT token.
///
/// This transaction requires no fee but has a fixed gas limit of 60,000,000.
/// Only the token manager with ESDTRoleNFTSetNewURIs role can execute this transaction.
/// This operation will rewrite all existing URIs for the specified token.
@immutable
final class SetNewUrisTransaction extends TransactionWithData {
  /// Creates a new transaction to set new URIs for an ESDT token.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the token manager's account
  /// - [sender]: The address of the token manager
  /// - [tokenIdentifier]: The identifier of the ESDT token
  /// - [tokenNonce]: The nonce of the specific token
  /// - [uris]: List of new URIs to set for the token
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 60,000,000
  SetNewUrisTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenIdentifier,
    required Nonce tokenNonce,
    required List<Uri> uris,
    GasLimit gasLimit = const GasLimit(0),
  })  : assert(uris.isNotEmpty, 'At least one URI must be provided'),
        super(
          receiver: sender, // Same as sender
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0),
          data: SetNewUrisTransactionData(
            tokenIdentifier: tokenIdentifier,
            tokenNonce: tokenNonce,
            uris: uris,
          ),
        );
}

/// Transaction data class specifically for setting new URIs for an ESDT token.
///
/// This class handles the formatting of the URIs data into
/// the required transaction data format, including the command and all
/// necessary arguments in hexadecimal encoding.
@immutable
final class SetNewUrisTransactionData extends CustomTransactionData {
  /// Creates transaction data for setting new URIs.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the ESDT token
  /// - [tokenNonce]: The nonce of the specific token
  /// - [uris]: List of new URIs to set for the token
  factory SetNewUrisTransactionData({
    required String tokenIdentifier,
    required Nonce tokenNonce,
    required List<Uri> uris,
  }) {
    final arguments = [
      tokenIdentifier,
      tokenNonce,
      ...uris.map((uri) => uri.toString()),
    ];

    return SetNewUrisTransactionData._(
      command: 'ESDTSetNewURIs',
      arguments: arguments,
    );
  }

  SetNewUrisTransactionData._({
    required super.command,
    super.arguments,
  });
}
