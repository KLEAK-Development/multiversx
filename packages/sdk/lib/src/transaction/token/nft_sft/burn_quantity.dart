import 'package:meta/meta.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to burn quantity from NFT/SFT tokens on the MultiversX blockchain.
///
/// This transaction requires the sender to have the ESDTRoleNFTBurn role
/// and has a base gas limit of 10,000,000 units.
@immutable
final class BurnQuantityTransaction extends TransactionWithData {
  /// Creates a new transaction to burn quantity from an NFT/SFT.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address with ESDTRoleNFTBurn role
  /// - [tokenIdentifier]: The identifier of the NFT/SFT token
  /// - [sftNonce]: The nonce of the specific NFT/SFT
  /// - [quantityToBurn]: The amount of tokens to burn
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 10,000,000
  BurnQuantityTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenIdentifier,
    required Nonce sftNonce,
    required Balance quantityToBurn,
    GasLimit gasLimit = const GasLimit(0),
  })  : assert(quantityToBurn.value > BigInt.zero,
            'Quantity to burn must be greater than zero'),
        super(
          receiver: sender, // Same as sender
          gasLimit: gasLimit + const GasLimit(10000000),
          value: Balance.fromEgld(0),
          data: BurnQuantityTransactionData(
            tokenIdentifier: tokenIdentifier,
            sftNonce: sftNonce,
            quantityToBurn: quantityToBurn,
          ),
        );
}

/// Transaction data class specifically for burning quantity from NFT/SFT.
///
/// This class handles the formatting of the burn quantity data into
/// the required transaction data format, including the command and all
/// necessary arguments.
@immutable
final class BurnQuantityTransactionData extends CustomTransactionData {
  /// Creates transaction data for burning quantity from an NFT/SFT.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the NFT/SFT token
  /// - [sftNonce]: The nonce of the specific NFT/SFT
  /// - [quantityToBurn]: The amount of tokens to burn
  factory BurnQuantityTransactionData({
    required String tokenIdentifier,
    required Nonce sftNonce,
    required Balance quantityToBurn,
  }) {
    final arguments = [
      tokenIdentifier,
      sftNonce,
      quantityToBurn,
    ];

    return BurnQuantityTransactionData._(
      command: 'ESDTNFTBurn',
      arguments: arguments,
    );
  }

  BurnQuantityTransactionData._({
    required super.command,
    super.arguments,
  });
}
