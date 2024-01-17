import 'package:keuangan/controller/helper/int_helper.dart';

class TrxType {
  int id, outletId;
  String nama, trx;
  bool delStatus;

  static TrxType build(data) {
    return TrxType(
      id: saveInt(data['id']),
      outletId: saveInt(data['outlet_id']),
      delStatus: data['del_status'] == 1,
      nama: data['nama'],
      trx: data['trx'],
    );
  }

  TrxType({
    this.delStatus = false,
    required this.id,
    required this.nama,
    required this.outletId,
    required this.trx,
  });
}

class PayType {
  int id, outletId;
  String? nama, desc, qrisData, qrisImage, http;
  bool delStatus;

  static PayType build(data) {
    return PayType(
      id: saveInt(data['byr_id']),
      outletId: saveInt(data['outlet_id']),
      delStatus: data['del_status'] == 1,
      desc: data['byr_desc'],
      http: data['byr_http'],
      nama: data['byr_nama'],
      qrisData: data['byr_qris_data'],
      qrisImage: data['byr_qris_image'],
    );
  }

  PayType({
    this.delStatus = false,
    this.desc,
    this.http,
    required this.id,
    this.nama,
    required this.outletId,
    this.qrisData,
    this.qrisImage,
  });
}

class CurrencyType {
  int id;
  String? nama, logo, ket;

  static CurrencyType build(data) {
    return CurrencyType(
      id: saveInt(data['ct_id']),
      ket: data['ct_ket'],
      logo: data['ct_logo'],
      nama: data['ct_nama'],
    );
  }

  CurrencyType({
    required this.id,
    this.ket,
    this.logo,
    this.nama,
  });
}
