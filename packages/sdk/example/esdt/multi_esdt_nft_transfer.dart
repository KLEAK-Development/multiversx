import 'package:http/http.dart';
import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/multiversx.dart';

import '../mnemonic.dart';

void main() async {
  final client = Client();
  final api = ElrondApi(
    client: client,
    baseUrl: testnetApiBaseUrl,
  );
  final sdk = Sdk(
    api,
    networkConfiguration: DevnetNetworkConfiguration(),
  );

  final receiver = PublicKey.fromBech32(
    'erd10ugfytgdndw5qmnykemjfpd7xrjs63f0r2qjhug0ek9gnfdjxq4s8qjvcx',
  );

  final wallet = await Wallet.fromMnemonic(mnemonic: mnemonic);
  final walletPair = WalletPair(wallet);

  final tokens = [
    MultiTokenTransfer(
      identifier: 'MICE-9e007a',
      nonce: Nonce(365),
      quantity: Balance.fromNum(1),
    ),
    MultiTokenTransfer(
      identifier: 'MICE-9e007a',
      nonce: Nonce(366),
      quantity: Balance.fromNum(1),
    ),
  ];

  try {
    final response = await sdk.multiEsdtNftTransfer(
      walletPair: walletPair,
      receiver: receiver,
      tokens: tokens,
    );
    print(response.toJson());
  } on ApiException catch (e) {
    print(e.statusCode);
    print(e.message);
    print(e.error);
  } finally {
    client.close();
  }
}
