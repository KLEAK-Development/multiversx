import 'dart:convert';

import 'package:multiversx_api/src/repositories/request/transactions/send_transaction.dart';
import 'package:multiversx_api/src/repositories/response/response.dart';
import 'package:multiversx_api/src/repositories/response/transaction/transaction.dart';
import 'package:multiversx_api/src/repositories/response/transactions/send_transaction/send_transaction.dart';
import 'package:http/http.dart';

class Transactions {
  final String _baseUrl;
  final Client _client;

  const Transactions(this._baseUrl, this._client);

  /// Posts a signed transaction on the blockchain
  Future<SendTransactionResponse> sendTransaction(
    SendTransactionRequest request,
  ) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/transactions'),
      body: json.encode(request.toJson()),
      headers: {'content-type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw ApiException.fromJson(json.decode(response.body));
    }
    return SendTransactionResponse.fromJson(json.decode(response.body));
  }

  /// Returns a list of transactions available on the blockchain.
  Future<List<TransactionResponse>> getTransactions(
      {int? from, int? size, String? sender, List<String>? receiver}) async {
    final sb = StringBuffer('$_baseUrl/transactions');
    if (from != null || size != null || sender != null || receiver != null) {
      sb.write('?');
    }
    final queryParameters = <String>[];
    if (from != null) {
      queryParameters.add('from=$from');
    }
    if (size != null) {
      queryParameters.add('size=$size');
    }
    if (sender != null) {
      queryParameters.add('sender=$sender');
    }
    if (receiver != null) {
      for (final r in receiver) {
        queryParameters.add('receiver=$r');
      }
    }
    sb.write(queryParameters.join('&'));

    final response = await _client.get(
      Uri.parse(sb.toString()),
      headers: {'content-type': 'application/json'},
    );
    print(response.body);
    if (response.statusCode != 200) {
      throw ApiException.fromJson(json.decode(response.body));
    }
    final data = json.decode(response.body) as List;
    return data.map((e) => TransactionResponse.fromJson(e)).toList();
  }
}
