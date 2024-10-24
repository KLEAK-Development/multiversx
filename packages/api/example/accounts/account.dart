import 'package:multiversx_api/multiversx_api.dart';
import 'package:http/io_client.dart';

void main() async {
  final api = MultiverXApi(
    client: IOClient(),
    baseUrl: devnetApiBaseUrl,
  );

  try {
    final result = await api.accounts.getAccount(
      'erd1fmd662htrgt07xxd8me09newa9s0euzvpz3wp0c4pz78f83grt9qm6pn57',
    );
    print('result = ${result.toJson()}');
  } on ApiException catch (e) {
    print(e.toJson());
  }
}
