import 'package:meta/meta.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to add URIs to NFT/SFT on the MultiversX blockchain.
///
/// This transaction requires the sender to have the ESDTRoleNFTAddURI role
/// and has a base gas limit of 10,000,000 units.
@immutable
final class AddNftUriTransaction extends TransactionWithData {
  /// Creates a new transaction to add URIs to an NFT/SFT.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address with ESDTRoleNFTAddURI role
  /// - [tokenIdentifier]: The identifier of the NFT/SFT token
  /// - [nftNonce]: The nonce of the specific NFT/SFT
  /// - [uris]: List of URIs to add to the NFT/SFT
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 10,000,000
  AddNftUriTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenIdentifier,
    required Nonce nftNonce,
    required List<Uri> uris,
    GasLimit gasLimit = const GasLimit(0),
  })  : assert(uris.isNotEmpty, 'At least one URI must be provided'),
        super(
          receiver: sender, // Same as sender
          gasLimit: gasLimit + const GasLimit(10000000),
          value: Balance.fromEgld(0),
          data: AddNftUriTransactionData(
            tokenIdentifier: tokenIdentifier,
            nftNonce: nftNonce,
            uris: uris,
          ),
        );
}

/// Transaction data class specifically for adding URIs to NFT/SFT.
///
/// This class handles the formatting of the add URI data into
/// the required transaction data format, including the command and all
/// necessary arguments.
@immutable
final class AddNftUriTransactionData extends CustomTransactionData {
  /// Creates transaction data for adding URIs to NFT/SFT.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the NFT/SFT token
  /// - [nftNonce]: The nonce of the specific NFT/SFT
  /// - [uris]: List of URIs to add to the NFT/SFT
  factory AddNftUriTransactionData({
    required String tokenIdentifier,
    required Nonce nftNonce,
    required List<Uri> uris,
  }) {
    final arguments = [
      tokenIdentifier,
      nftNonce,
      ...uris.map((uri) => uri.toString()),
    ];

    return AddNftUriTransactionData._(
      command: 'ESDTNFTAddURI',
      arguments: arguments,
    );
  }

  AddNftUriTransactionData._({
    required super.command,
    super.arguments,
  });
}
