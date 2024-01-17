import 'package:flutter/material.dart';
import 'package:request_api_helper/global_env.dart';

class CheckIcon extends StatefulWidget {
  final bool status;
  final Size? size;
  const CheckIcon({Key? key, this.status = false, this.size}) : super(key: key);

  @override
  State<CheckIcon> createState() => _CheckIcon();
}

class _CheckIcon extends State<CheckIcon> with TickerProviderStateMixin {
  final tween = Tween(begin: 0.0, end: 1.0);
  late AnimationController controller;

  validator() {
    if (widget.status) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800), reverseDuration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    validator();
    return AnimateScale(
      animation: tween.animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut)),
      tween: tween,
      child: Container(
        width: widget.size?.width ?? 20,
        height: widget.size?.height ?? 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(ENV.navigatorKey.currentContext!).primaryColor,
          border: Border.all(color: Theme.of(ENV.navigatorKey.currentContext!).scaffoldBackgroundColor, width: 1),
        ),
        child: Center(
          child: Icon(
            Icons.check,
            size: widget.size?.width == null ? 12 : widget.size!.width * 0.5,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class AnimateScale extends AnimatedWidget {
  const AnimateScale({Key? key, required Animation<double> animation, required this.child, required this.tween}) : super(key: key, listenable: animation);
  final Tween<double> tween;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.scale(
      scale: tween.evaluate(animation),
      child: child,
    );
  }
}
