import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'get_config.g.dart';

/// Represents the response for getting DApp configuration.
///
/// This class contains various configuration parameters for a decentralized application (DApp).
@immutable
@JsonSerializable(explicitToJson: true)
class GetDappConfigResponse {
  /// Unique identifier for the DApp configuration.
  final String id;

  /// Name of the DApp.
  final String name;

  /// Label used for EGLD (eGold) cryptocurrency.
  final String egldLabel;

  /// Number of decimal places used for EGLD amounts.
  final String decimals;

  /// Denomination of EGLD (e.g., "1000000000000000000" for 18 decimals).
  final String egldDenomination;

  /// Gas cost per data byte for transactions.
  final String gasPerDataByte;

  /// Timeout duration for API requests.
  final String apiTimeout;

  /// Deep link for WalletConnect integration.
  final String walletConnectDeepLink;

  /// List of WalletConnect bridge addresses.
  final List<String> walletConnectBridgeAddresses;

  /// Address of the wallet associated with the DApp.
  final String walletAddress;

  /// API endpoint address for the DApp.
  final String apiAddress;

  /// Address of the block explorer for the blockchain.
  final String explorerAddress;

  /// Chain ID of the blockchain network.
  final String chainId;

  /// Creates a new instance of [GetDappConfigResponse].
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

  /// Creates a [GetDappConfigResponse] instance from a JSON map.
  factory GetDappConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDappConfigResponseFromJson(json);

  /// Converts this [GetDappConfigResponse] instance to a JSON map.
  Map<String, dynamic> toJson() => _$GetDappConfigResponseToJson(this);
}
