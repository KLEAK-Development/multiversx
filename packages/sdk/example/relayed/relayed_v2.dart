import 'package:http/http.dart';
import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/multiversx.dart';

import '../mnemonic.dart';

// This code demonstrates how to create and send a relayed ESDT transaction on the MultiversX blockchain
void main() async {
  // Initialize HTTP client and MultiversX API for devnet
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

  // Set the receiver's address
  final receiver = PublicKey.fromBech32(
    'erd10ugfytgdndw5qmnykemjfpd7xrjs63f0r2qjhug0ek9gnfdjxq4s8qjvcx',
  );

  // Create sender wallet and get account details
  final wallet = await Wallet.fromMnemonic(mnemonic: mnemonic);
  final walletPair = WalletPair(wallet);
  final accountDetails =
      await api.accounts.getAccount(walletPair.mainWallet.publicKey.bech32);
  final nonce = Nonce(accountDetails.nonce);

  // Create relayer wallet and get its account details
  final relayerMnemonic = 'ADD_YOUR_RELAYER_MNEMONIC';
  final relayerWallet = await Wallet.fromMnemonic(mnemonic: relayerMnemonic);
  final relayerWalletPair = WalletPair(relayerWallet);
  final relayerAddress = relayerWalletPair.mainWallet.publicKey;
  final relayerAccountDetails =
      await api.accounts.getAccount(relayerAddress.bech32);
  final relayerNonce = Nonce(relayerAccountDetails.nonce);

  // Create the inner ESDT transaction with 1 XOXNO amount
  final esdtTransaction = sdk.createESDTTransaction(
    amount: Balance.fromEgld(1),
    nonce: nonce,
    receiver: receiver,
    identifier: 'XOXNO-589e09',
    sender: walletPair.mainWallet.publicKey,
  );
  // Set gas limit to zero for inner transaction and sign the inner transaction
  final signedInnerTransaction = sdk.signTransaction(
    walletPair: walletPair,
    transaction: esdtTransaction.copyWith(
      newGasLimit: GasLimit(0),
    ),
  );

  // Create the relayed transaction that wraps the inner transaction
  final relayedTransaction = RelayedV2Transaction(
    networkConfiguration: networkConfiguration,
    sender: relayerAddress,
    nonce: relayerNonce,
    innerTransaction: signedInnerTransaction,
    innerGasLimit: esdtTransaction.gasLimit,
  );
  // Sign the relayed transaction with relayer wallet
  final signedRelayedTransaction = sdk.signTransaction(
    walletPair: relayerWalletPair,
    transaction: relayedTransaction,
  );

  try {
    // Send the signed relayed transaction
    final transactionResponse = await sdk.sendSignedTransaction(
      signedTransaction: signedRelayedTransaction,
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
