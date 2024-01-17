import 'package:flutter/material.dart';
import 'package:keuangan/controller/home_controller.dart';
import 'package:keuangan/controller/init_controller.dart';
import 'package:keuangan/controller/transaction/transaction_base.dart';
import 'package:keuangan/main.dart';
import 'package:keuangan/material/auto_model.dart';
import 'package:keuangan/material/scrollx.dart';
import 'package:keuangan/view/painter/home_painter.dart';

class HomeView extends StatelessWidget {
  final HomeController controller;

  const HomeView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Fresher(
        listener: global,
        builder: (v) {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 230),
                width: double.infinity,
                height: double.infinity,
                color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 180,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Opacity(
                                  opacity: controller.openBar ? 0.5 : 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          InitData.state.outlet?.outletName ?? '...',
                                          style: const TextStyle(
                                            color: Color(0xff2787BD),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Expanded(
                                          child: ScrollX(
                                            controller: controller.sc,
                                            child: Column(
                                              children: InitData.state.currencyType.map((e) {
                                                final i = InitData.state.currencyType.indexOf(e);
                                                return Padding(
                                                  padding: EdgeInsets.only(bottom: i == 3 ? 0 : 16.0, left: 8, right: 50),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                          fontSize: 12,
                                                          color: Colors.black54,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      const Text(
                                                        '0',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color(0xff2787BD),
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: (controller.openBar ? 0 : -1) * (MediaQuery.of(context).size.width * 0.72),
                                top: 0,
                                bottom: 0,
                                child: SizedBox(
                                  width: (MediaQuery.of(context).size.width * 0.9) - 24,
                                  height: double.infinity,
                                  // child: CustomPaint(
                                  //   painter: HomePainter(),
                                  //   child: Column(
                                  //     children: [Text('a')],
                                  //   ),
                                  // ),
                                  child: ClipShadowPath(
                                    shadow: const Shadow(blurRadius: 12, offset: Offset(-2, -2), color: Colors.black38),
                                    clipper: HomeClipper(),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (!controller.openBar) {
                                          controller.openBar = true;
                                          global.refresh((listener) => null);
                                        }
                                      },
                                      child: Container(
                                        color: const Color(0xffC1DDED),
                                        child: Stack(
                                          children: [
                                            const Center(),
                                            Positioned(
                                              left: 8,
                                              top: 0,
                                              bottom: 0,
                                              child: GestureDetector(
                                                onTap: !controller.openBar
                                                    ? null
                                                    : () {
                                                        if (controller.openBar) {
                                                          controller.openBar = false;
                                                          global.refresh((listener) => null);
                                                        }
                                                      },
                                                child: Image.asset(
                                                  controller.openBar ? 'asset/zoom_b.png' : 'asset/open_b.png',
                                                  width: 25,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 50.0, top: 10, bottom: 10, right: 20),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: controller.listMenu
                                                          .map<Widget>(
                                                            (e) => GestureDetector(
                                                              onTap: () {
                                                                if (e.function != null) e.function!();
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Image.asset(
                                                                    e.asset,
                                                                    width: 25,
                                                                  ),
                                                                  Text(
                                                                    e.title ?? '',
                                                                    textAlign: TextAlign.center,
                                                                    style: const TextStyle(color: Color(0xff2787BD), fontWeight: FontWeight.w700, fontSize: 10),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                      child: const Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'Jumlah Barang',
                                                                  style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black54),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  '16',
                                                                  style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black54),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'total IDR',
                                                                  style: TextStyle(color: Color(0xff2787BD), fontSize: 11),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  'Rp. 100.000.000',
                                                                  style: TextStyle(color: Color(0xff2787BD), fontSize: 11),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'total USD',
                                                                  style: TextStyle(color: Color(0xff2787BD), fontSize: 11),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  '\$ 2.000',
                                                                  style: TextStyle(color: Color(0xff2787BD), fontSize: 11),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'Total EUR',
                                                                  style: TextStyle(color: Color(0xff2787BD), fontSize: 11),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  '€ 200',
                                                                  style: TextStyle(color: Color(0xff2787BD), fontSize: 11),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'Total SGD',
                                                                  style: TextStyle(color: Color(0xff2787BD), fontSize: 11),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  'S\$ 1.000',
                                                                  style: TextStyle(color: Color(0xff2787BD), fontSize: 11),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CustomPaint(
                  painter: HomeNavigatorPainter(),
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      width: 35,
                                    ),
                                    const Text(
                                      'App Keuangan',
                                      style: TextStyle(color: Color(0xff2787BD), fontWeight: FontWeight.w700),
                                    ),
                                    Image.asset(
                                      'asset/notifikasi.png',
                                      width: 35,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      controller.menu = Menu.home;
                                      global.refresh((listener) => null);
                                    },
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Image.asset(
                                            controller.menu == Menu.home ? 'asset/home_aktif.png' : 'asset/home_tidak_aktif.png',
                                            width: 55,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Opacity(
                                            opacity: controller.menu == Menu.home ? 1 : 0.2,
                                            child: const Text(
                                              'Home',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Color(0xff2787BD), fontWeight: FontWeight.w700, fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.menu = Menu.transaksi;
                                      global.refresh((listener) => null);
                                    },
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Image.asset(
                                            controller.menu == Menu.transaksi ? 'asset/transaksi_aktif.png' : 'asset/transaksi_tidak_aktif.png',
                                            width: 55,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Opacity(
                                            opacity: controller.menu == Menu.transaksi ? 1 : 0.2,
                                            child: const Text(
                                              'Transaksi',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Color(0xff2787BD), fontWeight: FontWeight.w700, fontSize: 11),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.menu = Menu.laporan;
                                      global.refresh((listener) => null);
                                    },
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Image.asset(
                                            controller.menu == Menu.laporan ? 'asset/laporan_aktif.png' : 'asset/laporan_tidak_aktif.png',
                                            width: 55,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Opacity(
                                            opacity: controller.menu == Menu.laporan ? 1 : 0.2,
                                            child: const Text(
                                              'Laporan',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Color(0xff2787BD), fontWeight: FontWeight.w700, fontSize: 11),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.menu = Menu.tools;
                                      global.refresh((listener) => null);
                                    },
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Image.asset(
                                            controller.menu == Menu.tools ? 'asset/tools_aktif.png' : 'asset/tools_tidak_aktif.png',
                                            width: 55,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Opacity(
                                            opacity: controller.menu == Menu.tools ? 1 : 0.2,
                                            child: const Text(
                                              'Laporan',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Color(0xff2787BD), fontWeight: FontWeight.w700, fontSize: 11),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              TransactionBaseController.state.getTransaction();
                            },
                            child: Image.asset(
                              'asset/refresh.png',
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
