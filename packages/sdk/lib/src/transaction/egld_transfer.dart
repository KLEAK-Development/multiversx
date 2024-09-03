import 'package:multiversx_sdk/src/transaction/base.dart';

/// Represents a transaction for transferring EGLD (eGold) on the MultiversX blockchain.
///
/// This class extends the base [Transaction] class and is specifically designed
/// for EGLD transfers between addresses.
final class EgldTransferTransaction extends Transaction {
  /// Creates a new [EgldTransferTransaction] instance.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction.
  /// - [nonce]: The sender's account nonce.
  /// - [sender]: The address of the sender.
  /// - [receiver]: The address of the receiver.
  /// - [value]: The amount of EGLD to transfer.
  ///
  /// All parameters are required and are passed to the superclass constructor.
  EgldTransferTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.receiver,
    required super.value,
  }) : super.withNetworkConfiguration();
}
