import 'package:multiversx_sdk/src/network_configuration.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';

/// Represents the gas price for a transaction.
class GasPrice {
  /// The value of the gas price.
  final int value;

  /// Creates a new [GasPrice] instance.
  ///
  /// [value] must be non-negative.
  const GasPrice(this.value) : assert(value >= 0, 'value cannot be negative');
}

/// Represents the gas limit for a transaction.
class GasLimit {
  /// The value of the gas limit.
  final int value;

  /// Creates a new [GasLimit] instance.
  ///
  /// [value] must be non-negative.
  const GasLimit(this.value) : assert(value >= 0, 'value cannot be negative');

  /// Creates a [GasLimit] instance with the minimum gas limit.
  ///
  /// [minGasLimit] defaults to [defaultMinGasLimit].
  const GasLimit.min({int minGasLimit = defaultMinGasLimit})
      : value = minGasLimit;

  /// Creates a [GasLimit] instance based on the transaction payload.
  ///
  /// [data] is the transaction data.
  /// [minGasLimit] defaults to [defaultMinGasLimit].
  /// [gasPerDataByte] defaults to [defaultGasPerDataByte].
  factory GasLimit.forPayload({
    TransactionData? data,
    int minGasLimit = defaultMinGasLimit,
    int gasPerDataByte = defaultGasPerDataByte,
  }) {
    var value = minGasLimit;
    if (data != null) {
      value += gasPerDataByte * data.bytes.length;
    }
    return GasLimit(value);
  }

  /// Adds two [GasLimit] instances.
  GasLimit operator +(GasLimit gasLimit) => GasLimit(value + gasLimit.value);

  /// Multiplies the [GasLimit] by an integer.
  GasLimit operator *(int multiplicator) => GasLimit(value * multiplicator);
}

/// Represents the chain ID for a transaction.
class ChainId {
  /// The value of the chain ID.
  final String value;

  /// Creates a new [ChainId] instance.
  const ChainId(this.value);
}

/// Represents the version of a transaction.
class TransactionVersion {
  /// The value of the transaction version.
  final int value;

  /// Creates a new [TransactionVersion] instance.
  ///
  /// [value] must be greater than 0.
  const TransactionVersion(this.value)
      : assert(value > 0, 'value must be superior to 0');
}

/// Represents a modifier for the gas price.
class GasPriceModifier {
  /// The value of the gas price modifier.
  final double value;

  /// Creates a new [GasPriceModifier] instance.
  ///
  /// [value] must be between 0 and 1 (exclusive).
  const GasPriceModifier(this.value)
      : assert(value > 0 && value < 1, 'value must be between 0 and 1');
}
