import 'package:multiversx_api/multiversx_api.dart';
import 'package:http/io_client.dart';

void main() async {
  final api = MultiverXApi(
    client: IOClient(),
    baseUrl: devnetApiBaseUrl,
  );

  try {
    final nonce = 0;
    final receiver =
        'erd1qyu5wthldzr8wx5c9ucg8kjagg0jfs53s8nr3zpz3hypefsdd8ssycr6th';
    final sender =
        'erd1qsnaz30h4c6fdn9q752kmjt57zwmgl5qg27r4jswwpj6vt3rsjyqsjck4k';
    final signature =
        '7b7dc09be776c0f593709c42a8b3871f28dcb4fe9badb5e887486946e7b3746f28051b0844e3576da94139dc863f63738a89ff6fa9d09ae370203156bda0e401';
    final request = SendTransactionRequest(
      chainId: 'D',
      data: '',
      gasLimit: 50000,
      gasPrice: 1000000000,
      nonce: nonce,
      receiver: receiver,
      sender: sender,
      signature: signature,
      value: '10000000000000000',
      version: 1,
    );

    final result = await api.transactions.sendTransaction(request);
    print('result = ${result.toJson()}');
  } on ApiException catch (e) {
    print(e.toJson());
  }
}
