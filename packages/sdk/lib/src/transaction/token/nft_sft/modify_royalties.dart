import 'package:meta/meta.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to modify royalties for an NFT/SFT.
///
/// This transaction requires no fee but has a fixed gas limit of 60,000,000.
/// Only the token manager with ESDTRoleModifyRoyalties role can execute this transaction.
/// Royalties are represented as a percentage with 2 decimals (e.g., 1000 = 10.00%).
@immutable
final class ModifyRoyaltiesTransaction extends TransactionWithData {
  /// Creates a new transaction to modify NFT/SFT royalties.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the token manager's account
  /// - [sender]: The address of the token manager
  /// - [tokenIdentifier]: The identifier of the NFT/SFT token
  /// - [tokenNonce]: The nonce of the specific NFT/SFT
  /// - [royalties]: The new royalties value (0-10000, representing 0-100%)
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 60,000,000
  ModifyRoyaltiesTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenIdentifier,
    required Nonce tokenNonce,
    required int royalties,
    GasLimit gasLimit = const GasLimit(0),
  })  : assert(
          royalties >= 0 && royalties <= 10000,
          'Royalties must be between 0 and 10000 (0-100%)',
        ),
        super(
          receiver: sender, // Same as sender
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0),
          data: ModifyRoyaltiesTransactionData(
            tokenIdentifier: tokenIdentifier,
            tokenNonce: tokenNonce,
            royalties: royalties,
          ),
        );
}

/// Transaction data class specifically for modifying NFT/SFT royalties.
///
/// This class handles the formatting of the royalties modification data into
/// the required transaction data format, including the command and all
/// necessary arguments in hexadecimal encoding.
@immutable
final class ModifyRoyaltiesTransactionData extends CustomTransactionData {
  /// Creates transaction data for modifying NFT/SFT royalties.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the NFT/SFT token
  /// - [tokenNonce]: The nonce of the specific NFT/SFT
  /// - [royalties]: The new royalties value (0-10000, representing 0-100%)
  factory ModifyRoyaltiesTransactionData({
    required String tokenIdentifier,
    required Nonce tokenNonce,
    required int royalties,
  }) {
    final arguments = [
      tokenIdentifier,
      tokenNonce,
      royalties,
    ];

    return ModifyRoyaltiesTransactionData._(
      command: 'ESDTModifyRoyalties',
      arguments: arguments,
    );
  }

  ModifyRoyaltiesTransactionData._({
    required super.command,
    super.arguments,
  });
}
