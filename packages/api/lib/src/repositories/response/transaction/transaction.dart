import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'transaction.g.dart';

/// Represents the assets associated with a transaction's sender or receiver.
///
/// This class includes details about the asset such as its name, description,
/// associated tags, and icon URLs.
@immutable
@JsonSerializable(explicitToJson: true)
class TransactionAssets {
  /// The name of the asset.
  final String name;

  /// A description of the asset.
  final String description;

  /// A list of tags associated with the asset.
  final List<String> tags;

  /// The URL or path to the PNG icon of the asset.
  final String iconPng;

  /// The URL or path to the SVG icon of the asset, if available.
  final String? iconSvg;

  const TransactionAssets(
      this.name, this.description, this.tags, this.iconPng, this.iconSvg);

  /// Creates a [TransactionAssets] instance from a JSON map.
  ///
  /// This factory constructor takes a [Map<String, dynamic>] as input,
  /// which represents the JSON data, and returns a new [TransactionAssets] instance.
  ///
  /// [json]: A map containing the JSON data for the TransactionAssets.
  ///
  /// Returns a new [TransactionAssets] instance populated with the data from the JSON map.
  factory TransactionAssets.fromJson(Map<String, dynamic> json) =>
      _$TransactionAssetsFromJson(json);

  /// Converts this [TransactionAssets] instance to a JSON map.
  ///
  /// Returns a Map<String, dynamic> representing the JSON data of this [TransactionAssets] instance.
  Map<String, dynamic> toJson() => _$TransactionAssetsToJson(this);
}

/// Represents an action performed in a transaction.
///
/// This class encapsulates details about a specific action associated with a transaction,
/// including its category, name, description, and any additional arguments.
@immutable
@JsonSerializable(explicitToJson: true)
class TransactionAction {
  /// The category of the action.
  final String category;

  /// The name of the action.
  final String name;

  /// An optional description of the action.
  final String? description;

  /// Optional arguments associated with the action.
  final Map<String, dynamic>? arguments;

  /// Creates a new [TransactionAction] instance.
  ///
  /// [category] and [name] are required. [description] and [arguments] are optional.
  const TransactionAction(
      this.category, this.name, this.description, this.arguments);

  /// Creates a [TransactionAction] instance from a JSON map.
  ///
  /// This factory constructor takes a [Map<String, dynamic>] as input,
  /// which represents the JSON data, and returns a new [TransactionAction] instance.
  ///
  /// [json]: A map containing the JSON data for the TransactionAction.
  ///
  /// Returns a new [TransactionAction] instance populated with the data from the JSON map.
  factory TransactionAction.fromJson(Map<String, dynamic> json) =>
      _$TransactionActionFromJson(json);

  /// Converts this [TransactionAction] instance to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] representing the JSON data of this [TransactionAction] instance.
  Map<String, dynamic> toJson() => _$TransactionActionToJson(this);
}

/// Represents scam information related to a transaction.
///
/// This class encapsulates details about potential scam activities associated with a transaction,
/// including the type of scam and additional information about it.
@immutable
@JsonSerializable(explicitToJson: true)
class TransactionScam {
  /// The type of scam detected.
  ///
  /// This field describes the category or classification of the scam.
  final String type;

  /// Additional information about the scam.
  ///
  /// This field provides more details or context about the detected scam.
  final String info;

  /// Creates a new [TransactionScam] instance.
  ///
  /// [type] is the type of scam detected.
  /// [info] is additional information about the scam.
  const TransactionScam(this.type, this.info);

  /// Creates a [TransactionScam] instance from a JSON map.
  ///
  /// This factory constructor takes a [Map<String, dynamic>] as input,
  /// which represents the JSON data, and returns a new [TransactionScam] instance.
  ///
  /// [json]: A map containing the JSON data for the TransactionScam.
  ///
  /// Returns a new [TransactionScam] instance populated with the data from the JSON map.
  factory TransactionScam.fromJson(Map<String, dynamic> json) =>
      _$TransactionScamFromJson(json);

  /// Converts this [TransactionScam] instance to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] representing the JSON data of this [TransactionScam] instance.
  Map<String, dynamic> toJson() => _$TransactionScamToJson(this);
}

/// Represents a detailed response for a transaction on the blockchain.
///
/// This class encapsulates all the relevant information about a transaction,
/// including its hash, gas details, sender and receiver information, status,
/// and various other attributes.
///
/// The class also includes optional fields for additional transaction data,
/// such as function calls, actions performed, and scam detection information.
///
/// Use [TransactionResponse.fromJson] to create an instance from a JSON map,
/// and [toJson] to convert an instance back to a JSON map.
@immutable
@JsonSerializable(explicitToJson: true)
class TransactionResponse {
  /// The transaction hash.
  final String txHash;

  /// The gas limit for the transaction.
  final int gasLimit;

  /// The gas price for the transaction.
  final int gasPrice;

  /// The amount of gas used in the transaction.
  final int gasUsed;

  /// The hash of the mini-block containing this transaction.
  final String miniBlockHash;

  /// The nonce of the transaction.
  final int nonce;

  /// The address of the receiver.
  final String receiver;

  /// The assets associated with the receiver, if any.
  final TransactionAssets? receiverAssets;

  /// The shard number of the receiver.
  final int receiverShard;

  /// The round number when the transaction was processed.
  final int round;

  /// The assets associated with the sender, if any.
  final TransactionAssets? senderAssets;

  /// The shard number of the sender.
  final int senderShard;

  /// The signature of the transaction.
  final String signature;

  /// The status of the transaction.
  final String status;

  /// The value transferred in the transaction.
  final String value;

  /// The fee paid for the transaction.
  final String fee;

  /// The timestamp of the transaction.
  final int timestamp;

  /// Additional data associated with the transaction, if any.
  final String? data;

  /// The function called in the transaction, if applicable.
  final String? function;

  /// The action performed in the transaction, if any.
  final TransactionAction? action;

  /// Information about potential scam, if detected.
  final TransactionScam? scamInfo;

  /// The type of the transaction.
  final String? type;

  /// The hash of the original transaction, if this is a result of a transaction.
  final String? originalTxHash;

  /// Indicates if there are pending results for this transaction.
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

  /// Creates a [TransactionResponse] instance from a JSON map.
  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);

  /// Converts this [TransactionResponse] instance to a JSON map.
  Map<String, dynamic> toJson() => _$TransactionResponseToJson(this);
}
