import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_configuration.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/esdt/transfer.dart';
import 'package:multiversx_sdk/src/wallet.dart';

class Sdk {
  final ElrondApi _api;
  final Esdt _esdt;
  final Wallet _wallet;

  Sdk(this._api, this._wallet) : _esdt = Esdt(_api, _wallet);

  Esdt get esdt => _esdt;

  Wallet get wallet => _wallet;
}

class Esdt {
  final ElrondApi _api;
  final Wallet _wallet;

  Esdt(this._api, this._wallet);

  Future<void> transfer({
    required final PublicKey receiver,
    required final String identifier,
    required final Balance amount,
    final String methodName = '',
    final List<String> arguments = const [],
  }) async {
    //  we should get networkconfiguration and nonce from blockchain
    final networkConfiguration = NetworkConfiguration();
    final nonceSender = Nonce.zero();

    final transaction = EsdtTransferTransaction(
      networkConfiguration: networkConfiguration,
      nonce: nonceSender,
      sender: _wallet.publicKey,
      receiver: receiver,
      identifier: identifier,
      amount: amount,
      methodName: methodName,
      arguments: arguments,
    );
    final signedTransaction = _wallet.signTransaction(transaction);

    print(signedTransaction.toMap());

    //  we can send transaction with api or gateway
  }
}
