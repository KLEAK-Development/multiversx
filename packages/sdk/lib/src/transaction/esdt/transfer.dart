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
    final String methodName = '',
    final List<dynamic> arguments = const [],
  }) : super(
            gasLimit: GasLimit(500000),
            amount: Balance.fromEgld(0),
            data: EsdtTranferTransactionData(
              identifier,
              amount,
              methodName: methodName,
              arguments: arguments,
            ));
}

final class EsdtTranferTransactionData extends CustomTransactionData {
  factory EsdtTranferTransactionData(
    final String identifier,
    final Balance balance, {
    final String methodName = '',
    final List<dynamic> arguments = const [],
  }) {
    final dataArguments = [
      identifier,
      balance,
      if (methodName.isNotEmpty) methodName,
      if (arguments.isNotEmpty) ...arguments
    ];
    return EsdtTranferTransactionData._(
      command: 'ESDTTransfer',
      arguments: dataArguments,
    );
  }

  EsdtTranferTransactionData._({required super.command, super.arguments});
}
