import 'package:multiversx_api/multiversx_api.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_configuration.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/transaction/esdt/multi_transfer.dart';
import 'package:multiversx_sdk/src/transaction/esdt/transfer.dart';
import 'package:multiversx_sdk/src/transaction/transfer.dart';
import 'package:multiversx_sdk/src/wallet.dart';

class Sdk {
  final ElrondApi _api;

  final Esdt _esdt;
  final Egld _egld;

  final Wallet _wallet;

  Sdk(this._api, this._wallet)
      : _esdt = Esdt(_api, _wallet),
        _egld = Egld(_api, _wallet);

  Egld get egld => _egld;

  Esdt get esdt => _esdt;

  Wallet get wallet => _wallet;
}

class Egld {
  final ElrondApi _api;
  final Wallet _wallet;

  Egld(this._api, this._wallet);

  Future<void> transfer({
    required Balance amount,
    required PublicKey receiver,
  }) async {
    final networkConfiguration = NetworkConfiguration();
    final nonceSender = Nonce.zero();

    final transaction = EgldTransferTransaction(
      networkConfiguration: networkConfiguration,
      nonce: nonceSender,
      sender: _wallet.publicKey,
      value: amount,
      receiver: receiver,
    );
    final signedTransaction = _wallet.signTransaction(transaction);

    print(signedTransaction.toMap());
  }
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
    final List<String> methodArguments = const [],
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
      methodArguments: methodArguments,
    );
    final signedTransaction = _wallet.signTransaction(transaction);

    print(signedTransaction.toMap());

    //  we can send transaction with api or gateway
  }

  Future<void> multiTransfer({
    required final PublicKey receiver,
    required final List<TransferTokenWithQuantityAndNonce> tokens,
    final String methodName = '',
    final List<String> methodArguments = const [],
  }) async {
    //  we should get networkconfiguration and nonce from blockchain
    final networkConfiguration = NetworkConfiguration();
    final nonceSender = Nonce.zero();

    final transaction = MultiEsdtNftTransferTransaction(
      networkConfiguration: networkConfiguration,
      nonce: nonceSender,
      receiver: receiver,
      sender: _wallet.publicKey,
      tokens: tokens,
      methodName: methodName,
      methodArguments: methodArguments,
    );

    final signedTransaction = _wallet.signTransaction(transaction);

    print(signedTransaction.toMap());
  }
}
