import 'package:multiversx_sdk/src/transaction/base.dart';

base class CustomTransaction extends TransactionWithData {
  CustomTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.value,
    required super.sender,
    required super.receiver,
    required super.gasLimit,
    required final String command,
    final List<String> arguments = const [],
  }) : super(
          data: CustomTransactionData(
            command: command,
            arguments: arguments,
          ),
        );
}

base class CustomTransactionData extends TransactionData {
  CustomTransactionData({
    required final String command,
    final List<dynamic> arguments = const [],
  }) : super(
          transactionDataFromCommandAndArguments(
            command,
            arguments: mapTransactionDataArgumentsToString(arguments),
          ),
        );
}
