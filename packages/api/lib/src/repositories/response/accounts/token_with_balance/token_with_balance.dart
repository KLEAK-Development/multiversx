import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'token_with_balance.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TokenWithBalance {
  final String identifier;
  final String ticker;
  final int decimals;
  final String name;
  final String balance;
  final double? price;

  TokenWithBalance({
    required this.identifier,
    required this.ticker,
    required this.name,
    required this.decimals,
    required this.balance,
    this.price,
  });

  factory TokenWithBalance.fromJson(Map<String, dynamic> json) =>
      _$TokenWithBalanceFromJson(json);

  Map<String, dynamic> toJson() => _$TokenWithBalanceToJson(this);
}
