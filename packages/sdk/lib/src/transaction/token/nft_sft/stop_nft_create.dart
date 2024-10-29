import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to stop NFT creation for a token.
///
/// This transaction requires no fee and has a fixed gas limit of 60,000,000.
/// Only the token manager can execute this transaction.
@immutable
final class StopNftCreationTransaction extends TransactionWithData {
  /// Creates a new transaction to stop NFT creation.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration to use for the transaction
  /// - [nonce]: The sender's account nonce
  /// - [sender]: The address of the token manager
  /// - [tokenIdentifier]: The identifier of the NFT collection
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 60,000,000
  StopNftCreationTransaction({
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
          data: StopNftCreationTransactionData(
            tokenIdentifier: tokenIdentifier,
          ),
        );
}

/// Transaction data class specifically for stopping NFT creation.
///
/// This class handles the formatting of the stop NFT creation data into
/// the required transaction data format, including the command and token identifier.
@immutable
final class StopNftCreationTransactionData extends CustomTransactionData {
  /// Creates transaction data for stopping NFT creation.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the NFT collection
  factory StopNftCreationTransactionData({
    required String tokenIdentifier,
  }) {
    final arguments = [
      tokenIdentifier,
    ];

    return StopNftCreationTransactionData._(
      command: 'stopNFTCreate',
      arguments: arguments,
    );
  }

  StopNftCreationTransactionData._({
    required super.command,
    super.arguments,
  });
}
