import 'package:http/http.dart';
import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/multiversx.dart';

import './mnemonic.dart';

void main() async {
  final client = Client();
  final api = ElrondApi(
    client: client,
    baseUrl: testnetApiBaseUrl,
  );
  final sdk = Sdk(api);
  final wallet = await Wallet.fromMnemonic(sdk: sdk, mnemonic: mnemonic);

  final receiver = PublicKey.fromBech32(
    'erd1qyu5wthldzr8wx5c9ucg8kjagg0jfs53s8nr3zpz3hypefsdd8ssycr6th',
  );

  try {
    final transactionResponse = await wallet.egldTransfer(
      receiver: receiver,
      amount: Balance.fromEgld(0.01),
    );
    client.close;
    print(transactionResponse.toJson());
  } on ApiException catch (e) {
    print(e.statusCode);
    print(e.message);
    print(e.error);
  }
}
