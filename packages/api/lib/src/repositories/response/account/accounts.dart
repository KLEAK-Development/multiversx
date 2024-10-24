import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'accounts.g.dart';

/// Represents the assets associated with an account.
@immutable
@JsonSerializable(explicitToJson: true)
class AccountAssets {
  /// The website URL of the account.
  final String? website;

  /// A description of the account.
  final String? description;

  /// The status of the account.
  final String status;

  /// URL to the PNG image associated with the account.
  final String? pngUrl;

  /// The name of the account.
  final String? name;

  /// URL to the SVG image associated with the account.
  final String? svgUrl;

  /// The ledger signature of the account.
  final String? ledgerSignature;

  /// Information about locked accounts.
  final String? lockedAccounts;

  /// A list of additional tokens associated with the account.
  final List<String>? extraTokens;

  /// The preferred rank algorithm for the account.
  final String? preferredRankAlgorithm;

  /// The price source identifier.
  final int? priceSource;

  /// Creates an instance of [AccountAssets].
  AccountAssets({
    this.website,
    this.description,
    required this.status,
    this.pngUrl,
    this.name,
    this.svgUrl,
    this.ledgerSignature,
    this.lockedAccounts,
    this.extraTokens,
    this.preferredRankAlgorithm,
    this.priceSource,
  });

  /// Creates an [AccountAssets] instance from a JSON map.
  factory AccountAssets.fromJson(Map<String, dynamic> json) =>
      _$AccountAssetsFromJson(json);

  /// Converts this [AccountAssets] instance to a JSON map.
  Map<String, dynamic> toJson() => _$AccountAssetsToJson(this);
}

/// Represents information about potential scams.
@immutable
@JsonSerializable(explicitToJson: true)
class ScamInfo {
  /// Information about the scam.
  final String? info;

  /// Creates an instance of [ScamInfo].
  ScamInfo({this.info});

  /// Creates a [ScamInfo] instance from a JSON map.
  factory ScamInfo.fromJson(Map<String, dynamic> json) =>
      _$ScamInfoFromJson(json);

  /// Converts this [ScamInfo] instance to a JSON map.
  Map<String, dynamic> toJson() => _$ScamInfoToJson(this);
}

/// Represents detailed information about an account.
@immutable
@JsonSerializable(explicitToJson: true)
class AccountDetailed {
  /// The address of the account.
  final String address;

  /// The balance of the account.
  final String balance;

  /// The nonce of the account.
  final int nonce;

  /// The timestamp associated with the account.
  final int timestamp;

  /// The shard of the account.
  final int shard;

  /// The owner's address of the account.
  final String? ownerAddress;

  /// The assets associated with the account.
  final AccountAssets? assets;

  /// The deployment timestamp of the account.
  final int? deployedAt;

  /// The deployment transaction hash of the account.
  final String? deployTxHash;

  /// The assets associated with the owner's account.
  final AccountAssets? ownerAssets;

  /// Indicates if the account is verified.
  final bool? isVerified;

  /// The total number of transactions for the account.
  final int txCount;

  /// The total number of smart contract results for the account.
  final int scrCount;

  /// The number of transfers in the last 24 hours.
  final int? transfersLast24h;

  /// The code associated with the account.
  final String? code;

  /// The hash of the account's code.
  final String? codeHash;

  /// The root hash of the account.
  final String rootHash;

  /// The username associated with the account.
  final String? username;

  /// The developer reward associated with the account.
  final String? developerReward;

  /// Indicates if the account is upgradeable.
  final bool? isUpgradeable;

  /// Indicates if the account is readable.
  final bool? isReadable;

  /// Indicates if the account is payable.
  final bool? isPayable;

  /// Indicates if the account is payable by smart contract.
  final bool? isPayableBySmartContract;

  /// Information about potential scams associated with the account.
  final ScamInfo? scamInfo;

  /// The activation epoch of the active guardian.
  final int? activeGuardianActivationEpoch;

  /// The address of the active guardian.
  final String? activeGuardianAddress;

  /// The service UID of the active guardian.
  final String? activeGuardianServiceUid;

  /// The activation epoch of the pending guardian.
  final int? pendingGuardianActivationEpoch;

  /// The address of the pending guardian.
  final String? pendingGuardianAddress;

  /// The service UID of the pending guardian.
  final String? pendingGuardianServiceUid;

  /// Indicates if the account is guarded.
  final bool? isGuarded;

  /// Creates an instance of [AccountDetailed].
  AccountDetailed({
    required this.address,
    required this.balance,
    required this.nonce,
    required this.timestamp,
    required this.shard,
    required this.ownerAddress,
    this.assets,
    required this.deployedAt,
    required this.deployTxHash,
    this.ownerAssets,
    required this.isVerified,
    required this.txCount,
    required this.scrCount,
    required this.transfersLast24h,
    required this.code,
    required this.codeHash,
    required this.rootHash,
    this.username,
    required this.developerReward,
    required this.isUpgradeable,
    required this.isReadable,
    required this.isPayable,
    this.isPayableBySmartContract,
    this.scamInfo,
    this.activeGuardianActivationEpoch,
    this.activeGuardianAddress,
    this.activeGuardianServiceUid,
    this.pendingGuardianActivationEpoch,
    this.pendingGuardianAddress,
    this.pendingGuardianServiceUid,
    this.isGuarded,
  });

  /// Creates an [AccountDetailed] instance from a JSON map.
  factory AccountDetailed.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailedFromJson(json);

  /// Converts this [AccountDetailed] instance to a JSON map.
  Map<String, dynamic> toJson() => _$AccountDetailedToJson(this);
}
