import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keuangan/controller/init_controller.dart';
import 'package:keuangan/controller/transaction/transaction_base.dart';
import 'package:keuangan/main.dart';
import 'package:keuangan/material/alert/inspector.dart';
import 'package:keuangan/material/auto_model.dart';
import 'package:keuangan/material/base_control.dart';
import 'package:keuangan/material/button.dart';
import 'package:keuangan/material/form.dart';
import 'package:keuangan/material/picker.dart';
import 'package:keuangan/material/scrollx.dart';

class MutasiView extends StatelessWidget {
  final TransactionBaseController controller;
  const MutasiView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseControl(
      child: Scaffold(
        backgroundColor: const Color(0xff2787BD),
        body: Fresher<bool>(
          listener: global,
          builder: (v) {
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(offset: Offset(0, 0), blurRadius: 10, color: Colors.black38)]),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.chevron_left,
                                    color: Color(0xff2787BD),
                                    size: 40,
                                  ),
                                ),
                                const Text(
                                  'Mutasi',
                                  style: TextStyle(color: Color(0xff2787BD), fontWeight: FontWeight.w700, fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NoSplashButton(
                                onTap: () {
                                  if (controller.outlet.isActive) {
                                    Navigator.pop(context);
                                  } else {
                                    controller.outlet.show();
                                    controller.outlet.additionalChild = (p, s) {
                                      return Positioned(
                                        left: p!.dx,
                                        top: p.dy + 20,
                                        child: SizedBox(
                                          width: s!.width,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(14),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: InitData.state.subOutlet
                                                    .map(
                                                      (e) => Padding(
                                                        padding: const EdgeInsets.only(bottom: 8.0),
                                                        child: NoSplashButton(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                            controller.selectedOutlet = e;
                                                            global.refresh((listener) => null);
                                                          },
                                                          child: SizedBox(
                                                            width: double.infinity,
                                                            child: Text(
                                                              e.outletName,
                                                              style: const TextStyle(color: Color(0xff2787BD), fontWeight: FontWeight.w700, fontSize: 16),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    };
                                  }
                                },
                                child: Inspector(
                                  isSafeAreaActive: true,
                                  controller: controller.outlet,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(minWidth: 150),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffC1DDED),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            controller.selectedOutlet == null ? 'Pilih Outlet' : controller.selectedOutlet?.outletName ?? '',
                                            style: const TextStyle(
                                              color: Color(0xff2787BD),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Image.asset(
                                            controller.outlet.isActive ? 'asset/chevron_up.png' : 'asset/chevron_down.png',
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NoSplashButton(
                                onTap: () {
                                  if (controller.rangeC.isActive) {
                                    Navigator.pop(context);
                                  } else {
                                    controller.rangeC.show();
                                    controller.rangeC.additionalChild = (p, s) {
                                      return Positioned(
                                        left: 0,
                                        right: 0,
                                        top: p!.dy + 20,
                                        child: StatefulBuilder(builder: (context, state) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                            child: SizedBox(
                                              width: s!.width,
                                              child: Material(
                                                color: Colors.transparent,
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(14),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      const Text(
                                                        'Filter',
                                                        style: TextStyle(color: Color(0xff2787BD), fontWeight: FontWeight.w600, fontSize: 14),
                                                      ),
                                                      const SizedBox(
                                                        height: 18,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.all(8),
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(12),
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color: Colors.black26,
                                                                  offset: Offset(0, 0),
                                                                  blurRadius: 10,
                                                                )
                                                              ],
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  'Jenis Laporan',
                                                                  style: TextStyle(
                                                                    color: Color(0xff2787BD),
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Image.asset(
                                                                  'asset/chevron_down.png',
                                                                  width: 10,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              const Text(
                                                                'Start Date',
                                                                style: TextStyle(color: Color(0xff2787BD), fontSize: 11),
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      showDatePicker(currentDate: controller.sd!, context: context, firstDate: DateTime(2000), lastDate: DateTime(2200)).then((value) {
                                                                        if (value != null) {
                                                                          if (int.parse(DateFormat('yMMdd').format(controller.ed!)) < int.parse(DateFormat('yMMdd').format(value))) {
                                                                            controller.ed = value;
                                                                          }
                                                                          controller.sd = value;
                                                                          state(() {});
                                                                        }
                                                                      });
                                                                    },
                                                                    child: Container(
                                                                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                                                                      decoration: BoxDecoration(
                                                                        color: const Color(0xffC1DDED),
                                                                        borderRadius: BorderRadius.circular(8),
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                            color: Colors.black26,
                                                                            offset: Offset(0, 0),
                                                                            blurRadius: 10,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            DateFormat(InitData.state.outlet?.dateFormat).format(controller.sd!),
                                                                            style: const TextStyle(
                                                                              color: Color(0xff2787BD),
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            width: 50,
                                                          ),
                                                          Column(
                                                            children: [
                                                              const Text(
                                                                'To Date',
                                                                style: TextStyle(color: Color(0xff2787BD), fontSize: 11),
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      showDatePicker(currentDate: controller.sd!, context: context, firstDate: DateTime(2000), lastDate: DateTime(2200)).then((value) {
                                                                        if (value != null) {
                                                                          if (int.parse(DateFormat('yMMdd').format(controller.sd!)) > int.parse(DateFormat('yMMdd').format(value))) {
                                                                            controller.sd = value;
                                                                          }
                                                                          controller.ed = value;
                                                                          state(() {});
                                                                        }
                                                                      });
                                                                    },
                                                                    child: Container(
                                                                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                                                                      decoration: BoxDecoration(
                                                                        color: const Color(0xffC1DDED),
                                                                        borderRadius: BorderRadius.circular(8),
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                            color: Colors.black26,
                                                                            offset: Offset(0, 0),
                                                                            blurRadius: 10,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            DateFormat(InitData.state.outlet?.dateFormat).format(controller.ed!),
                                                                            style: const TextStyle(
                                                                              color: Color(0xff2787BD),
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 40,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            decoration: const BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  offset: Offset(0, 0),
                                                                  color: Colors.black12,
                                                                  blurRadius: 10,
                                                                )
                                                              ],
                                                            ),
                                                            child: MaterialXButton(
                                                              onTap: () {},
                                                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                                                              color: const Color(0xff2787BD),
                                                              textColor: Colors.white,
                                                              title: 'Submit',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      );
                                    };
                                  }
                                },
                                child: Inspector(
                                  isSafeAreaActive: true,
                                  controller: controller.rangeC,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(minWidth: 150),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffC1DDED),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Jenis Laporan ${DateFormat(InitData.state.outlet?.dateFormat).format(controller.sd!)} - ${DateFormat(InitData.state.outlet?.dateFormat).format(controller.ed!)}',
                                            style: const TextStyle(
                                              color: Color(0xff2787BD),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Image.asset(
                                            controller.rangeC.isActive ? 'asset/chevron_up.png' : 'asset/chevron_down.png',
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ScrollX(
                        controller: controller.sc,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Dari',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Inspector(
                              controller: controller.dariC,
                              isSafeAreaActive: true,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [BoxShadow(offset: Offset(0, 0), blurRadius: 10, color: Colors.black38)],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: MaterialXForm(
                                            textAlign: TextAlign.right,
                                            controller: controller.dari,
                                            isCurrency: true,
                                            textColor: const Color(0xff2787BD),
                                            onChanged: (d) {
                                              if (d == '') {
                                                controller.dari.controller!.text = '0';
                                              }
                                            },
                                            flat: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                          child: DottedLine(
                                            direction: Axis.vertical,
                                            lineLength: 20,
                                            lineThickness: 1.0,
                                            dashLength: 4.0,
                                            dashColor: Color(0xff2787BD),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        NoSplashButton(
                                          onTap: () {
                                            controller.dariC.show();
                                            controller.dariC.additionalChild = (p, s) {
                                              return Positioned(
                                                right: p!.dx + 20,
                                                top: p.dy + 20,
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: Container(
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(14),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: InitData.state.currencyType
                                                          .map(
                                                            (e) => Padding(
                                                              padding: const EdgeInsets.only(bottom: 8.0),
                                                              child: NoSplashButton(
                                                                onTap: () {
                                                                  Navigator.pop(context);
                                                                  controller.selectedCurrency = e;
                                                                  global.refresh((listener) => null);
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      'asset/currency/${e.nama}.png',
                                                                      width: 30,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 8,
                                                                    ),
                                                                    Text(
                                                                      e.nama ?? '',
                                                                      style: const TextStyle(
                                                                        color: Color(0xff2787BD),
                                                                        fontWeight: FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 18,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            };
                                          },
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'asset/currency/${controller.selectedCurrency?.nama}.png',
                                                width: 30,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                controller.selectedCurrency?.nama ?? '',
                                                style: const TextStyle(
                                                  color: Color(0xff2787BD),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Image.asset(
                                                controller.dariC.isActive ? 'asset/chevron_up.png' : 'asset/chevron_down.png',
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Ke',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Inspector(
                              controller: controller.keC,
                              isSafeAreaActive: true,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [BoxShadow(offset: Offset(0, 0), blurRadius: 10, color: Colors.black38)],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: MaterialXForm(
                                            textAlign: TextAlign.right,
                                            controller: controller.ke,
                                            isCurrency: true,
                                            textColor: const Color(0xff2787BD),
                                            onChanged: (d) {
                                              if (d == '') {
                                                controller.ke.controller!.text = '0';
                                              }
                                            },
                                            flat: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                          child: DottedLine(
                                            direction: Axis.vertical,
                                            lineLength: 20,
                                            lineThickness: 1.0,
                                            dashLength: 4.0,
                                            dashColor: Color(0xff2787BD),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        NoSplashButton(
                                          onTap: () {
                                            controller.keC.show();
                                            controller.keC.additionalChild = (p, s) {
                                              return Positioned(
                                                right: p!.dx + 20,
                                                top: p.dy + 20,
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: Container(
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(14),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: InitData.state.currencyType
                                                          .map(
                                                            (e) => Padding(
                                                              padding: const EdgeInsets.only(bottom: 8.0),
                                                              child: NoSplashButton(
                                                                onTap: () {
                                                                  Navigator.pop(context);
                                                                  controller.selectedCurrency2 = e;
                                                                  global.refresh((listener) => null);
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      'asset/currency/${e.nama}.png',
                                                                      width: 30,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 8,
                                                                    ),
                                                                    Text(
                                                                      e.nama ?? '',
                                                                      style: const TextStyle(
                                                                        color: Color(0xff2787BD),
                                                                        fontWeight: FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 18,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            };
                                          },
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'asset/currency/${controller.selectedCurrency2?.nama}.png',
                                                width: 30,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                controller.selectedCurrency2?.nama ?? '',
                                                style: const TextStyle(
                                                  color: Color(0xff2787BD),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Image.asset(
                                                controller.keC.isActive ? 'asset/chevron_up.png' : 'asset/chevron_down.png',
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: MaterialXButton(
                          onTap: () {},
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                          color: const Color(0xffC1DDED),
                          textColor: const Color(0xff2787BD),
                          title: 'Submit',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
