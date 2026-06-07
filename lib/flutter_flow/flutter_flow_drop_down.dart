import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'form_field_controller.dart';

class FlutterFlowDropDown<T> extends StatelessWidget {
  const FlutterFlowDropDown({
    super.key,
    required this.controller,
    required this.options,
    required this.onChanged,
    this.hintText,
    this.icon,
    this.width,
    this.height,
    this.textStyle,
    this.hintStyle,
    this.fillColor,
    this.elevation = 2,
    this.borderColor,
    this.borderWidth = 1,
    this.borderRadius = 8,
    this.margin,
    this.hidesUnderline = false,
    this.isOverButton = false,
    this.isSearchable = false,
    this.isMultiSelect = false,
    this.labelText,
    this.labelTextStyle,
    this.disabled = false,
  });

  final FormFieldController<T?> controller;
  final List<T> options;
  final void Function(T?)? onChanged;
  final String? hintText;
  final Widget? icon;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final double elevation;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final bool hidesUnderline;
  final bool isOverButton;
  final bool isSearchable;
  final bool isMultiSelect;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final dropdown = DropdownButton2<T>(
          isExpanded: true,
          hint: hintText != null
              ? Text(hintText!, style: hintStyle ?? textStyle)
              : null,
          items: options
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text('$item', style: textStyle),
                ),
              )
              .toList(),
          value: controller.value,
          onChanged: disabled
              ? null
              : (value) {
                  controller.value = value;
                  onChanged?.call(value);
                },
          buttonStyleData: ButtonStyleData(
            width: width,
            height: height ?? 40,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: fillColor,
              border: Border.all(
                color: borderColor ?? Colors.transparent,
                width: borderWidth,
              ),
            ),
            elevation: elevation.toInt(),
          ),
          iconStyleData: IconStyleData(
            icon: icon ?? const Icon(Icons.keyboard_arrow_down_rounded),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        );

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: hidesUnderline
          ? DropdownButtonHideUnderline(child: dropdown)
          : dropdown,
    );
  }
}
