import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'send_transaction.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class SendTransactionRequest {
  @JsonKey(name: 'chainID')
  final String chainId;
  @JsonKey(defaultValue: '')
  final String? data;
  final int gasLimit;
  final int gasPrice;
  final int nonce;
  final String receiver;
  final String sender;
  final String signature;
  final String value;
  final int version;
  final num? options;
  final String? guardian;
  final String? guardianSignature;

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
    String this.data = '',
    this.options,
    this.guardian,
    this.guardianSignature,
  });

  factory SendTransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$SendTransactionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendTransactionRequestToJson(this);
}
