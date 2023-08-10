// ignore_for_file: avoid_dynamic_calls, unnecessary_string_interpolations

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

/// Returns a value based on the type.
dynamic typeToCode(
  DartType type,
  String name, {
  bool useDefault = true,
}) {
  final element = type.element;

  if (type.isDartCoreString) {
    return useDefault ? "'$name'" : "'${name}2'";
  } else if (type.isDartCoreBool) {
    return useDefault;
  } else if (type.isDartCoreDouble) {
    return useDefault ? 1.5 : 2.5;
  } else if (type.isDartCoreInt) {
    return useDefault ? 1 : 2;
  } else if (element != null && element is EnumElement) {
    final fields = element.fields
        .where((element) => element.isEnumConstant)
        .map(
          (e) => '${element.name}.${e.name}',
        )
        .toList();

    return useDefault ? fields.first : fields.last;
  }
  return null;
}
