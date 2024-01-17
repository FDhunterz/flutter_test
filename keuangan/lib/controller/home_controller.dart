import 'package:flutter/material.dart';
import 'package:keuangan/controller/transaction/transaction_base.dart';
import 'package:keuangan/material/router/fade_in.dart';
import 'package:keuangan/material/scrollx.dart';
import 'package:keuangan/model/home_model.dart';
import 'package:keuangan/view/home.dart';
import 'package:request_api_helper/global_env.dart';

enum Menu { home, transaksi, laporan, tools }

class HomeController {
  static final state = HomeController._state();
  HomeController._state();
  bool openBar = false;
  Menu menu = Menu.home;
  List<ButtonMenuModel> listMenu = [];
  late ScrollXController sc;

  generate() {
    listMenu = [
      ButtonMenuModel(
        asset: 'asset/input_masuk.png',
        title: 'MASUK',
        function: () {
          TransactionBaseController.state.routeMasuk();
        },
      ),
      ButtonMenuModel(
        asset: 'asset/input_keluar.png',
        title: 'KELUAR',
        function: () {
          TransactionBaseController.state.routeKeluar();
        },
      ),
      ButtonMenuModel(
        asset: 'asset/input_pindah.png',
        title: 'PINDAH',
        function: () {
          TransactionBaseController.state.routePindah();
        },
      ),
      ButtonMenuModel(
        asset: 'asset/input_mutasi.png',
        title: 'MUTASI',
        function: () {
          TransactionBaseController.state.routeMutasi();
        },
      ),
      ButtonMenuModel(
        asset: 'asset/input_kurs.png',
        title: 'KURS',
        function: () {
          TransactionBaseController.state.routePindahKurs();
        },
      ),
    ];
  }

  route() {
    sc = ScrollXController();
    generate();
    openBar = false;
    Navigator.push(
      ENV.navigatorKey.currentContext!,
      fadeIn(
        page: HomeView(
          controller: this,
        ),
      ),
    );
  }
}
