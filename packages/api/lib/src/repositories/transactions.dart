import 'dart:convert';

import 'package:multiversx_api/src/repositories/request/transactions/send_transaction.dart';
import 'package:multiversx_api/src/repositories/response/response.dart';
import 'package:multiversx_api/src/repositories/response/transaction/transaction.dart';
import 'package:multiversx_api/src/repositories/response/transactions/send_transaction/send_transaction.dart';
import 'package:http/http.dart';

/// A class for interacting with blockchain transactions.
///
/// This class provides methods to send and retrieve transactions on the blockchain.
class Transactions {
  final String _baseUrl;
  final Client _client;

  /// Creates a new [Transactions] instance.
  ///
  /// [_baseUrl] is the base URL for the API endpoints.
  /// [_client] is the HTTP client used for making requests.
  const Transactions(this._baseUrl, this._client);

  /// Posts a signed transaction on the blockchain.
  ///
  /// [request] is the [SendTransactionRequest] containing the transaction details.
  ///
  /// Returns a [Future] that completes with a [SendTransactionResponse].
  ///
  /// Throws an [ApiException] if the request fails.
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
  ///
  /// [from] is the starting index for pagination (optional).
  /// [size] is the number of transactions to retrieve (optional).
  /// [sender] is the address of the transaction sender (optional).
  /// [receiver] is a list of receiver addresses to filter by (optional).
  ///
  /// Returns a [Future] that completes with a [List] of [TransactionResponse] objects.
  ///
  /// Throws an [ApiException] if the request fails.
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
    if (response.statusCode != 200) {
      throw ApiException.fromJson(json.decode(response.body));
    }
    final data = json.decode(response.body) as List;
    return data.map((e) => TransactionResponse.fromJson(e)).toList();
  }
}
