import 'package:multiversx_api/multiversx_api.dart';
import 'package:http/io_client.dart';

void main() async {
  final api = MultiverXApi(
    client: IOClient(),
    baseUrl: devnetApiBaseUrl,
  );

  try {
    final account = await api.accounts.getAccount(
      'erd1fmd662htrgt07xxd8me09newa9s0euzvpz3wp0c4pz78f83grt9qm6pn57',
    );
    print('account = ${account.toJson()}');

    final accountTokenCount = await api.accounts.getAccountTokensCount(
      'erd1fmd662htrgt07xxd8me09newa9s0euzvpz3wp0c4pz78f83grt9qm6pn57',
    );
    print('accountTokenCount = $accountTokenCount');

    final accountTokens = await api.accounts.getAccountTokens(
      'erd1fmd662htrgt07xxd8me09newa9s0euzvpz3wp0c4pz78f83grt9qm6pn57',
    );
    print(
        'accountTokens = ${accountTokens.map((token) => token.toJson()).toList()}');
  } on ApiException catch (e) {
    print(e.toJson());
  } finally {
    api.client.close();
  }
}
