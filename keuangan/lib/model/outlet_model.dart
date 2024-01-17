import 'package:keuangan/controller/helper/int_helper.dart';

class OutletModel {
  int id, decimalDigit, hppMode, userId, parentId, orderId, maxSub, outletMode;
  String? outletName, outletCode, outletAddress, outletPhone, invoicePrint, invoiceFooter, dateFormat, timeZone, currency, taxRegistrationTitle, taxRegistrationNo, taxTitle, stateCode, preOrPostPayment;
  bool currencyShow, decimalShow, decimalZeroHide, showIngCode, cekAksesBydb, collectTax, taxUseGlobal, taxIsGst, delStatus;
  DateTime startingDate;

  static OutletModel build(data) {
    return OutletModel(
      id: saveInt(data['id']),
      decimalDigit: saveInt(data['decimal_digit']),
      hppMode: saveInt(data['hpp_mode']),
      userId: saveInt(data['user_id']),
      parentId: saveInt(data['parent_id']),
      orderId: saveInt(data['order_id']),
      maxSub: saveInt(data['max_sub']),
      startingDate: DateTime.parse(
        data['starting_date'],
      ),
      cekAksesBydb: saveInt(data['cek_akses_bydb']) == 1,
      collectTax: data['collect_tax'] == 'Yes',
      currency: data['currency'],
      currencyShow: saveInt(data['currency_show']) == 1,
      dateFormat: data['date_format'].toString().replaceAll('Y', 'y').replaceAll('m', 'MM').replaceAll('d', 'dd'),
      decimalShow: saveInt(data['decimal_show']) == 1,
      decimalZeroHide: saveInt(data['decimal_zero_hide']) == 1,
      delStatus: data['del_status'] != 'Live',
      invoiceFooter: data['invoice_footer'],
      invoicePrint: data['invoice_print'],
      outletAddress: data['outlet_address'],
      outletCode: data['outlet_code'],
      outletMode: saveInt(data['outlet_mode']),
      outletName: data['outlet_name'],
      outletPhone: data['outlet_phone'],
      preOrPostPayment: data['pre_or_post_payment'],
      showIngCode: saveInt(data['show_ing_code']) == 1,
      stateCode: data['state_code'],
      taxIsGst: data['tax_is_gst'] == 'Yes',
      taxRegistrationNo: data['tax_registration_no'],
      taxRegistrationTitle: data['tax_registration_title'],
      taxTitle: data['tax_title'],
      taxUseGlobal: saveInt(data['tax_use_global']) == 1,
      timeZone: data['time_zone'],
    );
  }

  OutletModel({
    required this.id,
    required this.decimalDigit,
    required this.hppMode,
    required this.userId,
    required this.parentId,
    required this.orderId,
    required this.maxSub,
    this.outletName,
    this.outletCode,
    this.outletAddress,
    this.outletPhone,
    this.invoicePrint,
    this.invoiceFooter,
    this.dateFormat,
    this.timeZone,
    this.currency,
    this.taxRegistrationTitle,
    this.taxRegistrationNo,
    this.taxTitle,
    this.stateCode,
    this.preOrPostPayment,
    this.currencyShow = false,
    this.decimalShow = false,
    this.decimalZeroHide = false,
    required this.outletMode,
    this.showIngCode = false,
    this.cekAksesBydb = false,
    this.collectTax = false,
    this.taxUseGlobal = false,
    this.taxIsGst = false,
    this.delStatus = false,
    required this.startingDate,
  });
}

class SubOutlet {
  int id, parentId, orderID;
  String outletName;

  static SubOutlet build(data) {
    return SubOutlet(
      id: saveInt(data['id']),
      outletName: data['outlet_name'],
      orderID: saveInt(data['order_id']),
      parentId: saveInt(data['parent_id']),
    );
  }

  SubOutlet({
    required this.id,
    required this.orderID,
    required this.outletName,
    required this.parentId,
  });
}
