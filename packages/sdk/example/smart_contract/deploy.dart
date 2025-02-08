import 'dart:io';
import 'package:http/http.dart';
import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_sdk/multiversx_sdk.dart';

import '../mnemonic.dart';

void main() async {
  // Initialize API client and SDK
  final client = Client();
  final api = MultiverXApi(
    client: client,
    baseUrl: devnetApiBaseUrl,
  );
  final sdk = Sdk(
    api,
    networkConfiguration: DevnetNetworkConfiguration(),
  );

  // Load wallet from your mnemonic
  final wallet = await Wallet.fromMnemonic(mnemonic: mnemonic);
  final walletPair = WalletPair(wallet);

  try {
    // Get account nonce
    final accountDetails = await api.accounts.getAccount(
      walletPair.mainWallet.publicKey.bech32,
    );
    final nonce = Nonce(accountDetails.nonce);

    // Read the WASM file
    final contractBytes = await File('your wasm file').readAsBytes();

    // Create code metadata for the contract
    final metadata = CodeMetadata(
      upgradeable: true,
      readable: true,
      payable: true,
    );

    // Create deploy transaction
    final deployTransaction = DeploySmartContractTransaction(
      networkConfiguration: sdk.networkConfiguration,
      nonce: nonce,
      sender: walletPair.mainWallet.publicKey,
      contractCode: contractBytes,
      metadata: metadata,
      arguments: [], // Your argument for contract deployment
      // Optionally add extra gas limit if needed
      gasLimit: const GasLimit(100000000),
      // Optionally send EGLD with deployment
      value: Balance.zero(),
    );

    // Sign and send transaction
    final signedTransaction = sdk.signTransaction(
      transaction: deployTransaction,
      walletPair: walletPair,
    );

    final transactionResponse = await sdk.sendSignedTransaction(
      signedTransaction: signedTransaction,
    );

    // Print deployment response
    print('Contract deployed!');
    print('Transaction hash: ${transactionResponse.txHash}');

    // You can compute the contract address if needed
    final contractAddress = computeContractAddress(
      walletPair.mainWallet.publicKey,
      nonce,
    );
    print('Contract address: ${contractAddress.bech32}');
  } on ApiException catch (e) {
    print('API Error:');
    print('Status code: ${e.statusCode}');
    print('Message: ${e.message}');
    print('Error: ${e.error}');
  } catch (e) {
    print('Error: $e');
  } finally {
    client.close();
  }
}
