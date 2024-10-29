import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to change a token type to dynamic on the MultiversX blockchain.
///
/// This transaction requires the sender to be the token manager and has a base gas limit
/// of 60,000,000 units. Note that this operation cannot be performed on FungibleESDT,
/// NonFungibleESDT, or NonFungibleESDTv2 tokens.
@immutable
final class ChangeToDynamicTransaction extends TransactionWithData {
  /// Creates a new transaction to change a token type to dynamic.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the token manager's account
  /// - [sender]: The address of the token manager
  /// - [tokenIdentifier]: The identifier of the token to change
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 60,000,000
  ChangeToDynamicTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenIdentifier,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0),
          data: ChangeToDynamicTransactionData(
            tokenIdentifier: tokenIdentifier,
          ),
        );
}

/// Transaction data class specifically for changing token type to dynamic.
///
/// This class handles the formatting of the change to dynamic data into
/// the required transaction data format, including the command and the
/// token identifier argument.
@immutable
final class ChangeToDynamicTransactionData extends CustomTransactionData {
  /// Creates transaction data for changing token type to dynamic.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the token to change
  factory ChangeToDynamicTransactionData({
    required String tokenIdentifier,
  }) {
    final arguments = [tokenIdentifier];

    return ChangeToDynamicTransactionData._(
      command: 'changeToDynamic',
      arguments: arguments,
    );
  }

  ChangeToDynamicTransactionData._({
    required super.command,
    super.arguments,
  });
}
