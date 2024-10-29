// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountAssets _$AccountAssetsFromJson(Map<String, dynamic> json) =>
    AccountAssets(
      website: json['website'] as String?,
      description: json['description'] as String?,
      status: json['status'] as String,
      pngUrl: json['pngUrl'] as String?,
      name: json['name'] as String?,
      svgUrl: json['svgUrl'] as String?,
      ledgerSignature: json['ledgerSignature'] as String?,
      lockedAccounts: json['lockedAccounts'] as String?,
      extraTokens: (json['extraTokens'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      preferredRankAlgorithm: json['preferredRankAlgorithm'] as String?,
      priceSource: (json['priceSource'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AccountAssetsToJson(AccountAssets instance) =>
    <String, dynamic>{
      'website': instance.website,
      'description': instance.description,
      'status': instance.status,
      'pngUrl': instance.pngUrl,
      'name': instance.name,
      'svgUrl': instance.svgUrl,
      'ledgerSignature': instance.ledgerSignature,
      'lockedAccounts': instance.lockedAccounts,
      'extraTokens': instance.extraTokens,
      'preferredRankAlgorithm': instance.preferredRankAlgorithm,
      'priceSource': instance.priceSource,
    };

ScamInfo _$ScamInfoFromJson(Map<String, dynamic> json) => ScamInfo(
      info: json['info'] as String?,
    );

Map<String, dynamic> _$ScamInfoToJson(ScamInfo instance) => <String, dynamic>{
      'info': instance.info,
    };

AccountDetailed _$AccountDetailedFromJson(Map<String, dynamic> json) =>
    AccountDetailed(
      address: json['address'] as String,
      balance: json['balance'] as String,
      nonce: (json['nonce'] as num).toInt(),
      timestamp: (json['timestamp'] as num).toInt(),
      shard: (json['shard'] as num).toInt(),
      ownerAddress: json['ownerAddress'] as String?,
      assets: json['assets'] == null
          ? null
          : AccountAssets.fromJson(json['assets'] as Map<String, dynamic>),
      deployedAt: (json['deployedAt'] as num?)?.toInt(),
      deployTxHash: json['deployTxHash'] as String?,
      ownerAssets: json['ownerAssets'] == null
          ? null
          : AccountAssets.fromJson(json['ownerAssets'] as Map<String, dynamic>),
      isVerified: json['isVerified'] as bool?,
      txCount: (json['txCount'] as num).toInt(),
      scrCount: (json['scrCount'] as num).toInt(),
      transfersLast24h: (json['transfersLast24h'] as num?)?.toInt(),
      code: json['code'] as String?,
      codeHash: json['codeHash'] as String?,
      rootHash: json['rootHash'] as String?,
      username: json['username'] as String?,
      developerReward: json['developerReward'] as String?,
      isUpgradeable: json['isUpgradeable'] as bool?,
      isReadable: json['isReadable'] as bool?,
      isPayable: json['isPayable'] as bool?,
      isPayableBySmartContract: json['isPayableBySmartContract'] as bool?,
      scamInfo: json['scamInfo'] == null
          ? null
          : ScamInfo.fromJson(json['scamInfo'] as Map<String, dynamic>),
      activeGuardianActivationEpoch:
          (json['activeGuardianActivationEpoch'] as num?)?.toInt(),
      activeGuardianAddress: json['activeGuardianAddress'] as String?,
      activeGuardianServiceUid: json['activeGuardianServiceUid'] as String?,
      pendingGuardianActivationEpoch:
          (json['pendingGuardianActivationEpoch'] as num?)?.toInt(),
      pendingGuardianAddress: json['pendingGuardianAddress'] as String?,
      pendingGuardianServiceUid: json['pendingGuardianServiceUid'] as String?,
      isGuarded: json['isGuarded'] as bool?,
    );

Map<String, dynamic> _$AccountDetailedToJson(AccountDetailed instance) =>
    <String, dynamic>{
      'address': instance.address,
      'balance': instance.balance,
      'nonce': instance.nonce,
      'timestamp': instance.timestamp,
      'shard': instance.shard,
      'ownerAddress': instance.ownerAddress,
      'assets': instance.assets?.toJson(),
      'deployedAt': instance.deployedAt,
      'deployTxHash': instance.deployTxHash,
      'ownerAssets': instance.ownerAssets?.toJson(),
      'isVerified': instance.isVerified,
      'txCount': instance.txCount,
      'scrCount': instance.scrCount,
      'transfersLast24h': instance.transfersLast24h,
      'code': instance.code,
      'codeHash': instance.codeHash,
      'rootHash': instance.rootHash,
      'username': instance.username,
      'developerReward': instance.developerReward,
      'isUpgradeable': instance.isUpgradeable,
      'isReadable': instance.isReadable,
      'isPayable': instance.isPayable,
      'isPayableBySmartContract': instance.isPayableBySmartContract,
      'scamInfo': instance.scamInfo?.toJson(),
      'activeGuardianActivationEpoch': instance.activeGuardianActivationEpoch,
      'activeGuardianAddress': instance.activeGuardianAddress,
      'activeGuardianServiceUid': instance.activeGuardianServiceUid,
      'pendingGuardianActivationEpoch': instance.pendingGuardianActivationEpoch,
      'pendingGuardianAddress': instance.pendingGuardianAddress,
      'pendingGuardianServiceUid': instance.pendingGuardianServiceUid,
      'isGuarded': instance.isGuarded,
    };
