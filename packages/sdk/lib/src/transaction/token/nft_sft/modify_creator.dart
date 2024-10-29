import 'package:meta/meta.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to modify the creator of a token.
///
/// This transaction requires no fee but has a fixed gas limit of 60,000,000.
/// Only an account with ESDTRoleModifyCreator role can execute this transaction.
/// The token must be of dynamic type for this operation to work.
/// This operation will move the token to the new creator account.
@immutable
final class ModifyCreatorTransaction extends TransactionWithData {
  /// Creates a new transaction to modify the token creator.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the new creator's account
  /// - [sender]: The address of the new creator (must have ESDTRoleModifyCreator role)
  /// - [tokenIdentifier]: The identifier of the token
  /// - [tokenNonce]: The nonce of the specific token
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 60,000,000
  ModifyCreatorTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenIdentifier,
    required Nonce tokenNonce,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: sender, // Same as sender
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0),
          data: ModifyCreatorTransactionData(
            tokenIdentifier: tokenIdentifier,
            tokenNonce: tokenNonce,
          ),
        );
}

/// Transaction data class specifically for modifying token creator.
///
/// This class handles the formatting of the modify creator data into
/// the required transaction data format, including the command and all
/// necessary arguments in hexadecimal encoding.
@immutable
final class ModifyCreatorTransactionData extends CustomTransactionData {
  /// Creates transaction data for modifying token creator.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the token
  /// - [tokenNonce]: The nonce of the specific token
  factory ModifyCreatorTransactionData({
    required String tokenIdentifier,
    required Nonce tokenNonce,
  }) {
    final arguments = [
      tokenIdentifier,
      tokenNonce,
    ];

    return ModifyCreatorTransactionData._(
      command: 'ESDTModifyCreator',
      arguments: arguments,
    );
  }

  ModifyCreatorTransactionData._({
    required super.command,
    super.arguments,
  });
}
