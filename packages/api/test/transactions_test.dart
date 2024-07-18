import 'dart:convert';

import 'package:multiversx_api/multiversx_api.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('get transactions', () {
    test('200', () async {
      final responseData = [
        {
          'txHash':
              '4025b97b84c3653576193a75bc74acb6b6e435ad9025a9c1c1a17c0d3d7bac71',
          'gasLimit': 120000,
          'gasPrice': 1000000000,
          'gasUsed': 50000,
          'miniBlockHash':
              '74d73a5f014028329a6d208f21d4a34524729dcbddcb1565910e4f3cb347c39a',
          'nonce': 70430,
          'receiver':
              'erd1qye935n2d4ezpgpu60lhce3nm0gch8l2ytxysfgzc2m500sujq2s6agad8',
          'receiverShard': 1,
          'round': 3300235,
          'sender':
              'erd1xkmduha0sn4k3yx9fsapavlxrnh2e4fxm8qlafgdgmy6pg4y4zkqav9tdk',
          'senderShard': 0,
          'signature':
              '950a7f4386058f4863eb23a5383434952d9a639022cd1a54527a1f1bf5019d142d783239ddf1e35f3bb67dd17e8c9a8fba08890d06c28facd814e72fbc682a02',
          'status': 'success',
          'value': '1000000000000000000',
          'fee': '50000000000000',
          'timestamp': 1668353010
        },
        {
          'txHash':
              'dfb9460006ee08312f6fb96b98cdd4d5c09d05af77eec0f46942fddf70d6834b',
          'gasLimit': 120000,
          'gasPrice': 1000000000,
          'gasUsed': 50000,
          'miniBlockHash':
              'd12d9ff05061fbb62b60ffedabd2e9d84c8be02d5462f66d8031559bd97f88e6',
          'nonce': 70432,
          'receiver':
              'erd1tymfqnkv2mwyrcvyeevqalh92jwudp9uja9wfxsv4htexjffp8vsksxy0q',
          'receiverShard': 1,
          'round': 3300234,
          'sender':
              'erd1xkmduha0sn4k3yx9fsapavlxrnh2e4fxm8qlafgdgmy6pg4y4zkqav9tdk',
          'senderShard': 0,
          'signature':
              'b4a8af91b07e2159651ff5202538bc8397f1e1f79369c0706f9dee27c1b121d15873fe354a2884e8d2a9f5f7ace435d4d1f3ed549c7253c0498f287b660ae40d',
          'status': 'pending',
          'value': '1000000000000000000',
          'fee': '50000000000000',
          'timestamp': 1668353004
        }
      ];

      final mockClient = MockClient(
          (request) async => Response(json.encode(responseData), 200));
      final api = ElrondApi(
        baseUrl: mainnetApiBaseUrl,
        client: mockClient,
      );
      final result = await api.transactions.getTransactions(size: 2);
      expect(result.length, equals(2));
    });
  });

  group('send transaction', () {
    test('201', () async {
      final responseData = {
        'receiver': 'string',
        'receiverShard': 0,
        'sender': 'string',
        'senderShard': 0,
        'status': 'string',
        'txHash': 'string'
      };

      final mockClient = MockClient(
          (request) async => Response(json.encode(responseData), 201));
      final api = ElrondApi(
        baseUrl: mainnetApiBaseUrl,
        client: mockClient,
      );

      final request = SendTransactionRequest.fromJson({
        'chainId': 'string',
        'data': 'string',
        'gasLimit': 0,
        'gasPrice': 0,
        'nonce': 0,
        'receiver': 'string',
        'sender': 'string',
        'signature': 'string',
        'value': 'string',
        'version': 0
      });
      final result = await api.transactions.sendTransaction(request);
      expect(result, isA<SendTransactionResponse>());
      expect(result.receiver, equals('string'));
      expect(result.receiverShard, equals(0));
      expect(result.sender, equals('string'));
      expect(result.senderShard, equals(0));
      expect(result.status, equals('string'));
      expect(result.txHash, equals('string'));
    });

    test('400', () async {
      final responseData = {'statusCode': 400, 'message': 'Bad signature'};

      final mockClient = MockClient(
          (request) async => Response(json.encode(responseData), 400));
      final api = ElrondApi(
        baseUrl: mainnetApiBaseUrl,
        client: mockClient,
      );

      final request = SendTransactionRequest.fromJson({
        'chainId': 'string',
        'data': 'string',
        'gasLimit': 0,
        'gasPrice': 0,
        'nonce': 0,
        'receiver': 'string',
        'sender': 'string',
        'signature': 'string',
        'value': 'string',
        'version': 0
      });
      try {
        await api.transactions.sendTransaction(request);
      } on ApiException catch (e) {
        expect(e.statusCode, 400);
        expect(e.message, equals('Bad signature'));
      }
    });
  });
}
