import 'package:request_api_helper/global_env.dart';
import 'package:request_api_helper/request_api_helper.dart';

class BackgroundService {
  static sendServer() async {
    print('run action');
    await ENV.config.save(
      ENVData(
        baseUrl: 'http://test-tech.api.jtisrv.com/md/public/API/',
        ignoreBadCertificate: true,
        onAuthError: (context) async {
          print('auth error');
        },
        onError: (d) async {
          try {
            final dd = await d.convert();
            (dd);
          } catch (_) {
            print(d.body);
          }
        },
        onException: (d) async {
          print(d);
        },
      ),
    );

    final api = API();
    api.url = 'BgService/Hit';
    api.body = {"nama": "Faizal Tri Swanto", "email": "faizaltriswanto@mail.com", "nohp": "088217081355"};
    api.onSuccess = (d) async {
      print(d.body);
    };
    await api.post();
  }
}
