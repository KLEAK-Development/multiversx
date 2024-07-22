import 'dart:convert';

import 'package:convert/convert.dart' as convert;
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_configuration.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/signature.dart';

base class Transaction {
  final Nonce nonce;
  final Balance value;
  final PublicKey sender;
  final PublicKey receiver;
  final GasPrice gasPrice;
  final GasLimit gasLimit;
  final TransactionData data;
  final ChainId chainId;
  final TransactionVersion version;
  final Signature signature;
  final TransactionHash? transactionHash;
  final PublicKey? guardian;
  final Signature? guardianSignature;

  Transaction({
    required this.nonce,
    required this.value,
    required this.sender,
    required this.receiver,
    required this.gasPrice,
    required this.gasLimit,
    required this.chainId,
    required this.version,
    this.data = const TransactionData.empty(),
    this.signature = const Signature.empty(),
    this.transactionHash,
    this.guardian,
    this.guardianSignature,
  });

  Transaction.withNetworkConfiguration({
    required final NetworkConfiguration networkConfiguration,
    required this.nonce,
    required this.value,
    required this.sender,
    required this.receiver,
    this.data = const TransactionData.empty(),
    this.signature = const Signature.empty(),
    this.transactionHash,
    this.guardian,
    this.guardianSignature,
  })  : gasLimit = networkConfiguration.minGasLimit,
        gasPrice = networkConfiguration.minGasPrice,
        chainId = networkConfiguration.chainId,
        version = networkConfiguration.minTransactionVersion;

  Map<String, dynamic> toMap({final PublicKey? signedBy}) {
    final map = <String, dynamic>{};
    map['nonce'] = nonce.value;
    map['value'] = value.value.toString();
    map['receiver'] = receiver.bech32;
    map['sender'] = signedBy?.bech32 ?? sender.bech32;
    map['gasPrice'] = gasPrice.value;
    map['gasLimit'] = gasLimit.value;
    if (data.bytes.isNotEmpty) {
      map['data'] = base64.encode(data.bytes);
    }
    map['chainId'] = chainId.value;
    map['version'] = version.value;
    if (signature.hex.isNotEmpty) {
      map['signature'] = signature.hex;
    }
    if (guardian != null) {
      map['guardian'] = guardian!.bech32;
    }
    if (guardianSignature != null) {
      map['guardianSignature'] = guardianSignature;
    }
    return map;
  }

  Transaction copyWith({
    final Signature? newSignature,
    final PublicKey? newGuardian,
    final Signature? newGuardianSignature,
    final TransactionHash? newTransactionHash,
    final PublicKey? newSender,
  }) =>
      Transaction(
        nonce: nonce,
        value: value,
        receiver: receiver,
        sender: newSender ?? sender,
        gasPrice: gasPrice,
        gasLimit: gasLimit,
        data: data,
        chainId: chainId,
        version: version,
        signature: newSignature ?? signature,
        guardian: newGuardian ?? guardian,
        guardianSignature: newGuardianSignature ?? guardianSignature,
        transactionHash: newTransactionHash ?? transactionHash,
      );
}

base class TransactionWithNetworkConfiguration extends Transaction {
  TransactionWithNetworkConfiguration({
    required final NetworkConfiguration networkConfiguration,
    required super.nonce,
    required super.value,
    required super.sender,
    required super.receiver,
    required super.gasLimit,
    required super.data,
  }) : super(
          gasPrice: networkConfiguration.minGasPrice,
          chainId: networkConfiguration.chainId,
          version: networkConfiguration.minTransactionVersion,
        );
}

base class TransactionWithData extends TransactionWithNetworkConfiguration {
  TransactionWithData({
    required super.networkConfiguration,
    required super.nonce,
    required super.value,
    required super.sender,
    required super.receiver,
    required final GasLimit gasLimit,
    required super.data,
  }) : super(
          gasLimit: gasLimit +
              GasLimit.forPayload(
                data: data,
                minGasLimit: networkConfiguration.minGasLimit.value,
                gasPerDataByte: networkConfiguration.gasPerDataByte,
              ),
        );
}

class TransactionHash {
  final String hash;

  const TransactionHash(this.hash);
}

base class TransactionData {
  final List<int> bytes;

  const TransactionData(this.bytes);

  const TransactionData.empty() : bytes = const [];
}

List<int> transactionDataFromCommandAndArguments(
  final String command, {
  final List<String> arguments = const [],
}) {
  final sb = StringBuffer(command);
  if (arguments.isNotEmpty) {
    sb.write('@${arguments.join('@')}');
  }
  return utf8.encode(sb.toString());
}

List<String> mapTransactionDataArgumentsToString(List<dynamic> arguments) {
  final formattedArguments = arguments
      .map<String>((element) {
        final argument = switch (element) {
          bool value => convert.hex.encode(utf8.encode(value.toString())),
          int value => _padStringNumber(value.toRadixString(16)),
          String value => convert.hex.encode(utf8.encode(value)),
          List<int> value => convert.hex.encode(value),
          Balance balance => _padStringNumber(balance.value.toRadixString(16)),
          Nonce nonce => _padStringNumber(nonce.value.toRadixString(16)),
          PublicKey publicKey => convert.hex.encode(publicKey.bytes),
          _ => '',
        };

        return argument;
      })
      .where((element) => element.isNotEmpty)
      .toList();

  return formattedArguments;
}

String _padStringNumber(String number) {
  return number.length % 2 == 0 ? number : '0$number';
}
