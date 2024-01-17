import 'package:flutter/material.dart';
import 'package:keuangan/main.dart';
import 'package:keuangan/material/auto_model.dart';
import 'package:request_api_helper/global_env.dart';

class InspectorController {
  Widget? child;
  GlobalKey? cKey;
  Offset? _position;
  bool isSafeAreaActive = false;
  Size? _size;
  bool isActive = false;
  Widget Function(Offset?, Size?)? additionalChild;

  gKey() {
    if (cKey != null) {
      RenderBox? box = cKey!.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        Offset position = box.localToGlobal(Offset.zero);
        _position = position;
        _size = box.size;
      }
    }
  }

  show() async {
    gKey();
    isActive = true;
    global.refresh((listener) => null);
    Future.delayed(const Duration(milliseconds: 100), () {
      global.refresh((listener) => null);
    });
    await _overlay();
  }

  _overlay() async {
    await showDialog(
      context: ENV.navigatorKey.currentContext!,
      builder: (context) {
        return Fresher(
          listener: global,
          builder: (v) {
            return Stack(
              children: [
                // Background: Container hitam dengan opasitas
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                    child: const Center(),
                  ),
                ),
                // Konten overlay (misalnya, loading spinner atau pesan)
                Positioned(
                  left: _position?.dx,
                  top: (_position?.dy ?? 0) - (isSafeAreaActive ? 25 : 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: SizedBox(height: _size!.height, width: _size!.width, child: child ?? const SizedBox()),
                      ),
                    ],
                  ),
                ),

                additionalChild == null ? const SizedBox() : additionalChild!(_position, _size),
              ],
            );
          },
        );
      },
    );
    print('wait');

    isActive = false;
    print(isActive);
    global.refresh((listener) => null);
  }

  InspectorController({this.cKey, this.child});
}
