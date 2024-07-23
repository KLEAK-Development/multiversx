// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendTransactionRequest _$SendTransactionRequestFromJson(
        Map<String, dynamic> json) =>
    SendTransactionRequest(
      chainId: json['chainID'] as String,
      gasLimit: (json['gasLimit'] as num).toInt(),
      gasPrice: (json['gasPrice'] as num).toInt(),
      nonce: (json['nonce'] as num).toInt(),
      receiver: json['receiver'] as String,
      sender: json['sender'] as String,
      signature: json['signature'] as String,
      value: json['value'] as String,
      version: (json['version'] as num).toInt(),
      data: json['data'] as String? ?? '',
      options: json['options'] as num?,
      guardian: json['guardian'] as String?,
      guardianSignature: json['guardianSignature'] as String?,
    );

Map<String, dynamic> _$SendTransactionRequestToJson(
        SendTransactionRequest instance) =>
    <String, dynamic>{
      'chainID': instance.chainId,
      'data': instance.data,
      'gasLimit': instance.gasLimit,
      'gasPrice': instance.gasPrice,
      'nonce': instance.nonce,
      'receiver': instance.receiver,
      'sender': instance.sender,
      'signature': instance.signature,
      'value': instance.value,
      'version': instance.version,
      'options': instance.options,
      'guardian': instance.guardian,
      'guardianSignature': instance.guardianSignature,
    };
