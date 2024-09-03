import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'send_transaction.g.dart';

/// Represents the response of a send transaction operation.
///
/// This class encapsulates all the relevant information returned
/// after a transaction is sent on the blockchain.
@immutable
@JsonSerializable(explicitToJson: true)
class SendTransactionResponse {
  /// The address of the transaction receiver.
  final String receiver;

  /// The shard number of the receiver.
  final int receiverShard;

  /// The address of the transaction sender.
  final String sender;

  /// The shard number of the sender.
  final int senderShard;

  /// The status of the transaction.
  ///
  /// Possible values might include "pending", "success", "failed", etc.
  /// Refer to the API documentation for all possible status values.
  final String status;

  /// The unique hash of the transaction.
  ///
  /// This can be used to look up the transaction details later.
  final String txHash;

  /// Creates a new instance of [SendTransactionResponse].
  const SendTransactionResponse(this.receiver, this.receiverShard, this.sender,
      this.senderShard, this.status, this.txHash);

  /// Creates a [SendTransactionResponse] instance from a JSON map.
  factory SendTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$SendTransactionResponseFromJson(json);

  /// Converts this [SendTransactionResponse] instance to a JSON map.
  Map<String, dynamic> toJson() => _$SendTransactionResponseToJson(this);
}
