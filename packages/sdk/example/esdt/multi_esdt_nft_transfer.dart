import 'package:http/http.dart';
import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/multiversx.dart';

import '../mnemonic.dart';

void main() async {
  final client = Client();
  final api = MultiverXApi(
    client: client,
    baseUrl: devnetApiBaseUrl,
  );
  final sdk = Sdk(
    api,
    networkConfiguration: DevnetNetworkConfiguration(),
  );

  final receiver = PublicKey.fromBech32(
    'erd1fmd662htrgt07xxd8me09newa9s0euzvpz3wp0c4pz78f83grt9qm6pn57',
  );

  final wallet = await Wallet.fromMnemonic(mnemonic: mnemonic);
  final walletPair = WalletPair(wallet);

  final tokens = [
    MultiTokenTransfer(
      identifier: 'EGLD-000000',
      quantity: Balance.fromEgld(1),
    ),
    MultiTokenTransfer(
      identifier: 'XOXNO-589e09',
      quantity: Balance.fromEgld(1),
    ),
  ];

  try {
    final response = await sdk.sendMultiESDTNFT(
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
