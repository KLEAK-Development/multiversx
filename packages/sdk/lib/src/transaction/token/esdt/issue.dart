import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';
import 'package:multiversx_sdk/src/transaction/token/token_properties.dart';

final class IssueEsdtTransaction extends TransactionWithData {
  IssueEsdtTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenName,
    required String tokenTicker,
    required int initialSupply,
    required int numDecimals,
    required EsdtTokenProperties properties,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0.05),
          data: IssueEsdtTransactionData(
            tokenName: tokenName,
            tokenTicker: tokenTicker,
            initialSupply: initialSupply,
            numDecimals: numDecimals,
            properties: properties,
          ),
        );
}

final class IssueEsdtTransactionData extends CustomTransactionData {
  factory IssueEsdtTransactionData({
    required String tokenName,
    required String tokenTicker,
    required int initialSupply,
    required int numDecimals,
    required EsdtTokenProperties properties,
  }) {
    final propertiesMap = properties.toMap();
    final arguments = [
      tokenName,
      tokenTicker,
      initialSupply,
      numDecimals,
      ...propertiesMap.entries.expand((entry) => [entry.key, entry.value])
    ];

    return IssueEsdtTransactionData._(
      command: 'issue',
      arguments: arguments,
    );
  }

  IssueEsdtTransactionData._({
    required super.command,
    super.arguments,
  });
}
