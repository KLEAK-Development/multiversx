import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/signature.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

/// Represents a relayed transaction v2 on the MultiversX blockchain.
@immutable
final class RelayedV2Transaction extends TransactionWithData {
  /// Creates a new [RelayedV2Transaction] instance.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the relayer's account
  /// - [relayer]: The address of the relayer
  /// - [innerTransaction]: The transaction to be relayed
  RelayedV2Transaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required GasLimit innerGasLimit,
    required Transaction innerTransaction,
  }) : super(
          gasLimit: GasLimit(50000) + innerGasLimit,
          receiver: innerTransaction.sender,
          value: Balance.fromEgld(0),
          data: RelayedV2TransactionData(
            receiver: innerTransaction.receiver,
            nonce: innerTransaction.nonce,
            data: innerTransaction.data,
            signature: innerTransaction.signature,
          ),
        );
}

/// Represents the data for a relayed v2 transaction.
@immutable
final class RelayedV2TransactionData extends CustomTransactionData {
  /// Creates a new [RelayedV2TransactionData] instance.
  ///
  /// Parameters:
  /// - [receiver]: The receiver of the inner transaction
  /// - [nonce]: The nonce of the inner transaction
  /// - [data]: The data of the inner transaction
  /// - [signature]: The signature of the inner transaction
  factory RelayedV2TransactionData({
    required final PublicKey receiver,
    required final Nonce nonce,
    required final TransactionData data,
    required final Signature signature,
  }) {
    final arguments = [
      receiver,
      nonce,
      data.bytes,
      signature.bytes,
    ];

    return RelayedV2TransactionData._(
      command: 'relayedTxV2',
      arguments: arguments,
    );
  }

  RelayedV2TransactionData._({
    required super.command,
    super.arguments,
  });
}
