import 'package:meta/meta.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to recreate an NFT with new metadata on the MultiversX blockchain.
///
/// This transaction requires the sender to have the ESDTRoleNFTRecreate role
/// and has a base gas limit of 60,000,000 units. If a field is not provided,
/// that field will be set to zero in the recreated token.
@immutable
final class MetaDataRecreateTransaction extends TransactionWithData {
  /// Creates a new NFT metadata recreation transaction.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address with ESDTRoleNFTRecreate role
  /// - [tokenIdentifier]: The identifier of the NFT token
  /// - [tokenNonce]: The nonce of the specific NFT
  /// - [name]: Optional new name for the token
  /// - [royalties]: Optional new royalties percentage (0-10000 representing 0-100%)
  /// - [hash]: Optional new hash for the token content
  /// - [attributes]: Optional new attributes for the token as byte array
  /// - [uris]: Optional new list of URIs for the token
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 60,000,000
  MetaDataRecreateTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenIdentifier,
    required Nonce tokenNonce,
    String? name,
    int? royalties,
    String? hash,
    List<int>? attributes,
    List<Uri>? uris,
    GasLimit gasLimit = const GasLimit(0),
  })  : assert(
          royalties == null || (royalties >= 0 && royalties <= 10000),
          'Royalties must be between 0 and 10000 (0-100%)',
        ),
        super(
          receiver: sender, // Same as sender
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0),
          data: MetaDataRecreateTransactionData(
            tokenIdentifier: tokenIdentifier,
            tokenNonce: tokenNonce,
            name: name,
            royalties: royalties,
            hash: hash,
            attributes: attributes,
            uris: uris,
          ),
        );
}

/// Transaction data class specifically for NFT metadata recreation.
///
/// This class handles the formatting of the metadata recreation data into
/// the required transaction data format, including the command and all
/// necessary arguments.
@immutable
final class MetaDataRecreateTransactionData extends CustomTransactionData {
  /// Creates transaction data for recreating NFT metadata.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the NFT token
  /// - [tokenNonce]: The nonce of the specific NFT
  /// - [name]: Optional new name for the token
  /// - [royalties]: Optional new royalties percentage
  /// - [hash]: Optional new hash for the token content
  /// - [attributes]: Optional new attributes for the token as byte array
  /// - [uris]: Optional new list of URIs for the token
  factory MetaDataRecreateTransactionData({
    required String tokenIdentifier,
    required Nonce tokenNonce,
    String? name,
    int? royalties,
    String? hash,
    List<int>? attributes,
    List<Uri>? uris,
  }) {
    final arguments = [
      tokenIdentifier,
      tokenNonce,
      if (name != null) name,
      if (royalties != null) royalties,
      if (hash != null) hash,
      if (attributes != null) attributes,
      if (uris != null) ...uris.map((uri) => uri.toString()),
    ];

    return MetaDataRecreateTransactionData._(
      command: 'ESDTMetaDataRecreate',
      arguments: arguments,
    );
  }

  MetaDataRecreateTransactionData._({
    required super.command,
    super.arguments,
  });
}
