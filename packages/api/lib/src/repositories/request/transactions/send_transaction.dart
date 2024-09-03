import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'send_transaction.g.dart';

/// A class representing a request to send a transaction.
///
/// This class encapsulates all the necessary information required to send
/// a transaction on a blockchain network.
@immutable
@JsonSerializable(explicitToJson: true)
class SendTransactionRequest {
  /// The ID of the blockchain network.
  @JsonKey(name: 'chainID')
  final String chainId;

  /// Optional data payload for the transaction.
  @JsonKey(defaultValue: '')
  final String? data;

  /// The maximum amount of gas that can be used in the transaction.
  final int gasLimit;

  /// The price of gas for this transaction in wei.
  final int gasPrice;

  /// The number of transactions sent from the sender's address.
  final int nonce;

  /// The address of the transaction recipient.
  final String receiver;

  /// The address of the transaction sender.
  final String sender;

  /// The cryptographic signature authorizing the transaction.
  final String signature;

  /// The amount of cryptocurrency to be transferred.
  final String value;

  /// The version of the transaction structure.
  final int version;

  /// Optional additional parameters for the transaction.
  final num? options;

  /// Optional address of the guardian for protected transactions.
  final String? guardian;

  /// Optional signature of the guardian for protected transactions.
  final String? guardianSignature;

  /// Creates a new [SendTransactionRequest] instance.
  ///
  /// All parameters except [data], [options], [guardian], and [guardianSignature]
  /// are required.
  const SendTransactionRequest({
    required this.chainId,
    required this.gasLimit,
    required this.gasPrice,
    required this.nonce,
    required this.receiver,
    required this.sender,
    required this.signature,
    required this.value,
    required this.version,
    this.data = '',
    this.options,
    this.guardian,
    this.guardianSignature,
  });

  /// Creates a [SendTransactionRequest] instance from a JSON map.
  factory SendTransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$SendTransactionRequestFromJson(json);

  /// Converts this [SendTransactionRequest] instance to a JSON map.
  Map<String, dynamic> toJson() => _$SendTransactionRequestToJson(this);
}
