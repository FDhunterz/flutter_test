import 'package:flutter/material.dart';
import 'package:keuangan/main.dart';
import 'package:keuangan/material/alert/inspector_controller.dart';
import 'package:keuangan/material/auto_model.dart';

class Inspector extends StatelessWidget {
  final keys = GlobalKey();
  final InspectorController controller;
  final Widget child;
  final bool isSafeAreaActive;
  Inspector({Key? key, required this.child, required this.controller, this.isSafeAreaActive = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.cKey = keys;
    controller.isSafeAreaActive = isSafeAreaActive;

    return SizedBox(
      key: controller.cKey,
      child: Builder(
        builder: (v) {
          controller.child = child;
          return controller.child!;
        },
      ),
    );
  }
}
