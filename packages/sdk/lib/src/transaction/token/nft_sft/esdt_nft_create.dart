import 'package:meta/meta.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// Represents a transaction for creating a new NFT on the MultiversX blockchain.
@immutable
final class NFTCreationTransaction extends TransactionWithData {
  /// Creates a new NFT creation transaction.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address of the sender (must have ESDTRoleNFTCreate role)
  /// - [tokenIdentifier]: The identifier of the token collection
  /// - [initialQuantity]: The initial quantity of NFTs to create
  /// - [name]: The name of the NFT
  /// - [royalties]: The royalties percentage (0-10000 representing 0-100%)
  /// - [hash]: The hash of the NFT content
  /// - [attributes]: The attributes of the NFT
  /// - [uris]: List of URIs associated with the NFT
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 3,000,000
  NFTCreationTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenIdentifier,
    required int initialQuantity,
    required String name,
    required int royalties,
    required String hash,
    required String attributes,
    required List<String> uris,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: sender, // Same as sender
          value: Balance.fromEgld(0),
          gasLimit: gasLimit + const GasLimit(3000000),
          data: NFTCreationTransactionData(
            tokenIdentifier: tokenIdentifier,
            initialQuantity: initialQuantity,
            name: name,
            royalties: royalties,
            hash: hash,
            attributes: attributes,
            uris: uris,
          ),
        );
}

/// Transaction data specifically for NFT creation.
@immutable
final class NFTCreationTransactionData extends CustomTransactionData {
  /// Creates the data payload for an NFT creation transaction.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the token collection
  /// - [initialQuantity]: The initial quantity of NFTs to create
  /// - [name]: The name of the NFT
  /// - [royalties]: The royalties percentage (0-10000 representing 0-100%)
  /// - [hash]: The hash of the NFT content
  /// - [attributes]: The attributes of the NFT
  /// - [uris]: List of URIs associated with the NFT
  factory NFTCreationTransactionData({
    required String tokenIdentifier,
    required int initialQuantity,
    required String name,
    required int royalties,
    required String hash,
    required String attributes,
    required List<String> uris,
  }) {
    final arguments = [
      tokenIdentifier,
      initialQuantity,
      name,
      royalties,
      hash,
      attributes,
      ...uris,
    ];

    return NFTCreationTransactionData._(
      command: 'ESDTNFTCreate',
      arguments: arguments,
    );
  }

  NFTCreationTransactionData._({
    required super.command,
    super.arguments,
  });
}
