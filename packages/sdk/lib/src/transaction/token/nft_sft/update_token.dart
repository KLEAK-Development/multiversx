import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to update a token type to its latest version on the MultiversX blockchain.
///
/// This transaction updates token types and propagates them to shard's system accounts:
/// - NonFungibleESDT tokens will be updated to NonFungibleESDTv2
/// - MetaESDT and SemiFungibleESDT tokens will be propagated to shard's system accounts
///
/// The transaction requires the sender to be the token manager and has a base gas limit
/// of 60,000,000 units. Note that FungibleESDT, NonFungibleESDT, and NonFungibleESDTv2
/// tokens cannot be updated.
@immutable
final class UpdateTokenTypeTransaction extends TransactionWithData {
  /// Creates a new transaction to update a token type to its latest version.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the token manager's account
  /// - [sender]: The address of the token manager
  /// - [tokenIdentifier]: The identifier of the token to update
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 60,000,000
  UpdateTokenTypeTransaction({
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
          data: UpdateTokenTypeTransactionData(
            tokenIdentifier: tokenIdentifier,
          ),
        );
}

/// Transaction data class specifically for updating token types.
///
/// This class handles the formatting of the token type update data into
/// the required transaction data format, including the command and the
/// token identifier argument.
@immutable
final class UpdateTokenTypeTransactionData extends CustomTransactionData {
  /// Creates transaction data for updating a token type.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the token to update
  factory UpdateTokenTypeTransactionData({
    required String tokenIdentifier,
  }) {
    final arguments = [tokenIdentifier];

    return UpdateTokenTypeTransactionData._(
      command: 'updateTokenID',
      arguments: arguments,
    );
  }

  /// Private constructor for [UpdateTokenTypeTransactionData].
  UpdateTokenTypeTransactionData._({
    required super.command,
    super.arguments,
  });
}

/// Enumeration of token types that can be updated.
enum UpdatableTokenType {
  /// NonFungibleESDT tokens will be updated to NonFungibleESDTv2
  nonFungible('NonFungibleESDT'),

  /// MetaESDT tokens will be propagated to shard's system accounts
  meta('MetaESDT'),

  /// SemiFungibleESDT tokens will be propagated to shard's system accounts
  semiFungible('SemiFungibleESDT');

  final String value;
  const UpdatableTokenType(this.value);
}

/// Enumeration of token types that cannot be updated.
enum NonUpdatableTokenType {
  /// FungibleESDT tokens cannot be updated
  fungible('FungibleESDT'),

  /// NonFungibleESDT tokens that are already updated cannot be updated again
  nonFungibleV2('NonFungibleESDTv2');

  final String value;
  const NonUpdatableTokenType(this.value);
}
