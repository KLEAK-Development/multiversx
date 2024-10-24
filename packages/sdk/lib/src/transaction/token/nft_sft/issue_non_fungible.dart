import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// Represents a transaction for issuing a non-fungible token
final class IssueNonFungibleTransaction extends TransactionWithData {
  /// Creates a new [IssueNonFungibleTransaction] instance.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction.
  /// - [nonce]: The nonce of the sender's account.
  /// - [sender]: The address of the sender.
  /// - [tokenName]: The name of the non-fungible token to be issued.
  /// - [tokenTicker]: The ticker symbol for the non-fungible token.
  /// - [canFreeze]: Whether the token can be frozen.
  /// - [canWipe]: Whether the token can be wiped.
  /// - [canPause]: Whether the token can be paused.
  /// - [canTransferNFTCreateRole]: Whether the NFT create role can be transferred.
  /// - [canChangeOwner]: Whether the token owner can be changed.
  /// - [canUpgrade]: Whether the token can be upgraded.
  /// - [canAddSpecialRoles]: Whether special roles can be added.
  /// - [gasLimit]: The gas limit for the transaction (default is 0).
  IssueNonFungibleTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenName,
    required String tokenTicker,
    bool? canFreeze,
    bool? canWipe,
    bool? canPause,
    bool? canTransferNFTCreateRole,
    bool? canChangeOwner,
    bool? canUpgrade,
    bool? canAddSpecialRoles,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0.05),
          data: IssueNonFungibleTransactionData(
            tokenName: tokenName,
            tokenTicker: tokenTicker,
            canFreeze: canFreeze,
            canWipe: canWipe,
            canPause: canPause,
            canTransferNFTCreateRole: canTransferNFTCreateRole,
            canChangeOwner: canChangeOwner,
            canUpgrade: canUpgrade,
            canAddSpecialRoles: canAddSpecialRoles,
          ),
        );
}

/// Represents the data for an issue non-fungible token transaction.
final class IssueNonFungibleTransactionData extends CustomTransactionData {
  /// Creates a new [IssueNonFungibleTransactionData] instance.
  ///
  /// Parameters:
  /// - [tokenName]: The name of the non-fungible token to be issued.
  /// - [tokenTicker]: The ticker symbol for the non-fungible token.
  /// - [canFreeze]: Whether the token can be frozen.
  /// - [canWipe]: Whether the token can be wiped.
  /// - [canPause]: Whether the token can be paused.
  /// - [canTransferNFTCreateRole]: Whether the NFT create role can be transferred.
  /// - [canChangeOwner]: Whether the token owner can be changed.
  /// - [canUpgrade]: Whether the token can be upgraded.
  /// - [canAddSpecialRoles]: Whether special roles can be added.
  factory IssueNonFungibleTransactionData({
    required String tokenName,
    required String tokenTicker,
    bool? canFreeze,
    bool? canWipe,
    bool? canPause,
    bool? canTransferNFTCreateRole,
    bool? canChangeOwner,
    bool? canUpgrade,
    bool? canAddSpecialRoles,
  }) {
    final capabilities = {
      'canFreeze': canFreeze,
      'canWipe': canWipe,
      'canPause': canPause,
      'canTransferNFTCreateRole': canTransferNFTCreateRole,
      'canChangeOwner': canChangeOwner,
      'canUpgrade': canUpgrade,
      'canAddSpecialRoles': canAddSpecialRoles,
    };

    final arguments = [
      tokenName,
      tokenTicker,
      ...capabilities.entries
          .where((entry) => entry.value != null)
          .expand((entry) => [entry.key, entry.value!])
    ];

    return IssueNonFungibleTransactionData._(
      command: 'issueNonFungible',
      arguments: arguments,
    );
  }

  /// Private constructor for [IssueNonFungibleTransactionData].
  IssueNonFungibleTransactionData._({
    required super.command,
    super.arguments,
  });
}
