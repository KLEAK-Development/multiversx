library elrond_api;

import 'dart:convert';

import 'package:multiversx_api/src/contants.dart';
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

class MultiverXApi {
  final Client client;
  final String baseUrl;

  final Dapp dapp;
  final Transactions transactions;

  MultiverXApi({
    required this.client,
    this.baseUrl = mainnetApiBaseUrl,
  })  : dapp = Dapp(baseUrl, client),
        transactions = Transactions(baseUrl, client);

  Future<String> hello() async {
    final response = await client.get(Uri.parse('$baseUrl/hello'));
    if (response.statusCode != 200) {
      throw ApiException.fromJson(json.decode(response.body));
    }
    return response.body;
  }
}
