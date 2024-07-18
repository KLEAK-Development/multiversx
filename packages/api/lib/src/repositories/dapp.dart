import 'dart:convert';

import 'package:multiversx_api/src/repositories/response/dapp/get_config/get_config.dart';
import 'package:multiversx_api/src/repositories/response/response.dart';
import 'package:http/http.dart';

class Dapp {
  final String _baseUrl;
  final Client _client;

  const Dapp(this._baseUrl, this._client);

  /// Returns configuration used in dapps
  Future<GetDappConfigResponse> config() async {
    final response = await _client.get(Uri.parse('$_baseUrl/dapp/config'));
    if (response.statusCode != 200) {
      throw ApiException.fromJson(json.decode(response.body));
    }
    return GetDappConfigResponse.fromJson(json.decode(response.body));
  }
}
