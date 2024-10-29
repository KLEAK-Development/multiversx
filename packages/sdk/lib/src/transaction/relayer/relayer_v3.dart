import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_configuration.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';

/// Represents a relayed transaction v3 on the MultiversX blockchain.
// TODO: we still need to test this waiting for spica update to land on devnet
@experimental
final class RelayedV3Transaction extends Transaction {
  /// Creates a new [RelayedV3Transaction] instance.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the relayer's account
  /// - [relayer]: The address of the relayer
  /// - [innerTransactions]: The list of transactions to be relayed
  RelayedV3Transaction({
    required NetworkConfiguration networkConfiguration,
    required super.nonce,
    required PublicKey relayer,
    required List<Transaction> innerTransactions,
  }) : super(
          value: Balance.fromEgld(0),
          sender: relayer,
          receiver: relayer,
          gasPrice: networkConfiguration.minGasPrice,
          gasLimit: GasLimit(
            50000 * innerTransactions.length +
                innerTransactions.fold<int>(
                  0,
                  (sum, tx) => sum + tx.gasLimit.value,
                ),
          ),
          chainId: networkConfiguration.chainId,
          version: networkConfiguration.minTransactionVersion,
          innerTransactions: innerTransactions
              .map((tx) => tx.copyWith(newRelayer: relayer))
              .toList(),
        );
}
