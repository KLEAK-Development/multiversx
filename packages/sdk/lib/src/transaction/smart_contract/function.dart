import 'package:meta/meta.dart';

/// Represents a smart contract function with its name and arguments
@immutable
class ContractFunction {
  /// The name of the function to call
  final String name;

  /// The arguments for the function
  final List<dynamic> arguments;

  /// Creates a new contract function with optional arguments
  const ContractFunction(this.name, [this.arguments = const []]);
}
