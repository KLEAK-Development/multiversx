import 'package:meta/meta.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';
import 'package:multiversx_sdk/src/transaction/smart_contract/code_metadata.dart';

/// A transaction class used to upgrade smart contracts on the MultiversX blockchain.
@immutable
final class UpgradeSmartContractTransaction extends TransactionWithData {
  /// Creates a new smart contract upgrade transaction.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address of the contract owner
  /// - [receiver]: The address of the contract to upgrade
  /// - [contractCode]: The new compiled bytecode of the smart contract
  /// - [metadata]: The metadata for the new contract code
  /// - [arguments]: Optional list of arguments for contract initialization
  /// - [gasLimit]: Additional gas limit to add to base limit
  /// - [value]: Optional value to send with upgrade (default is 0)
  UpgradeSmartContractTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.receiver,
    required List<int> contractCode,
    required CodeMetadata metadata,
    List<dynamic> arguments = const [],
    GasLimit gasLimit = const GasLimit(0),
    Balance? value,
  }) : super(
          gasLimit: gasLimit + const GasLimit(700511),
          value: value ?? Balance.zero(),
          data: UpgradeSmartContractTransactionData(
            contractCode: contractCode,
            metadata: metadata,
            contractArguments: arguments,
          ),
        );
}

/// Transaction data class specifically for smart contract upgrades.
@immutable
final class UpgradeSmartContractTransactionData extends CustomTransactionData {
  /// Creates transaction data for upgrading a smart contract.
  ///
  /// Parameters:
  /// - [contractCode]: The new compiled bytecode of the smart contract
  /// - [metadata]: The metadata for the new contract code
  /// - [contractArguments]: Optional list of arguments for contract initialization
  factory UpgradeSmartContractTransactionData({
    required List<int> contractCode,
    required CodeMetadata metadata,
    List<dynamic> contractArguments = const [],
  }) {
    final arguments = [
      contractCode,
      metadata.bytes,
      ...contractArguments,
    ];

    return UpgradeSmartContractTransactionData._(
      command: 'upgradeContract',
      arguments: arguments,
    );
  }

  UpgradeSmartContractTransactionData._({
    required super.command,
    super.arguments,
  });
}
