import 'package:multiversx_api/multiversx_api.dart';
import 'package:http/io_client.dart';

void main() async {
  final api = MultiverXApi(
    client: IOClient(),
    baseUrl: devnetApiBaseUrl,
  );

  try {
    final result = await api.transactions.getTransactions(size: 2);
    print('result = ${result.map((e) => e.toJson())}');
  } on ApiException catch (e) {
    print(e.toJson());
  }
}
