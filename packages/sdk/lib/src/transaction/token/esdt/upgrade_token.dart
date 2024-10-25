import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';
import 'package:multiversx_sdk/src/transaction/token/token_properties.dart';

final class UpgradeTokenTransaction extends TransactionWithData {
  UpgradeTokenTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String identifier,
    required EsdtTokenProperties properties,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0),
          data: UpgradeTokenTransactionData(
            identifier: identifier,
            properties: properties,
          ),
        );
}

final class UpgradeTokenTransactionData extends CustomTransactionData {
  factory UpgradeTokenTransactionData({
    required String identifier,
    required EsdtTokenProperties properties,
  }) {
    final propertiesMap = properties.toMap();
    final arguments = [
      identifier,
      ...propertiesMap.entries.expand((entry) => [entry.key, entry.value]),
    ];

    return UpgradeTokenTransactionData._(
      command: 'controlChanges',
      arguments: arguments,
    );
  }

  UpgradeTokenTransactionData._({
    required super.command,
    super.arguments,
  });
}
