import 'package:keuangan/main.dart';
import 'package:keuangan/model/outlet_model.dart';
import 'package:keuangan/model/trx_model.dart';
import 'package:request_api_helper/request_api_helper.dart';

class InitData {
  static final state = InitData._state();
  OutletModel? outlet;
  List<SubOutlet> subOutlet = [];
  List<TrxType> trxType = [];
  List<PayType> payType = [];
  List<CurrencyType> currencyType = [];

  InitData._state();

  getData() async {
    final api = API();
    api.withLoading = false;
    api.url = 'Auth/initData';
    api.body = {
      "act": "initData",
      'outlet_id': 1,
    };
    api.onSuccess = (d) async {
      try {
        final dd = await d.convert();
        outlet = OutletModel.build(dd['data']['outlet']);
        subOutlet.clear();
        trxType.clear();
        payType.clear();
        currencyType.clear();
        for (var i in dd['data']['outlet_subs']) {
          subOutlet.add(SubOutlet.build(i));
        }

        for (var i in dd['data']['trx_tipe']) {
          trxType.add(TrxType.build(i));
        }

        for (var i in dd['data']['pay_tipe']) {
          payType.add(PayType.build(i));
        }

        for (var i in dd['data']['cur_tipe']) {
          currencyType.add(CurrencyType.build(i));
        }
        global.refresh((listener) => null);
      } catch (_) {}
    };
    await api.get();
  }
}
