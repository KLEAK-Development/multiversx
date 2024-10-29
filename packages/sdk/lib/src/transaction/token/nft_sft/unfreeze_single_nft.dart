import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to unfreeze a single NFT for a specific account.
///
/// This transaction requires no fee but has a fixed gas limit of 60,000,000.
/// Only the token manager can execute this transaction.
@immutable
final class UnfreezeSingleNftTransaction extends TransactionWithData {
  /// Creates a new transaction to unfreeze a single NFT.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the token manager's account
  /// - [sender]: The address of the token manager
  /// - [tokenIdentifier]: The identifier of the NFT token
  /// - [nftNonce]: The nonce of the specific NFT
  /// - [addressToUnfreeze]: The address for which to unfreeze the NFT
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 60,000,000
  UnfreezeSingleNftTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenIdentifier,
    required Nonce nftNonce,
    required PublicKey addressToUnfreeze,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0),
          data: UnfreezeSingleNftTransactionData(
            tokenIdentifier: tokenIdentifier,
            nftNonce: nftNonce,
            addressToUnfreeze: addressToUnfreeze,
          ),
        );
}

/// Transaction data class specifically for unfreezing a single NFT.
///
/// This class handles the formatting of the unfreeze data into
/// the required transaction data format, including the command and all
/// necessary arguments in hexadecimal encoding.
@immutable
final class UnfreezeSingleNftTransactionData extends CustomTransactionData {
  /// Creates transaction data for unfreezing a single NFT.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the NFT token
  /// - [nftNonce]: The nonce of the specific NFT
  /// - [addressToUnfreeze]: The address for which to unfreeze the NFT
  factory UnfreezeSingleNftTransactionData({
    required String tokenIdentifier,
    required Nonce nftNonce,
    required PublicKey addressToUnfreeze,
  }) {
    final arguments = [
      tokenIdentifier,
      nftNonce,
      addressToUnfreeze,
    ];

    return UnfreezeSingleNftTransactionData._(
      command: 'unFreezeSingleNFT',
      arguments: arguments,
    );
  }

  UnfreezeSingleNftTransactionData._({
    required super.command,
    super.arguments,
  });
}
