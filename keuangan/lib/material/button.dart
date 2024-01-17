import 'package:flutter/material.dart';

class NoSplashButton extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final Function()? onLongPress;
  const NoSplashButton({Key? key, required this.child, this.onTap, this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      onLongPress: onLongPress,
      child: child,
    );
  }
}

class MaterialXButton extends StatelessWidget {
  final String? title;
  final Color? color;
  final Color? textColor;
  final Function? onTap;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final bool? active;
  final bool isCircle;
  final BorderRadiusGeometry? borderRadius;
  const MaterialXButton({Key? key, this.title = '', this.onTap, this.color, this.textColor, this.child, this.padding, this.active, this.isCircle = false, this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool haveActive = false;
    bool actives = true;
    if (active != null) {
      haveActive = true;
      actives = active!;
    }
    return Opacity(
      opacity: actives ? 1 : 0.3,
      child: Material(
        color: Colors.transparent,
        borderRadius: isCircle ? null : const BorderRadius.all(Radius.circular(16)),
        child: Material(
          color: !haveActive ? (color ?? const Color(0xff184098)) : (actives ? (color ?? const Color(0xff184098)) : color ?? Colors.white),
          type: isCircle ? MaterialType.circle : MaterialType.card,
          borderRadius: isCircle ? null : borderRadius ?? const BorderRadius.all(Radius.circular(16)),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(isCircle ? 200 : 16)),
            onTap: !actives || onTap == null
                ? null
                : () {
                    if (onTap != null) {
                      onTap!();
                    }
                  },
            child: Padding(
              padding: padding ?? const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12),
              child: Center(
                child: child ??
                    Text(
                      '$title',
                      style: TextStyle(
                        color: !haveActive ? (textColor ?? Colors.white) : (actives ? (textColor ?? Colors.white) : null),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
