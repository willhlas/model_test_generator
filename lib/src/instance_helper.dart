import 'package:model_test_generator/src/helper_core.dart';
import 'package:model_test_generator/src/modifed_instance.dart';
import 'package:model_test_generator/src/parameter_helper.dart';
import 'package:model_test_generator/src/type_to_code.dart';

/// {@template instance_helper}
/// A helper class for generating instances.
/// {@endtemplate}
mixin InstanceHelper implements HelperCore, ParameterHelper {
  /// Creates a required instance of the element.
  String createRequiredInstance() {
    final buffer = StringBuffer('$className(');

    for (final param in requiredPositionalParameters.values) {
      final typeCode = typeToCode(param.type, param.name);

      if (requiredPositionalParameters.length == 1 &&
          requiredNamedParameters.isEmpty) {
        buffer.write('$typeCode');
      } else {
        buffer.write('$typeCode,');
      }
    }

    for (final param in requiredNamedParameters.values) {
      final name = param.name;
      final typeCode = typeToCode(param.type, name);

      if (requiredNamedParameters.length == 1) {
        buffer.write('$name: $typeCode');
      } else {
        buffer.write('$name: $typeCode,');
      }
    }

    buffer.write(')');

    return buffer.toString();
  }

  /// Creates a full instance of the element.
  ModifiedInstance createFullInstance({String? fieldToModify}) {
    dynamic modifiedFieldValue;

    final buffer = StringBuffer('$className(');
    for (final param in positionalParameters.values) {
      final name = param.name;
      final typeCode = typeToCode(
        param.type,
        name,
        useDefault: fieldToModify != name,
      );

      if (fieldToModify == name) {
        modifiedFieldValue = typeCode;
      }

      if (positionalParameters.length == 1 && namedParameters.isEmpty) {
        buffer.write('$typeCode');
      } else {
        buffer.write('$typeCode,');
      }
    }

    for (final param in namedParameters.values) {
      final name = param.name;
      final typeCode = typeToCode(
        param.type,
        name,
        useDefault: fieldToModify != name,
      );

      if (fieldToModify == name) {
        modifiedFieldValue = typeCode;
      }

      if (namedParameters.length == 1) {
        buffer.write('$name: $typeCode');
      } else {
        buffer.write('$name: $typeCode,');
      }
    }

    buffer.write(')');

    return ModifiedInstance(
      instance: buffer.toString(),
      fieldName: fieldToModify ?? 'full',
      fieldValue: modifiedFieldValue.toString(),
    );
  }

  /// Creates a list of modified instances of the element.
  List<String> createModifiedInstances() {
    final list = <String>[];
    for (final param in parameters) {
      list.add(
        createFullInstance(fieldToModify: param.name).instance,
      );
    }

    return list;
  }

  /// Creates a list of modified instances of the element.
  List<ModifiedInstance> createModifiedCopyWithInstances() {
    final list = <ModifiedInstance>[];
    for (final param in parameters) {
      list.add(createFullInstance(fieldToModify: param.name));
    }

    return list;
  }
}
