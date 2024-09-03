import 'dart:convert';

import 'package:multiversx_api/src/repositories/response/dapp/get_config/get_config.dart';
import 'package:multiversx_api/src/repositories/response/response.dart';
import 'package:http/http.dart';

/// A class for interacting with the dapp-related endpoints of the MultiversX API.
class Dapp {
  /// The base URL for the API.
  final String _baseUrl;

  /// The HTTP client used for making requests.
  final Client _client;

  /// Creates a new [Dapp] instance.
  ///
  /// [_baseUrl] is the base URL for the API.
  /// [_client] is the HTTP client used for making requests.
  const Dapp(this._baseUrl, this._client);

  /// Fetches the configuration used in dapps.
  ///
  /// Returns a [Future] that completes with a [GetDappConfigResponse] containing
  /// the dapp configuration.
  ///
  /// Throws an [ApiException] if the request fails or returns a non-200 status code.
  Future<GetDappConfigResponse> config() async {
    final response = await _client.get(Uri.parse('$_baseUrl/dapp/config'));
    if (response.statusCode != 200) {
      throw ApiException.fromJson(json.decode(response.body));
    }
    return GetDappConfigResponse.fromJson(json.decode(response.body));
  }
}
