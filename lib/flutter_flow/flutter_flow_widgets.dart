import 'package:flutter/material.dart';

class FFButtonOptions {
  const FFButtonOptions({
    this.width,
    this.height,
    this.padding,
    this.color,
    this.textStyle,
    this.elevation,
    this.borderSide,
    this.borderRadius,
    this.disabledColor,
    this.disabledTextColor,
    this.hoverColor,
    this.hoverTextColor,
    this.hoverElevation,
  });

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final TextStyle? textStyle;
  final double? elevation;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final Color? hoverColor;
  final Color? hoverTextColor;
  final double? hoverElevation;
}

class FFButtonWidget extends StatelessWidget {
  const FFButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.iconData,
    this.options = const FFButtonOptions(),
    this.showLoadingIndicator = false,
  });

  final VoidCallback? onPressed;
  final String text;
  final Widget? icon;
  final IconData? iconData;
  final FFButtonOptions options;
  final bool showLoadingIndicator;

  @override
  Widget build(BuildContext context) {
    final child = showLoadingIndicator
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8),
              ] else if (iconData != null) ...[
                Icon(iconData, size: 18),
                const SizedBox(width: 8),
              ],
              Text(text, style: options.textStyle),
            ],
          );

    return SizedBox(
      width: options.width,
      height: options.height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: options.color,
          disabledBackgroundColor: options.disabledColor,
          elevation: options.elevation,
          padding: options.padding,
          shape: RoundedRectangleBorder(
            borderRadius: options.borderRadius ?? BorderRadius.circular(8),
            side: options.borderSide ?? BorderSide.none,
          ),
        ),
        child: child,
      ),
    );
  }
}
