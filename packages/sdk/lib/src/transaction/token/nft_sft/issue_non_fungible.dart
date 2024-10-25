import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';
import 'package:multiversx_sdk/src/transaction/token/token_properties.dart';

final class IssueNonFungibleTransaction extends TransactionWithData {
  IssueNonFungibleTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenName,
    required String tokenTicker,
    required NftTokenProperties properties,
    GasLimit gasLimit = const GasLimit(0),
  }) : super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0.05),
          data: IssueNonFungibleTransactionData(
            tokenName: tokenName,
            tokenTicker: tokenTicker,
            properties: properties,
          ),
        );
}

final class IssueNonFungibleTransactionData extends CustomTransactionData {
  factory IssueNonFungibleTransactionData({
    required String tokenName,
    required String tokenTicker,
    required NftTokenProperties properties,
  }) {
    final propertiesMap = properties.toMap();
    final arguments = [
      tokenName,
      tokenTicker,
      ...propertiesMap.entries.expand((entry) => [entry.key, entry.value])
    ];

    return IssueNonFungibleTransactionData._(
      command: 'issueNonFungible',
      arguments: arguments,
    );
  }

  IssueNonFungibleTransactionData._({
    required super.command,
    super.arguments,
  });
}
