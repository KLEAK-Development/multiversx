import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

class TransferTokenWithQuantityAndNonce {
  final String identifier;
  final Nonce nonce;
  final Balance quantity;

  const TransferTokenWithQuantityAndNonce({
    required this.identifier,
    required this.nonce,
    required this.quantity,
  });
}

final class MultiEsdtNftTransferTransaction
    extends TransactionWithNetworkConfiguration {
  MultiEsdtNftTransferTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required PublicKey receiver,
    required final List<TransferTokenWithQuantityAndNonce> tokens,
    final GasLimit gasLimit = const GasLimit(0),
    final String methodName = '',
    final List<dynamic> methodArguments = const [],
  }) : super(
          receiver: sender,
          gasLimit: gasLimit +
              (GasLimit(1100000) * tokens.length) +
              (methodName.isNotEmpty ? GasLimit(6000000) : GasLimit(0)),
          value: Balance.fromEgld(0),
          data: MultiEsdtNftTranferTransactionData(
            receiver,
            tokens,
            methodName: methodName,
            methodArguments: methodArguments,
          ),
        );
}

final class MultiEsdtNftTranferTransactionData extends CustomTransactionData {
  factory MultiEsdtNftTranferTransactionData(
    final PublicKey receiver,
    final List<TransferTokenWithQuantityAndNonce> tokens, {
    final String methodName = '',
    final List<dynamic> methodArguments = const [],
  }) {
    final arguments = [
      receiver,
      tokens.length,
      for (final token in tokens) ...[
        token.identifier,
        token.nonce,
        token.quantity
      ],
      if (methodName.isNotEmpty) methodName,
      if (methodArguments.isNotEmpty) ...methodArguments
    ];
    return MultiEsdtNftTranferTransactionData._(
      command: 'MultiESDTNFTTransfer',
      arguments: arguments,
    );
  }

  MultiEsdtNftTranferTransactionData._({
    required super.command,
    super.arguments,
  });
}
