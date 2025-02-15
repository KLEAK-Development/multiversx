import 'package:http/http.dart';
import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/multiversx_sdk.dart';

import 'mnemonic.dart';

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
    'erd10ugfytgdndw5qmnykemjfpd7xrjs63f0r2qjhug0ek9gnfdjxq4s8qjvcx',
  );

  final wallet = await Wallet.fromMnemonic(mnemonic: mnemonic);
  final walletPair = WalletPair(wallet);

  final accountDetails =
      await api.accounts.getAccount(walletPair.mainWallet.publicKey.bech32);
  final nonce = Nonce(accountDetails.nonce);

  try {
    final response = await sdk.sendESDTNFT(
      walletPair: walletPair,
      nonce: nonce,
      receiver: receiver,
      identifier: 'MICE-9e007a',
      nftNonce: Nonce(106),
      quantity: Balance.fromNum(1),
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
