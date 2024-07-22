import 'package:multiversx_sdk/src/transaction/base.dart';

final class EgldTransferTransaction extends Transaction {
  EgldTransferTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required super.receiver,
    required super.value,
  }) : super.withNetworkConfiguration();
}
