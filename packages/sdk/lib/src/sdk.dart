import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_sdk/src/network_configuration.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';

class Sdk {
  final ElrondApi _api;

  NetworkConfiguration networkConfiguration;

  Sdk(
    this._api, {
    this.networkConfiguration = const DevnetNetworkConfiguration(),
  });

  Future<SendTransactionResponse> sendTransaction({
    required Transaction signedTransaction,
  }) =>
      _api.transactions.sendTransaction(signedTransaction.toRequest());
}

extension ToSendTransactionRequest on Transaction {
  SendTransactionRequest toRequest() {
    return SendTransactionRequest.fromJson(toMap());
  }
}
