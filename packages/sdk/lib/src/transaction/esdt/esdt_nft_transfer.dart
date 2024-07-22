import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';

final class EsdtNftTransferTransaction extends TransactionWithData {
  EsdtNftTransferTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required final PublicKey receiver,
    required final String identifier,
    required final Nonce nftNonce,
    required final Balance quantity,
    GasLimit gasLimit = const GasLimit(0),
    final String methodName = '',
    final List<dynamic> methodArguments = const [],
  }) : super(
          gasLimit: gasLimit + GasLimit(1000000),
          receiver: sender,
          value: Balance.fromEgld(0),
          data: EsdtNftTranferTransactionData(
            identifier,
            nftNonce,
            quantity,
            receiver,
            methodName: methodName,
            methodArguments: methodArguments,
          ),
        );
}

final class EsdtNftTranferTransactionData extends CustomTransactionData {
  factory EsdtNftTranferTransactionData(
    final String identifier,
    final Nonce nonce,
    final Balance quantity,
    final PublicKey receiver, {
    final String methodName = '',
    final List<dynamic> methodArguments = const [],
  }) {
    final arguments = [
      identifier,
      nonce,
      quantity,
      receiver,
      if (methodName.isNotEmpty) methodName,
      if (methodArguments.isNotEmpty) ...methodArguments
    ];
    return EsdtNftTranferTransactionData._(
      command: 'ESDTNFTTransfer',
      arguments: arguments,
    );
  }

  EsdtNftTranferTransactionData._({
    required super.command,
    super.arguments,
  });
}
