import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to freeze a single NFT for a specific account.
///
/// This transaction requires no fee but has a fixed gas limit of 60,000,000.
/// Only the token manager can execute this transaction.
@immutable
final class FreezeSingleNftTransaction extends TransactionWithData {
  /// Creates a new transaction to freeze a single NFT.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the token manager's account
  /// - [sender]: The address of the token manager
  /// - [tokenIdentifier]: The identifier of the NFT token
  /// - [nftNonce]: The nonce of the specific NFT
  /// - [addressToFreeze]: The address for which to freeze the NFT
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 60,000,000
  FreezeSingleNftTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenIdentifier,
    required Nonce nftNonce,
    required PublicKey addressToFreeze,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0),
          data: FreezeSingleNftTransactionData(
            tokenIdentifier: tokenIdentifier,
            nftNonce: nftNonce,
            addressToFreeze: addressToFreeze,
          ),
        );
}

/// Transaction data class specifically for freezing a single NFT.
///
/// This class handles the formatting of the freeze data into
/// the required transaction data format, including the command and all
/// necessary arguments in hexadecimal encoding.
@immutable
final class FreezeSingleNftTransactionData extends CustomTransactionData {
  /// Creates transaction data for freezing a single NFT.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the NFT token
  /// - [nftNonce]: The nonce of the specific NFT
  /// - [addressToFreeze]: The address for which to freeze the NFT
  factory FreezeSingleNftTransactionData({
    required String tokenIdentifier,
    required Nonce nftNonce,
    required PublicKey addressToFreeze,
  }) {
    final arguments = [
      tokenIdentifier,
      nftNonce,
      addressToFreeze,
    ];

    return FreezeSingleNftTransactionData._(
      command: 'freezeSingleNFT',
      arguments: arguments,
    );
  }

  FreezeSingleNftTransactionData._({
    required super.command,
    super.arguments,
  });
}
