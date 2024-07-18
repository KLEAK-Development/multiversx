// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDappConfigResponse _$GetDappConfigResponseFromJson(
        Map<String, dynamic> json) =>
    GetDappConfigResponse(
      json['id'] as String,
      json['name'] as String,
      json['egldLabel'] as String,
      json['decimals'] as String,
      json['egldDenomination'] as String,
      json['gasPerDataByte'] as String,
      json['apiTimeout'] as String,
      json['walletConnectDeepLink'] as String,
      (json['walletConnectBridgeAddresses'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['walletAddress'] as String,
      json['apiAddress'] as String,
      json['explorerAddress'] as String,
      json['chainId'] as String,
    );

Map<String, dynamic> _$GetDappConfigResponseToJson(
        GetDappConfigResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'egldLabel': instance.egldLabel,
      'decimals': instance.decimals,
      'egldDenomination': instance.egldDenomination,
      'gasPerDataByte': instance.gasPerDataByte,
      'apiTimeout': instance.apiTimeout,
      'walletConnectDeepLink': instance.walletConnectDeepLink,
      'walletConnectBridgeAddresses': instance.walletConnectBridgeAddresses,
      'walletAddress': instance.walletAddress,
      'apiAddress': instance.apiAddress,
      'explorerAddress': instance.explorerAddress,
      'chainId': instance.chainId,
    };
