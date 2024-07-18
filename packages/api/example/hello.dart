import 'package:multiversx_api/multiversx_api.dart';
import 'package:http/io_client.dart';

void main() async {
  final api = ElrondApi(
    client: IOClient(),
    baseUrl: mainnetApiBaseUrl,
  );

  try {
    final result = await api.hello();
    print('result = $result');
  } on ApiException catch (e) {
    print(e.toJson());
  }
}
