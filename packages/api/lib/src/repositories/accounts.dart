import 'dart:convert';

import 'package:http/http.dart';
import 'package:multiversx_api/src/repositories/response/account/accounts.dart';
import 'package:multiversx_api/src/repositories/response/response.dart';

/// A class that provides methods to interact with account-related API endpoints.
class Accounts {
  /// The base URL for the API.
  final String _baseUrl;

  /// The HTTP client used to make requests.
  final Client _client;

  /// Creates a new [Accounts] instance.
  ///
  /// [_baseUrl] is the base URL for the API.
  /// [_client] is the HTTP client used to make requests.
  const Accounts(this._baseUrl, this._client);

  /// Fetches detailed information about an account.
  ///
  /// [address] is the address of the account to fetch.
  ///
  /// Returns a [Future] that completes with an [AccountDetailed] object.
  ///
  /// Throws an [ApiException] if the request fails.
  Future<AccountDetailed> getAccount(final String address) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/accounts/$address'),
    );
    print(response.body);
    if (response.statusCode != 200) {
      throw ApiException.fromJson(json.decode(response.body));
    }
    return AccountDetailed.fromJson(json.decode(response.body));
  }
}
