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
  final sdk = Sdk(
    api,
    networkConfiguration: NetworkConfiguration(
      chainId: ChainId('D'),
    ),
  );

  final wallet = await Wallet.fromMnemonic(sdk: sdk, mnemonic: mnemonic);

  final receiver = PublicKey.fromBech32(
    'erd10ugfytgdndw5qmnykemjfpd7xrjs63f0r2qjhug0ek9gnfdjxq4s8qjvcx',
  );

  try {
    final transactionResponse = await wallet.egldTransfer(
      receiver: receiver,
      amount: Balance.fromEgld(0.01),
    );
    print(transactionResponse.toJson());
  } on ApiException catch (e) {
    print(e.statusCode);
    print(e.message);
    print(e.error);
  } finally {
    client.close();
  }
}
