import 'package:keuangan/controller/home_controller.dart';
import 'package:keuangan/controller/init_controller.dart';
import 'package:keuangan/material/select.dart';
import 'package:keuangan/model/user.dart';
import 'package:request_api_helper/global_env.dart';
import 'package:request_api_helper/request_api_helper.dart';

class AuthController {
  static List<SelectData> user = [];
  static User? selectedUser;
  static getInfo() async {
    user.clear();
    final api = API();
    api.url = 'Auth/infoAja';
    api.replacementId = 'cari_info';
    api.onSuccess = (d) async {
      final dd = await d.convert();
      for (var i in dd['data']['users']) {
        user.add(
          SelectData(
            id: i['id'].toString(),
            title: i['full_name'],
            data: User.build(i),
          ),
        );
      }
      selectUser();
    };
    await api.get();
  }

  static login() async {
    final api = API();
    api.url = 'Auth';
    api.body = {"act": "LOGIN", "un": selectedUser?.email ?? '', "up": selectedUser?.password ?? ''};
    api.onSuccess = (d) async {
      final dd = await d.convert();
      print(dd);
      afterLogin();
    };
    await api.post();
  }

  static selectUser() async {
    final d = await Select.single(
      title: 'pilih User',
      context: ENV.navigatorKey.currentContext!,
      data: user,
    );

    if (d != null) {
      selectedUser = (d.data as User);
      login();
    }
  }

  static afterLogin() {
    InitData.state.getData();
    HomeController.state.route();
  }
}
