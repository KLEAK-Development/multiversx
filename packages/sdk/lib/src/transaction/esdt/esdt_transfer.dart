import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

final class EsdtTransferTransaction extends TransactionWithData {
  EsdtTransferTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.receiver,
    required final String identifier,
    required final Balance amount,
    final GasLimit gasLimit = const GasLimit(0),
    final String methodName = '',
    final List<dynamic> methodArguments = const [],
  }) : super(
          gasLimit: gasLimit + GasLimit(500000),
          value: Balance.fromEgld(0),
          data: EsdtTranferTransactionData(
            identifier,
            amount,
            methodName: methodName,
            methodArguments: methodArguments,
          ),
        );
}

final class EsdtTranferTransactionData extends CustomTransactionData {
  factory EsdtTranferTransactionData(
    final String identifier,
    final Balance balance, {
    final String methodName = '',
    final List<dynamic> methodArguments = const [],
  }) {
    final arguments = [
      identifier,
      balance,
      if (methodName.isNotEmpty) methodName,
      if (methodArguments.isNotEmpty) ...methodArguments
    ];
    return EsdtTranferTransactionData._(
      command: 'ESDTTransfer',
      arguments: arguments,
    );
  }

  EsdtTranferTransactionData._({required super.command, super.arguments});
}
