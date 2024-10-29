import 'package:meta/meta.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to update NFT/SFT attributes on the MultiversX blockchain.
///
/// This transaction requires the sender to have the ESDTRoleNFTUpdateAttributes role
/// and has a base gas limit of 10,000,000 units.
@immutable
final class UpdateNftAttributesTransaction extends TransactionWithData {
  /// Creates a new NFT/SFT attributes update transaction.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address with ESDTRoleNFTUpdateAttributes role
  /// - [tokenIdentifier]: The identifier of the NFT/SFT token
  /// - [nftNonce]: The nonce of the specific NFT/SFT
  /// - [attributes]: The new attributes as a byte array
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 10,000,000
  UpdateNftAttributesTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenIdentifier,
    required Nonce nftNonce,
    required List<int> attributes,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: sender, // Same as sender
          gasLimit: gasLimit + const GasLimit(10000000),
          value: Balance.fromEgld(0),
          data: UpdateNftAttributesTransactionData(
            tokenIdentifier: tokenIdentifier,
            nftNonce: nftNonce,
            attributes: attributes,
          ),
        );
}

/// Transaction data class specifically for NFT/SFT attributes update.
///
/// This class handles the formatting of the update attributes data into
/// the required transaction data format, including the command and all
/// necessary arguments.
@immutable
final class UpdateNftAttributesTransactionData extends CustomTransactionData {
  /// Creates transaction data for updating NFT/SFT attributes.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the NFT/SFT token
  /// - [nftNonce]: The nonce of the specific NFT/SFT
  /// - [attributes]: The new attributes as a byte array
  factory UpdateNftAttributesTransactionData({
    required String tokenIdentifier,
    required Nonce nftNonce,
    required List<int> attributes,
  }) {
    final arguments = [
      tokenIdentifier,
      nftNonce,
      attributes,
    ];

    return UpdateNftAttributesTransactionData._(
      command: 'ESDTNFTUpdateAttributes',
      arguments: arguments,
    );
  }

  UpdateNftAttributesTransactionData._({
    required super.command,
    super.arguments,
  });
}
