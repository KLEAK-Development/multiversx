import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'send_transaction.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class SendTransactionResponse {
  final String receiver;
  final int receiverShard;
  final String sender;
  final int senderShard;
  final String status;
  final String txHash;

  const SendTransactionResponse(this.receiver, this.receiverShard, this.sender,
      this.senderShard, this.status, this.txHash);

  factory SendTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$SendTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendTransactionResponseToJson(this);
}
