import 'package:http/http.dart';
import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/multiversx.dart';
import 'package:multiversx_sdk/src/wallet.dart';

import '../mnemonic.dart';

void main() async {
  final api = ElrondApi(
    client: Client(),
    baseUrl: devnetApiBaseUrl,
  );

  final sdk = Sdk(api, await Wallet.fromMnemonic(mnemonic));

  final receiver = PublicKey.fromBech32(
    'erd1qyu5wthldzr8wx5c9ucg8kjagg0jfs53s8nr3zpz3hypefsdd8ssycr6th',
  );

  await sdk.esdt.transfer(
    receiver: receiver,
    identifier: 'ALC-95b4d1',
    amount: Balance.fromString('0'),
  );
}
