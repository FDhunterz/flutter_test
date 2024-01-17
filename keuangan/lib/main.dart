import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keuangan/controller/auth_controller.dart';
import 'package:keuangan/controller/background_service.dart';
import 'package:keuangan/material/auto_model.dart';
import 'package:request_api_helper/global_env.dart';
import 'package:request_api_helper/request_api_helper.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

Fresh<bool> global = Fresh(false);

@pragma('vm:entry-point')
void printHello() {
  print('hello');
  BackgroundService.sendServer();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark));
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
  AndroidAlarmManager.initialize();
  try {
    await AndroidAlarmManager.cancel(0);
  } catch (_) {}

  Future.delayed(const Duration(milliseconds: 200), () async {
    await AuthController.getInfo();
  });

  runApp(const MyApp());
  await AndroidAlarmManager.periodic(const Duration(seconds: 30), 0, printHello);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: ENV.navigatorKey,
      title: 'App Keuangan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(),
    );
  }
}
