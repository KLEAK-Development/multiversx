import 'package:convert/convert.dart' as convert;
import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';
import 'package:multiversx_sdk/src/transaction/smart_contract/code_metadata.dart';
import 'package:multiversx_sdk/src/transaction/smart_contract/common.dart';

/// A transaction class used to deploy smart contracts on the MultiversX blockchain.
@immutable
final class DeploySmartContractTransaction extends TransactionWithData {
  /// Creates a new smart contract deployment transaction.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the sender's account
  /// - [sender]: The address of the contract deployer
  /// - [contractCode]: The compiled bytecode of the smart contract
  /// - [vm]: The Arwen virtual machine version to use
  /// - [metadata]: The metadata for the contract code
  /// - [arguments]: Optional list of arguments for contract initialization
  /// - [gasLimit]: Additional gas limit to add to base limit
  /// - [value]: Optional value to send with deployment (default is 0)
  DeploySmartContractTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required List<int> contractCode,
    required CodeMetadata metadata,
    ArwenVirtualMachine vm = ArwenVirtualMachine.v1,
    List<dynamic> arguments = const [],
    GasLimit gasLimit = const GasLimit(0),
    Balance? value,
  }) : super(
          receiver: PublicKey.zero(),
          gasLimit: gasLimit + const GasLimit(700511),
          value: value ?? Balance.zero(),
          data: DeploySmartContractTransactionData(
            contractCode: contractCode,
            vm: vm,
            metadata: metadata,
            contractArguments: arguments,
          ),
        );
}

/// Transaction data class specifically for smart contract deployment.
@immutable
final class DeploySmartContractTransactionData extends CustomTransactionData {
  /// Creates transaction data for deploying a smart contract.
  ///
  /// Parameters:
  /// - [contractCode]: The compiled bytecode of the smart contract
  /// - [metadata]: The metadata for the contract code
  /// - [vm]: The Arwen virtual machine version to use
  /// - [arguments]: Optional list of arguments for contract initialization
  factory DeploySmartContractTransactionData({
    required List<int> contractCode,
    required CodeMetadata metadata,
    ArwenVirtualMachine vm = ArwenVirtualMachine.v1,
    List<dynamic> contractArguments = const [],
  }) {
    final arguments = [
      vm.value,
      metadata.bytes,
      ...contractArguments,
    ];

    return DeploySmartContractTransactionData._(
      command: convert.hex.encode(contractCode),
      arguments: arguments,
    );
  }

  DeploySmartContractTransactionData._({
    required super.command,
    super.arguments,
  });
}
