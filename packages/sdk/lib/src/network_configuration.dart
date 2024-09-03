import 'package:multiversx_sdk/src/network_parameters.dart';

/// Default chain ID for the network.
const defaultChainId = '1';

/// Default gas cost per data byte.
const defaultGasPerDataByte = 1500;

/// Default minimum gas limit for transactions.
const defaultMinGasLimit = 50000;

/// Default minimum gas price for transactions.
const defaultMinGasPrice = 1000000000;

/// Default gas price modifier.
const defaultGasPriceModifier = 0.01;

/// Default minimum transaction version.
const defaultMinTransactionVersion = 1;

/// Represents the network configuration for MultiversX blockchain.
///
/// This class encapsulates various network parameters that define the
/// behavior and constraints of the blockchain network.
sealed class NetworkConfiguration {
  /// The chain ID of the network.
  final ChainId chainId;

  /// The gas cost per data byte for transactions.
  final int gasPerDataByte;

  /// The minimum gas limit allowed for transactions.
  final GasLimit minGasLimit;

  /// The minimum gas price allowed for transactions.
  final GasPrice minGasPrice;

  /// The gas price modifier used in calculations.
  final GasPriceModifier gasPriceModifier;

  /// The minimum transaction version allowed.
  final TransactionVersion minTransactionVersion;

  /// Creates a new [NetworkConfiguration] instance with the specified parameters.
  ///
  /// If not provided, default values are used for each parameter.
  const NetworkConfiguration({
    this.chainId = const ChainId(defaultChainId),
    this.gasPerDataByte = defaultGasPerDataByte,
    this.minGasLimit = const GasLimit(defaultMinGasLimit),
    this.minGasPrice = const GasPrice(defaultMinGasPrice),
    this.gasPriceModifier = const GasPriceModifier(defaultGasPriceModifier),
    this.minTransactionVersion =
        const TransactionVersion(defaultMinTransactionVersion),
  });

  /// Creates a [NetworkConfiguration] for the mainnet.
  factory NetworkConfiguration.mainnet() = MainnetNetworkConfiguration;

  /// Creates a [NetworkConfiguration] for the testnet.
  factory NetworkConfiguration.testnet() = TestnetNetworkConfiguration;

  /// Creates a [NetworkConfiguration] for the devnet.
  factory NetworkConfiguration.devnet() = DevnetNetworkConfiguration;
}

/// Represents the network configuration for the mainnet.
final class MainnetNetworkConfiguration extends NetworkConfiguration {
  /// Creates a [MainnetNetworkConfiguration] with default values.
  const MainnetNetworkConfiguration() : super();
}

/// Represents the network configuration for the testnet.
final class TestnetNetworkConfiguration extends NetworkConfiguration {
  /// Creates a [TestnetNetworkConfiguration] with a specific chain ID.
  const TestnetNetworkConfiguration() : super(chainId: const ChainId('T'));
}

/// Represents the network configuration for the devnet.
final class DevnetNetworkConfiguration extends NetworkConfiguration {
  /// Creates a [DevnetNetworkConfiguration] with a specific chain ID.
  const DevnetNetworkConfiguration() : super(chainId: const ChainId('D'));
}
