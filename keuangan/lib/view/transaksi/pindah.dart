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

class PindahView extends StatelessWidget {
  final TransactionBaseController controller;
  const PindahView({Key? key, required this.controller}) : super(key: key);

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
                                  'Pindah',
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  NoSplashButton(
                                    onTap: () {
                                      if (controller.darioutC.isActive) {
                                        Navigator.pop(context);
                                      } else {
                                        controller.darioutC.show();
                                        controller.darioutC.additionalChild = (p, s) {
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
                                                                if (controller.keOutlet == e) {
                                                                  controller.keOutlet = null;
                                                                }
                                                                controller.dariOutlet = e;
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
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Dari',
                                          style: TextStyle(color: Color(0xff2787BD), fontSize: 11),
                                        ),
                                        Inspector(
                                          isSafeAreaActive: true,
                                          controller: controller.darioutC,
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
                                                    controller.dariOutlet == null ? 'Pilih Outlet' : controller.dariOutlet?.outletName ?? '',
                                                    style: const TextStyle(
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
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  NoSplashButton(
                                    onTap: () {
                                      if (controller.keoutC.isActive) {
                                        Navigator.pop(context);
                                      } else {
                                        controller.keoutC.show();
                                        controller.keoutC.additionalChild = (p, s) {
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
                                                                if (controller.dariOutlet == e) {
                                                                  controller.dariOutlet = null;
                                                                }
                                                                Navigator.pop(context);
                                                                controller.keOutlet = e;
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
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Ke',
                                          style: TextStyle(color: Color(0xff2787BD), fontSize: 11),
                                        ),
                                        Inspector(
                                          isSafeAreaActive: true,
                                          controller: controller.keoutC,
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
                                                    controller.keOutlet == null ? 'Pilih Outlet' : controller.keOutlet?.outletName ?? '',
                                                    style: const TextStyle(
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
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
                              'Start Date',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: NoSplashButton(
                                onTap: () async {
                                  await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now(),
                                    currentDate: controller.startDate,
                                  ).then((value) {
                                    if (value != null) {
                                      controller.startDate = value;
                                      global.refresh((listener) => null);
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [BoxShadow(offset: Offset(0, 0), blurRadius: 10, color: Colors.black38)],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      DateFormat(InitData.state.outlet?.dateFormat).format(controller.startDate),
                                      style: const TextStyle(
                                        color: Color(0xff2787BD),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Input',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Inspector(
                              controller: controller.inputIC,
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
                                            controller: controller.input,
                                            isCurrency: true,
                                            textColor: const Color(0xff2787BD),
                                            onChanged: (d) {
                                              if (d == '') {
                                                controller.input.controller!.text = '0';
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
                                            controller.inputIC.show();
                                            controller.inputIC.additionalChild = (p, s) {
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
                                                controller.inputIC.isActive ? 'asset/chevron_up.png' : 'asset/chevron_down.png',
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
                              'Photo',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [BoxShadow(offset: Offset(0, 0), blurRadius: 10, color: Colors.black38)],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    const Center(),
                                    for (var i in controller.photo)
                                      SizedBox(
                                        height: 85,
                                        width: 100,
                                        child: GestureDetector(
                                          onTap: () {
                                            i.open();
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: i.getThumnail(),
                                          ),
                                        ),
                                      ),
                                    controller.photo.length < 4
                                        ? GestureDetector(
                                            onTap: () async {
                                              final d = await imagePicker();
                                              if (d != null) {
                                                controller.photo.add(d);
                                                global.refresh((listener) => null);
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: const Color(0xffC1DDED),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'asset/photo.png',
                                                    width: 30,
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  const Text(
                                                    'Tambahkan\nFoto',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color(0xff2787BD),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Keterangan',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [BoxShadow(offset: Offset(0, 0), blurRadius: 10, color: Colors.black38)],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: MaterialXForm(
                                  controller: controller.keterangan,
                                  maxLines: null,
                                  flat: true,
                                  centerTextField: true,
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
                          onTap: () {
                            controller.submit();
                          },
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
