import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseControl extends StatelessWidget {
  final Function? onTapScreen;
  final Widget? child;
  const BaseControl({Key? key, this.onTapScreen, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
        SystemChrome.restoreSystemUIOverlays();
        if (onTapScreen != null) {
          onTapScreen!();
        }
      },
      child: child,
    );
  }
}
