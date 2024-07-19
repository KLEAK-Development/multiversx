import 'dart:convert';

import 'package:convert/convert.dart' as convert;
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
    final List<String> arguments = const [],
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
    String identifier,
    Balance balance, {
    String methodName = '',
    List<String> arguments = const [],
  }) {
    final amount = balance.value.toRadixString(16);
    final formattedArguments = [
      convert.hex.encode(utf8.encode(identifier)),
      amount.length % 2 == 0 ? amount : '0$amount',
      if (methodName.isNotEmpty) convert.hex.encode(utf8.encode(methodName)),
      if (arguments.isNotEmpty)
        ...arguments.map((element) => convert.hex.encode(utf8.encode(element)))
    ];
    return EsdtTranferTransactionData._(
      command: 'ESDTTransfer',
      arguments: formattedArguments,
    );
  }

  EsdtTranferTransactionData._({required super.command, super.arguments});
}
