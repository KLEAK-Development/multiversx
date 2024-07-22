import 'package:http/http.dart';
import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/multiversx.dart';
import '../mnemonic.dart';

void main() async {
  final api = ElrondApi(
    client: Client(),
    baseUrl: devnetApiBaseUrl,
  );

  final sdk = Sdk(api, await Wallet.fromMnemonic(mnemonic));

  final receiver = PublicKey.fromBech32(
    'erd1spyavw0956vq68xj8y4tenjpq2wd5a9p2c6j8gsz7ztyrnpxrruqzu66jx',
  );

  await sdk.esdt.esdtNftTransfer(
    receiver: receiver,
    identifier: 'ABC-1a9c7d',
    nonce: Nonce(1500),
    quantity: Balance.fromNum(1),
  );
}
