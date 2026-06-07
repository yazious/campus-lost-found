import 'package:flutter/widgets.dart';

/// Stub for FlutterFlow custom icon data support.
class FFIconData {
  const FFIconData(this.codePoint, {this.fontFamily, this.fontPackage});

  final int codePoint;
  final String? fontFamily;
  final String? fontPackage;

  IconData toIconData() => IconData(
        codePoint,
        fontFamily: fontFamily,
        fontPackage: fontPackage,
      );
}
