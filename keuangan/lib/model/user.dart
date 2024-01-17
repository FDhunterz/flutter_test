import 'package:keuangan/controller/helper/int_helper.dart';

class User {
  // {id: 1, full_name: Master, phone: 0816, email_address: admin@admin.com, password: admin, designation: , will_login: Yes, role: Admin, outlet_id: 1, company_id: 1, account_creation_date: 2018-02-07 07:28:32, language: indonesia, last_login: 2021-11-08 14:09:31, active_status: Active, recover_token: null, recover_valid: null, del_status: Live, outlet_name: Induk}
  int id, outletId, companyId;
  String? name, phone, email, password, designation, role;
  bool activeStatus;

  static User build(data) {
    return User(
      activeStatus: data['active_status'] == 'Active',
      companyId: saveInt(data['company_id']),
      email: data['email_address'],
      id: saveInt(data['id']),
      name: data['full_name'],
      outletId: saveInt(data['outlet_id']),
      password: data['password'],
      phone: data['phone'],
      role: data['role'],
      designation: data['designation'],
    );
  }

  User({
    required this.id,
    required this.outletId,
    required this.companyId,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    this.designation,
    required this.role,
    required this.activeStatus,
  });
}
