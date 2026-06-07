import 'package:flutter/foundation.dart';

class FormFieldController<T> extends ValueNotifier<T?> {
  FormFieldController(this._initialValue) : super(_initialValue);

  final T? _initialValue;

  void reset() => value = _initialValue;
}
