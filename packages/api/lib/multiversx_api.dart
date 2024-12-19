import 'dart:convert';

import 'package:multiversx_api/src/contants.dart';
import 'package:multiversx_api/src/repositories/accounts.dart';
import 'package:multiversx_api/src/repositories/dapp.dart';
import 'package:multiversx_api/src/repositories/response/response.dart';
import 'package:multiversx_api/src/repositories/transactions.dart';
import 'package:http/http.dart';

export 'package:multiversx_api/src/contants.dart';

export 'package:multiversx_api/src/repositories/request/transactions/send_transaction.dart';

export 'package:multiversx_api/src/repositories/response/response.dart';
export 'package:multiversx_api/src/repositories/response/dapp/get_config/get_config.dart';
export 'package:multiversx_api/src/repositories/response/transactions/send_transaction/send_transaction.dart';
export 'package:multiversx_api/src/repositories/response/transaction/transaction.dart';

/// A class representing the MultiverX API client.
///
/// This class provides access to various API endpoints and services of the MultiverX blockchain.
class MultiverXApi {
  /// The HTTP client used for making API requests.
  final Client client;

  /// The base URL for the API endpoints.
  final String baseUrl;

  /// The Dapp service for interacting with decentralized applications.
  final Dapp dapp;

  /// The Transactions service for managing blockchain transactions.
  final Transactions transactions;

  /// The Accounts service for handling user accounts.
  final Accounts accounts;

  /// Creates a new instance of [MultiverXApi].
  ///
  /// [client] is required and used for making HTTP requests.
  /// [baseUrl] is optional and defaults to the mainnet API base URL.
  MultiverXApi({
    required this.client,
    this.baseUrl = mainnetApiBaseUrl,
  })  : dapp = Dapp(baseUrl, client),
        transactions = Transactions(baseUrl, client),
        accounts = Accounts(baseUrl, client);

  /// Sends a hello request to the API.
  ///
  /// Returns a [Future] that completes with the response body as a [String].
  /// Throws an [ApiException] if the request fails.
  Future<String> hello() async {
    final response = await client.get(Uri.parse('$baseUrl/hello'));
    if (response.statusCode != 200) {
      throw ApiException.fromJson(json.decode(response.body));
    }
    return response.body;
  }
}
