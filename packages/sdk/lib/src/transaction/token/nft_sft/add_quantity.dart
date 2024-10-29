import 'package:meta/meta.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to add quantity to Semi-Fungible Tokens (SFTs) on the MultiversX blockchain.
///
/// This transaction requires the sender to have the ESDTRoleNFTAddQuantity role
/// and has a base gas limit of 10,000,000 units.
@immutable
final class AddQuantityTransaction extends TransactionWithData {
  /// Creates a new transaction to add quantity to an SFT.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address with ESDTRoleNFTAddQuantity role
  /// - [tokenIdentifier]: The identifier of the SFT token
  /// - [sftNonce]: The nonce of the specific SFT
  /// - [quantityToAdd]: The amount of tokens to add
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 10,000,000
  AddQuantityTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenIdentifier,
    required Nonce sftNonce,
    required Balance quantityToAdd,
    GasLimit gasLimit = const GasLimit(0),
  })  : assert(quantityToAdd.value > BigInt.zero,
            'Quantity to add must be greater than zero'),
        super(
          receiver: sender, // Same as sender
          gasLimit: gasLimit + const GasLimit(10000000),
          value: Balance.fromEgld(0),
          data: AddQuantityTransactionData(
            tokenIdentifier: tokenIdentifier,
            sftNonce: sftNonce,
            quantityToAdd: quantityToAdd,
          ),
        );
}

/// Transaction data class specifically for adding quantity to SFTs.
///
/// This class handles the formatting of the add quantity data into
/// the required transaction data format, including the command and all
/// necessary arguments.
@immutable
final class AddQuantityTransactionData extends CustomTransactionData {
  /// Creates transaction data for adding quantity to an SFT.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the SFT token
  /// - [sftNonce]: The nonce of the specific SFT
  /// - [quantityToAdd]: The amount of tokens to add
  factory AddQuantityTransactionData({
    required String tokenIdentifier,
    required Nonce sftNonce,
    required Balance quantityToAdd,
  }) {
    final arguments = [
      tokenIdentifier,
      sftNonce,
      quantityToAdd,
    ];

    return AddQuantityTransactionData._(
      command: 'ESDTNFTAddQuantity',
      arguments: arguments,
    );
  }

  AddQuantityTransactionData._({
    required super.command,
    super.arguments,
  });
}
