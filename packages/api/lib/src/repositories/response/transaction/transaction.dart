import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'transaction.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TransactionAssets {
  final String name;
  final String description;
  final List<String> tags;
  final String iconPng;
  final String? iconSvg;

  const TransactionAssets(
      this.name, this.description, this.tags, this.iconPng, this.iconSvg);

  factory TransactionAssets.fromJson(Map<String, dynamic> json) =>
      _$TransactionAssetsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionAssetsToJson(this);
}

@immutable
@JsonSerializable(explicitToJson: true)
class TransactionAction {
  final String category;
  final String name;
  final String? description;
  final Map<String, dynamic>? arguments;

  const TransactionAction(
      this.category, this.name, this.description, this.arguments);

  factory TransactionAction.fromJson(Map<String, dynamic> json) =>
      _$TransactionActionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionActionToJson(this);
}

@immutable
@JsonSerializable(explicitToJson: true)
class TransactionScam {
  final String type;
  final String info;

  const TransactionScam(this.type, this.info);

  factory TransactionScam.fromJson(Map<String, dynamic> json) =>
      _$TransactionScamFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionScamToJson(this);
}

@immutable
@JsonSerializable(explicitToJson: true)
class TransactionResponse {
  final String txHash;
  final int gasLimit;
  final int gasPrice;
  final int gasUsed;
  final String miniBlockHash;
  final int nonce;
  final String receiver;
  final TransactionAssets? receiverAssets;
  final int receiverShard;
  final int round;
  final TransactionAssets? senderAssets;
  final int senderShard;
  final String signature;
  final String status;
  final String value;
  final String fee;
  final int timestamp;
  final String? data;
  final String? function;
  final TransactionAction? action;
  final TransactionScam? scamInfo;
  final String? type;
  final String? originalTxHash;
  final bool? pendingResults;

  const TransactionResponse(
    this.txHash,
    this.gasLimit,
    this.gasPrice,
    this.gasUsed,
    this.miniBlockHash,
    this.nonce,
    this.receiver,
    this.receiverAssets,
    this.receiverShard,
    this.round,
    this.senderAssets,
    this.senderShard,
    this.signature,
    this.status,
    this.value,
    this.fee,
    this.timestamp,
    this.data,
    this.function,
    this.action,
    this.scamInfo,
    this.type,
    this.originalTxHash,
    this.pendingResults,
  );

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionResponseToJson(this);
}
