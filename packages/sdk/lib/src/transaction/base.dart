import 'dart:convert';

import 'package:convert/convert.dart' as convert;
import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_configuration.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:multiversx_sdk/src/signature.dart';

/// Represents a transaction on the MultiversX blockchain.
@immutable
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
  final List<Transaction>? innerTransactions;
  final PublicKey? relayer;

  /// Creates a new [Transaction] instance with the given parameters.
  const Transaction({
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
    this.innerTransactions,
    this.relayer,
  });

  factory Transaction.fromJson(Map<String, dynamic> map) {
    List<Transaction>? innerTxs;
    if (map['innerTransactions'] != null) {
      innerTxs = (map['innerTransactions'] as List)
          .map((tx) => Transaction.fromJson(tx as Map<String, dynamic>))
          .toList();
    }

    return Transaction(
      nonce: Nonce(map['nonce'] as int),
      value: Balance.fromString(map['value'] as String),
      sender: PublicKey.fromBech32(map['sender'] as String),
      receiver: PublicKey.fromBech32(map['receiver'] as String),
      gasPrice: GasPrice(map['gasPrice'] as int),
      gasLimit: GasLimit(map['gasLimit'] as int),
      data: map['data'] != null
          ? TransactionData(base64.decode(map['data'] as String))
          : const TransactionData.empty(),
      chainId: ChainId(map['chainID'] as String),
      version: TransactionVersion(map['version'] as int),
      signature: map['signature'] != null
          ? Signature(map['signature'] as String)
          : const Signature.empty(),
      guardian: map['guardian'] != null
          ? PublicKey.fromBech32(map['guardian'] as String)
          : null,
      guardianSignature: map['guardianSignature'] != null
          ? Signature(map['guardianSignature'] as String)
          : null,
      innerTransactions: innerTxs,
      relayer: map['relayer'] != null
          ? PublicKey.fromBech32(map['relayer'] as String)
          : null,
    );
  }

  /// Creates a new [Transaction] instance using network configuration.
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
    this.innerTransactions,
    this.relayer,
  })  : gasLimit = networkConfiguration.minGasLimit,
        gasPrice = networkConfiguration.minGasPrice,
        chainId = networkConfiguration.chainId,
        version = networkConfiguration.minTransactionVersion;

  /// Converts the transaction to a map representation.
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
    map['chainID'] = chainId.value;
    map['version'] = version.value;
    if (innerTransactions != null && innerTransactions!.isNotEmpty) {
      map['innerTransactions'] =
          innerTransactions!.map((tx) => tx.toMap()).toList();
    }
    if (relayer != null) {
      map['relayer'] = relayer!.bech32;
    }
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

  /// Creates a copy of this transaction with optional new values.
  Transaction copyWith({
    final Signature? newSignature,
    final PublicKey? newGuardian,
    final Signature? newGuardianSignature,
    final TransactionHash? newTransactionHash,
    final PublicKey? newSender,
    final List<Transaction>? newInnerTransactions,
    final PublicKey? newRelayer,
    final GasLimit? newGasLimit,
  }) =>
      Transaction(
        nonce: nonce,
        value: value,
        receiver: receiver,
        sender: newSender ?? sender,
        gasPrice: gasPrice,
        gasLimit: newGasLimit ?? gasLimit,
        data: data,
        chainId: chainId,
        version: version,
        signature: newSignature ?? signature,
        guardian: newGuardian ?? guardian,
        guardianSignature: newGuardianSignature ?? guardianSignature,
        transactionHash: newTransactionHash ?? transactionHash,
        innerTransactions: newInnerTransactions ?? innerTransactions,
        relayer: newRelayer ?? relayer,
      );
}

/// Represents a transaction with network configuration.
@immutable
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

/// Represents a transaction with additional data and gas limit calculation.
@immutable
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

/// Represents a transaction hash.
@immutable
class TransactionHash {
  final String hash;

  const TransactionHash(this.hash);
}

/// Represents the data payload of a transaction.
@immutable
base class TransactionData {
  final List<int> bytes;

  const TransactionData(this.bytes);

  const TransactionData.empty() : bytes = const [];
}

/// Creates transaction data from a command and optional arguments.
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

/// Maps transaction data arguments to their string representations.
List<String> mapTransactionDataArgumentsToString(List<dynamic> arguments) {
  final formattedArguments = arguments.map<String>((element) {
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
  }).toList();

  return formattedArguments;
}

/// Pads a string number to ensure even length.
String _padStringNumber(String number) {
  return number.length % 2 == 0 ? number : '0$number';
}
