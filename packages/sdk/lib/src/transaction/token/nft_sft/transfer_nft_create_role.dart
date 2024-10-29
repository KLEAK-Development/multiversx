import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// A transaction class used to transfer NFT creation role from one address to another.
///
/// This transaction requires no fee but has a base gas limit of 60,000,000 plus
/// additional gas based on the data field length.
@immutable
final class TransferNftCreationRoleTransaction extends TransactionWithData {
  /// Creates a new NFT creation role transfer transaction.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration to use for the transaction
  /// - [nonce]: The sender's account nonce
  /// - [sender]: The address of the current creation role owner
  /// - [tokenIdentifier]: The identifier of the NFT collection
  /// - [fromAddress]: The address to transfer the role from
  /// - [toAddress]: The address to transfer the role to
  /// - [gasLimit]: Additional gas limit to add to the base gas limit
  TransferNftCreationRoleTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenIdentifier,
    required PublicKey fromAddress,
    required PublicKey toAddress,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          value: Balance.fromEgld(0),
          data: TransferNftCreationRoleTransactionData(
            tokenIdentifier: tokenIdentifier,
            fromAddress: fromAddress,
            toAddress: toAddress,
          ),
          // Base gas limit + data bytes * 1500
          gasLimit: gasLimit +
              GasLimit(60000000) +
              GasLimit(1500 *
                  TransferNftCreationRoleTransactionData(
                    tokenIdentifier: tokenIdentifier,
                    fromAddress: fromAddress,
                    toAddress: toAddress,
                  ).bytes.length),
        );
}

/// Transaction data class specifically for NFT creation role transfer transactions.
///
/// This class handles the formatting of role transfer data into the required
/// transaction data format, including the command and all necessary arguments.
@immutable
final class TransferNftCreationRoleTransactionData
    extends CustomTransactionData {
  /// Creates transaction data for transferring NFT creation role.
  ///
  /// Parameters:
  /// - [tokenIdentifier]: The identifier of the NFT collection
  /// - [fromAddress]: The address to transfer the role from
  /// - [toAddress]: The address to transfer the role to
  factory TransferNftCreationRoleTransactionData({
    required String tokenIdentifier,
    required PublicKey fromAddress,
    required PublicKey toAddress,
  }) {
    final arguments = [
      tokenIdentifier,
      fromAddress,
      toAddress,
    ];

    return TransferNftCreationRoleTransactionData._(
      command: 'transferNFTCreateRole',
      arguments: arguments,
    );
  }

  TransferNftCreationRoleTransactionData._({
    required super.command,
    super.arguments,
  });
}
