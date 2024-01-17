import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keuangan/controller/auth_controller.dart';
import 'package:keuangan/controller/init_controller.dart';
import 'package:keuangan/material/alert/inspector_controller.dart';
import 'package:keuangan/material/form.dart';
import 'package:keuangan/material/router/fade_in.dart';
import 'package:keuangan/material/scrollx.dart';
import 'package:keuangan/material/toast.dart';
import 'package:keuangan/model/file_manager.dart';
import 'package:keuangan/model/outlet_model.dart';
import 'package:keuangan/model/trx_model.dart';
import 'package:keuangan/view/transaksi/keluar.dart';
import 'package:keuangan/view/transaksi/masuk.dart';
import 'package:keuangan/view/transaksi/mutasi.dart';
import 'package:keuangan/view/transaksi/pindah.dart';
import 'package:keuangan/view/transaksi/pindah_kurs.dart';
import 'package:request_api_helper/global_env.dart';
import 'package:request_api_helper/loding.dart';
import 'package:request_api_helper/request_api_helper.dart';

class TransactionBaseController {
  SubOutlet? selectedOutlet;
  SubOutlet? dariOutlet, keOutlet;
  DateTime startDate = DateTime.now();
  late ScrollXController sc;
  DateTime? sd, ed;
  late MaterialXFormController input, keterangan, judul, dari, ke;
  CurrencyType? selectedCurrency, selectedCurrency2;
  List<FileManager> photo = [];
  String? type;
  late InspectorController outlet, inputIC, keC, dariC, darioutC, keoutC, rangeC;
  static final state = TransactionBaseController._state();
  TransactionBaseController._state();

  getTransaction() async {
    final api = API();
    api.body = {
      'act': 'trxGet',
      'outlet_id': '1',
      'user_id': AuthController.selectedUser?.id,
      'trx_id': '0',
      'status': '1',
    };
    print(AuthController.selectedUser?.id);
    api.url = 'Trx/Get';
    api.onSuccess = (d) async {
      final dd = await d.convert();
      print(dd);
    };
    await api.get();
  }

  submit() async {
    Loading.start();
    String outId = selectedOutlet?.id.toString() ?? '0';
    String outId2 = '0';
    String tipe = '1';
    switch (type) {
      case 'masuk':
        tipe = '1';
        break;
      case 'keluar':
        tipe = '2';
        break;
      case 'pindah':
        tipe = '3';
        outId = dariOutlet?.id.toString() ?? '0';
        outId2 = keOutlet?.id.toString() ?? '0';
        break;
      default:
    }
    final api = API();
    api.url = 'Trx/Add';
    api.body = {
      'act': 'trxAdd',
      'outlet_id': '1',
      'user_id': AuthController.selectedUser?.id.toString(),
      'ptipe': tipe,
      'curr_id': selectedCurrency?.id.toString(),
      'nominal': input.controller?.text,
      'ket': keterangan.controller?.text,
      'outlet_id1': outId,
      'outlet_id2': outId2,
      'tgl': DateFormat('y-MM-dd').format(startDate),
    };

    int count = 0;
    for (var i in photo) {
      ++count;
      if (count == 1) {
        api.body?.addAll({
          'photo': await i.toBase64(),
        });
      } else {
        api.body?.addAll({
          'photo$count': await i.toBase64(),
        });
      }
    }
    api.onSuccess = (d) async {
      final dd = await d.convert();
      if (dd['status']['error'] == 0) {
        Navigator.pop(ENV.navigatorKey.currentContext!);
        SnackBars.success(message: 'Data Berhasil Disimpan');
      }
    };

    api.onError = (d) async {
      final dd = await d.convert();
      print(dd);
    };

    await api.post();
    Loading.close();
  }

  routeMasuk() async {
    sc = ScrollXController();
    outlet = InspectorController();
    inputIC = InspectorController();
    selectedCurrency = InitData.state.currencyType.first;
    photo.clear();
    type = 'masuk';
    selectedOutlet = null;
    startDate = DateTime.now();
    input = MaterialXFormController(controller: TextEditingController(text: '0'));
    keterangan = MaterialXFormController();
    await Navigator.push(ENV.navigatorKey.currentContext!, fadeIn(page: MasukView(controller: this)));
    await dispose();
  }

  routeKeluar() async {
    sc = ScrollXController();
    outlet = InspectorController();
    inputIC = InspectorController();
    selectedCurrency = InitData.state.currencyType.first;
    type = 'keluar';
    selectedOutlet = null;
    startDate = DateTime.now();
    judul = MaterialXFormController();
    input = MaterialXFormController(controller: TextEditingController(text: '0'));
    keterangan = MaterialXFormController();
    await Navigator.push(ENV.navigatorKey.currentContext!, fadeIn(page: KeluarView(controller: this)));
    await dispose();
  }

  routePindah() async {
    sc = ScrollXController();
    darioutC = InspectorController();
    keoutC = InspectorController();
    inputIC = InspectorController();
    selectedCurrency = InitData.state.currencyType.first;
    type = 'pindah';
    photo.clear();
    type = 'masuk';
    startDate = DateTime.now();
    input = MaterialXFormController(controller: TextEditingController(text: '0'));
    keterangan = MaterialXFormController();
    startDate = DateTime.now();
    dariOutlet = null;
    keOutlet = null;
    await Navigator.push(ENV.navigatorKey.currentContext!, fadeIn(page: PindahView(controller: this)));
    await dispose();
  }

  routeMutasi() async {
    sc = ScrollXController();
    keC = InspectorController();
    dariC = InspectorController();
    outlet = InspectorController();
    rangeC = InspectorController();
    type = 'mutasi';
    sd = DateTime.now();
    ed = DateTime.now();
    selectedCurrency = InitData.state.currencyType.first;
    selectedCurrency2 = InitData.state.currencyType.first;
    selectedOutlet = null;
    dari = MaterialXFormController(controller: TextEditingController(text: '0'));
    ke = MaterialXFormController(controller: TextEditingController(text: '0'));
    await Navigator.push(ENV.navigatorKey.currentContext!, fadeIn(page: MutasiView(controller: this)));
    await dispose();
  }

  routePindahKurs() async {
    sc = ScrollXController();
    outlet = InspectorController();
    keC = InspectorController();
    dariC = InspectorController();
    selectedCurrency = InitData.state.currencyType.first;
    selectedCurrency2 = InitData.state.currencyType.first;
    type = 'kurs';
    selectedOutlet = null;
    dari = MaterialXFormController(controller: TextEditingController(text: '0'));
    ke = MaterialXFormController(controller: TextEditingController(text: '0'));
    await Navigator.push(ENV.navigatorKey.currentContext!, fadeIn(page: PindahKursView(controller: this)));
    await dispose();
  }

  dispose() {
    Future.delayed(const Duration(milliseconds: 600), () {
      switch (type) {
        case 'masuk':
          input.dispose();
          keterangan.dispose();
          break;
        case 'keluar':
          input.dispose();
          keterangan.dispose();
          judul.dispose();
          break;
        case 'pindah':
          keterangan.dispose();
          input.dispose();
          break;
        case 'mutasi':
          dari.dispose();
          ke.dispose();
          break;
        case 'kurs':
          dari.dispose();
          ke.dispose();
          break;
        default:
      }
    });

    sc.dispose();
  }
}
