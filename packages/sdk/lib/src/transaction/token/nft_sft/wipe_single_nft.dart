import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to wipe a single NFT from a specific account.
///
/// This transaction requires no fee but has a fixed gas limit of 60,000,000.
/// Only the token manager can execute this transaction, and the target account
/// must have their token frozen first.
@immutable
final class WipeSingleNftTransaction extends TransactionWithData {
  /// Creates a new transaction to wipe a single NFT.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the token manager's account
  /// - [sender]: The address of the token manager
  /// - [tokenIdentifier]: The identifier of the NFT token
  /// - [nftNonce]: The nonce of the specific NFT
  /// - [addressToWipe]: The address from which to wipe the NFT
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 60,000,000
  WipeSingleNftTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenIdentifier,
    required Nonce nftNonce,
    required PublicKey addressToWipe,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0),
          data: WipeSingleNftTransactionData(
            tokenIdentifier: tokenIdentifier,
            nftNonce: nftNonce,
            addressToWipe: addressToWipe,
          ),
        );
}

/// Transaction data class specifically for wiping a single NFT.
///
/// This class handles the formatting of the wipe data into
/// the required transaction data format, including the command and all
/// necessary arguments in hexadecimal encoding.
@immutable
final class WipeSingleNftTransactionData extends CustomTransactionData {
  /// Creates transaction data for wiping a single NFT.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the NFT token
  /// - [nftNonce]: The nonce of the specific NFT
  /// - [addressToWipe]: The address from which to wipe the NFT
  factory WipeSingleNftTransactionData({
    required String tokenIdentifier,
    required Nonce nftNonce,
    required PublicKey addressToWipe,
  }) {
    final arguments = [
      tokenIdentifier,
      nftNonce,
      addressToWipe,
    ];

    return WipeSingleNftTransactionData._(
      command: 'wipeSingleNFT',
      arguments: arguments,
    );
  }

  WipeSingleNftTransactionData._({
    required super.command,
    super.arguments,
  });
}
