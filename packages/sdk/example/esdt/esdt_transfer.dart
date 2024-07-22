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
    'erd1sg4u62lzvgkeu4grnlwn7h2s92rqf8a64z48pl9c7us37ajv9u8qj9w8xg',
  );

  await sdk.esdt.esdtTransfer(
    receiver: receiver,
    identifier: 'ALC-6258d2',
    amount: Balance.fromString('12'),
  );
}
