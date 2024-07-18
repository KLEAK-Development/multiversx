import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'get_config.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class GetDappConfigResponse {
  final String id;
  final String name;
  final String egldLabel;
  final String decimals;
  final String egldDenomination;
  final String gasPerDataByte;
  final String apiTimeout;
  final String walletConnectDeepLink;
  final List<String> walletConnectBridgeAddresses;
  final String walletAddress;
  final String apiAddress;
  final String explorerAddress;
  final String chainId;

  const GetDappConfigResponse(
    this.id,
    this.name,
    this.egldLabel,
    this.decimals,
    this.egldDenomination,
    this.gasPerDataByte,
    this.apiTimeout,
    this.walletConnectDeepLink,
    this.walletConnectBridgeAddresses,
    this.walletAddress,
    this.apiAddress,
    this.explorerAddress,
    this.chainId,
  );

  factory GetDappConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDappConfigResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDappConfigResponseToJson(this);
}
