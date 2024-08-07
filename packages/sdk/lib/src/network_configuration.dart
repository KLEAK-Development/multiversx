import 'package:multiversx_sdk/src/network_parameters.dart';

const defaultChainId = '1';
const defaultGasPerDataByte = 1500;
const defaultMinGasLimit = 50000;
const defaultMinGasPrice = 1000000000;
const defaultGasPriceModifier = 0.01;
const defaultMinTransactionVersion = 1;

sealed class NetworkConfiguration {
  final ChainId chainId;
  final int gasPerDataByte;
  final GasLimit minGasLimit;
  final GasPrice minGasPrice;
  final GasPriceModifier gasPriceModifier;
  final TransactionVersion minTransactionVersion;

  const NetworkConfiguration({
    this.chainId = const ChainId(defaultChainId),
    this.gasPerDataByte = defaultGasPerDataByte,
    this.minGasLimit = const GasLimit(defaultMinGasLimit),
    this.minGasPrice = const GasPrice(defaultMinGasPrice),
    this.gasPriceModifier = const GasPriceModifier(defaultGasPriceModifier),
    this.minTransactionVersion =
        const TransactionVersion(defaultMinTransactionVersion),
  });

  factory NetworkConfiguration.mainnet() = MainnetNetworkConfiguration;

  factory NetworkConfiguration.testnet() = TestnetNetworkConfiguration;

  factory NetworkConfiguration.devnet() = DevnetNetworkConfiguration;
}

final class MainnetNetworkConfiguration extends NetworkConfiguration {
  const MainnetNetworkConfiguration() : super();
}

final class TestnetNetworkConfiguration extends NetworkConfiguration {
  const TestnetNetworkConfiguration() : super(chainId: const ChainId('T'));
}

final class DevnetNetworkConfiguration extends NetworkConfiguration {
  const DevnetNetworkConfiguration() : super(chainId: const ChainId('D'));
}
