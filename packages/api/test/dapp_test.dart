import 'dart:convert';

import 'package:multiversx_api/multiversx_api.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('config', () {
    test('200', () async {
      final responseData = {
        'id': 'mainnet',
        'name': 'Mainnet',
        'egldLabel': 'eGLD',
        'decimals': '4',
        'egldDenomination': '18',
        'gasPerDataByte': '1500',
        'apiTimeout': '4000',
        'walletConnectDeepLink':
            'https://maiar.page.link/?apn=com.elrond.maiar.wallet&isi=1519405832&ibi=com.elrond.maiar.wallet&link=https://maiar.com/',
        'walletConnectBridgeAddresses': ['https://bridge.walletconnect.org'],
        'walletAddress': 'https://wallet.elrond.com',
        'apiAddress': 'https://api.elrond.com',
        'explorerAddress': 'https://explorer.elrond.com',
        'chainId': '1'
      };

      final mockClient = MockClient(
          (request) async => Response(json.encode(responseData), 200));
      final api = MultiverXApi(
        baseUrl: mainnetApiBaseUrl,
        client: mockClient,
      );

      final result = await api.dapp.config();
      expect(result, isA<GetDappConfigResponse>());
      expect(result.id, equals('mainnet'));
      expect(result.name, equals('Mainnet'));
      expect(result.egldLabel, equals('eGLD'));
      expect(result.decimals, equals('4'));
      expect(result.egldDenomination, equals('18'));
      expect(result.gasPerDataByte, equals('1500'));
      expect(result.apiTimeout, equals('4000'));
      expect(
          result.walletConnectDeepLink,
          equals(
              'https://maiar.page.link/?apn=com.elrond.maiar.wallet&isi=1519405832&ibi=com.elrond.maiar.wallet&link=https://maiar.com/'));
      expect(result.walletConnectBridgeAddresses.first,
          equals('https://bridge.walletconnect.org'));
      expect(result.walletAddress, equals('https://wallet.elrond.com'));
      expect(result.apiAddress, equals('https://api.elrond.com'));
      expect(result.explorerAddress, equals('https://explorer.elrond.com'));
      expect(result.chainId, equals('1'));
    });

    test('404', () async {
      final responseData = {
        'statusCode': 404,
        'message': 'Network configuration not found'
      };
      final mockClient = MockClient(
          (request) async => Response(json.encode(responseData), 404));
      final api = MultiverXApi(
        baseUrl: mainnetApiBaseUrl,
        client: mockClient,
      );

      try {
        await api.dapp.config();
      } on ApiException catch (e) {
        expect(e.statusCode, equals(404));
        expect(e.message, equals('Network configuration not found'));
      }
    });
  });
}
