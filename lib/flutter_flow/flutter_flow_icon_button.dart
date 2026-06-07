import 'package:flutter/material.dart';

class FlutterFlowIconButton extends StatelessWidget {
  const FlutterFlowIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.buttonSize = 40,
    this.fillColor,
    this.borderColor,
    this.borderRadius = 8,
    this.borderWidth = 0,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final double buttonSize;
  final Color? fillColor;
  final Color? borderColor;
  final double borderRadius;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: fillColor ?? Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: borderWidth > 0
                ? Border.all(
                    color: borderColor ?? Colors.transparent,
                    width: borderWidth,
                  )
                : null,
          ),
          alignment: Alignment.center,
          child: icon,
        ),
      ),
    );
  }
}
