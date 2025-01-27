import 'package:http/http.dart';
import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/multiversx_sdk.dart';

import '../mnemonic.dart';

void main() async {
  // Initialize HTTP client and MultiversX API
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

  // await delegate(client, api, networkConfiguration, sdk);
  await undelegate(client, api, networkConfiguration, sdk);

  client.close();
}

Future<void> undelegate(
  final Client client,
  final MultiverXApi api,
  final NetworkConfiguration networkConfiguration,
  final Sdk sdk,
) async {
  // Set up smart contract address
  final smartContractAddress = PublicKey.fromBech32(
    'erd1qqqqqqqqqqqqqpgqc2d2z4atpxpk7xgucfkc7nrrp5ynscjrah0scsqc35', // Replace with actual contract address
  );

  // Create wallet from mnemonic
  final wallet = await Wallet.fromMnemonic(mnemonic: mnemonic);
  final walletPair = WalletPair(wallet);

  // Get account nonce
  final accountDetails =
      await api.accounts.getAccount(walletPair.mainWallet.publicKey.bech32);
  final nonce = Nonce(accountDetails.nonce);

  // Create smart contract function call
  final function = ContractFunction(
    'ESDTTransfer',
    [
      'XEGLD-23b511',
      Balance.fromEgld(1),
      'unDelegate',
    ],
  );

  // Create the transaction
  final transaction = CallSmartContractTransaction(
    networkConfiguration: networkConfiguration,
    nonce: nonce,
    sender: walletPair.mainWallet.publicKey,
    gasLimit: GasLimit(8000000),
    receiver: smartContractAddress,
    function: function,
    value: Balance.fromEgld(0),
  );

  try {
    // Sign and send the transaction
    final transactionResponse = await sdk.signAndSendTransaction(
      walletPair: walletPair,
      transaction: transaction,
    );

    print('Transaction hash: ${transactionResponse.txHash}');
    print('Transaction status: ${transactionResponse.status}');
    print(transactionResponse.toJson());
  } on ApiException catch (e) {
    print('Error status code: ${e.statusCode}');
    print('Error message: ${e.message}');
    print('Error details: ${e.error}');
  }
}

Future<void> delegate(
  final Client client,
  final MultiverXApi api,
  final NetworkConfiguration networkConfiguration,
  final Sdk sdk,
) async {
  // Set up smart contract address
  final smartContractAddress = PublicKey.fromBech32(
    'erd1qqqqqqqqqqqqqpgqc2d2z4atpxpk7xgucfkc7nrrp5ynscjrah0scsqc35', // Replace with actual contract address
  );

  // Create wallet from mnemonic
  final wallet = await Wallet.fromMnemonic(mnemonic: mnemonic);
  final walletPair = WalletPair(wallet);

  // Get account nonce
  final accountDetails =
      await api.accounts.getAccount(walletPair.mainWallet.publicKey.bech32);
  final nonce = Nonce(accountDetails.nonce);

  // Create smart contract function call
  final function = ContractFunction(
    'delegate', // Replace with your contract function name
  );

  // Create the transaction
  final transaction = CallSmartContractTransaction(
    networkConfiguration: networkConfiguration,
    nonce: nonce,
    sender: walletPair.mainWallet.publicKey,
    gasLimit: GasLimit(8000000),
    receiver: smartContractAddress,
    function: function,
    value: Balance.fromEgld(1),
  );

  try {
    // Sign and send the transaction
    final transactionResponse = await sdk.signAndSendTransaction(
      walletPair: walletPair,
      transaction: transaction,
    );

    print('Transaction hash: ${transactionResponse.txHash}');
    print('Transaction status: ${transactionResponse.status}');
    print(transactionResponse.toJson());
  } on ApiException catch (e) {
    print('Error status code: ${e.statusCode}');
    print('Error message: ${e.message}');
    print('Error details: ${e.error}');
  }
}
