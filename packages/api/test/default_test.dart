import 'dart:convert';

import 'package:multiversx_api/multiversx_api.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('hello', () {
    test('200', () async {
      final mockClient = MockClient((request) async => Response('hello', 200));
      final api = ElrondApi(
        baseUrl: mainnetApiBaseUrl,
        client: mockClient,
      );

      final result = await api.hello();
      expect(result, isA<String>());
      expect(result, equals('hello'));
    });

    test('500', () async {
      final responseData = {
        'statusCode': 500,
        'message': 'Internal server error'
      };
      final mockClient = MockClient(
          (request) async => Response(json.encode(responseData), 500));
      final api = ElrondApi(
        baseUrl: mainnetApiBaseUrl,
        client: mockClient,
      );

      try {
        await api.hello();
      } on ApiException catch (e) {
        expect(e.statusCode, equals(500));
        expect(e.message, equals('Internal server error'));
      }
    });
  });
}
