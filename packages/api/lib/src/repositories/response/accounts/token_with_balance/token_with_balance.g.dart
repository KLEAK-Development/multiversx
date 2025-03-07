// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_with_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenWithBalance _$TokenWithBalanceFromJson(Map<String, dynamic> json) =>
    TokenWithBalance(
      identifier: json['identifier'] as String,
      ticker: json['ticker'] as String,
      name: json['name'] as String,
      decimals: (json['decimals'] as num).toInt(),
      balance: json['balance'] as String,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TokenWithBalanceToJson(TokenWithBalance instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'ticker': instance.ticker,
      'decimals': instance.decimals,
      'name': instance.name,
      'balance': instance.balance,
      'price': instance.price,
    };
