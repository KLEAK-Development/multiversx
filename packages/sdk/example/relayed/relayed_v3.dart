import 'package:http/http.dart';
import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/multiversx.dart';

import '../mnemonic.dart';

// It performs a relayed transaction where one wallet pays for another wallet's transaction fees
void main() async {
  // Initialize HTTP client and MultiversX API client
  final client = Client();
  final api = MultiverXApi(
    client: client,
    baseUrl: devnetApiBaseUrl,
  );
  final networkConfiguration = DevnetNetworkConfiguration();
  final sdk = Sdk(
    api,
    networkConfiguration: networkConfiguration,
  );

  // Set up receiver address
  final receiver = PublicKey.fromBech32(
    'erd10ugfytgdndw5qmnykemjfpd7xrjs63f0r2qjhug0ek9gnfdjxq4s8qjvcx',
  );

  // Create sender wallet from mnemonic phrase
  final wallet = await Wallet.fromMnemonic(mnemonic: mnemonic);
  final walletPair = WalletPair(wallet);
  final accountDetails =
      await api.accounts.getAccount(walletPair.mainWallet.publicKey.bech32);
  final nonce = Nonce(accountDetails.nonce);

  // Set up relayer wallet that will pay transaction fees
  final relayerMnemonic = 'ADD_YOUR_RELAYER_MNEMONIC';
  final relayerWallet = await Wallet.fromMnemonic(mnemonic: relayerMnemonic);
  final relayerWalletPair = WalletPair(relayerWallet);
  final relayerAddress = relayerWalletPair.mainWallet.publicKey;
  final relayerAccountDetails =
      await api.accounts.getAccount(relayerAddress.bech32);
  final relayerNonce = Nonce(relayerAccountDetails.nonce);

  // Create inner transaction to send 0.1 EGLD
  final innerTransactions = [
    sdk.signTransaction(
      walletPair: walletPair,
      transaction: sdk.createEGLDTransaction(
        amount: Balance.fromEgld(0.1),
        nonce: nonce,
        receiver: receiver,
        sender: walletPair.mainWallet.publicKey,
      ),
    ),
  ];

  // Create relayed transaction wrapper
  final relayedTransaction = RelayedV3Transaction(
    innerTransactions: innerTransactions,
    networkConfiguration: networkConfiguration,
    nonce: relayerNonce,
    relayer: relayerAddress,
  );

  try {
    // Sign and send the relayed transaction
    final transactionResponse = await sdk.signAndSendTransaction(
      walletPair: relayerWalletPair,
      transaction: relayedTransaction,
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
