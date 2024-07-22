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

  final tokens = [
    TransferTokenWithQuantityAndNonce(
      identifier: 'ALC-6258d2',
      nonce: Nonce.zero(),
      quantity: Balance.fromNum(12),
    ),
    TransferTokenWithQuantityAndNonce(
      identifier: 'SFT-1q4r8i',
      nonce: Nonce(1),
      quantity: Balance.fromNum(3),
    ),
  ];

  await sdk.esdt.multiEsdtNftTransfer(
    receiver: receiver,
    tokens: tokens,
  );
}
