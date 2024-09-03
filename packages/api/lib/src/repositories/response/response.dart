import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'response.g.dart';

/// Represents an exception that occurs during API operations.
///
/// This class encapsulates information about API errors, including
/// the HTTP status code, error message, and an optional error details.
@immutable
@JsonSerializable()
class ApiException implements Exception {
  /// The HTTP status code of the API response.
  final int statusCode;

  /// A human-readable error message describing the exception.
  final String message;

  /// Optional additional error details or description.
  final String? error;

  /// Creates a new [ApiException] instance.
  ///
  /// [statusCode] is the HTTP status code of the error response.
  /// [message] is a description of the error.
  /// [error] is an optional field for additional error details.
  const ApiException(this.statusCode, this.message, {this.error});

  /// Creates an [ApiException] instance from a JSON map.
  factory ApiException.fromJson(Map<String, dynamic> json) =>
      _$ApiExceptionFromJson(json);

  /// Converts this [ApiException] instance to a JSON map.
  Map<String, dynamic> toJson() => _$ApiExceptionToJson(this);
}
