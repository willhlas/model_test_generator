import 'package:model_test_generator/src/helper_core.dart';
import 'package:model_test_generator/src/modifed_instance.dart';

/// {@template test_helper}
/// A helper class for constructing tests.
/// {@endtemplate}
mixin TestHelper implements HelperCore {
  /// Creates a test for instantiating the element.
  String createInstantiationTest(String instance) {
    final buffer = StringBuffer()
      ..writeln("test('can instantiate', () {")
      ..writeln('expect($instance, isNotNull,);')
      ..writeln('});');

    return buffer.toString();
  }

  /// Creates a test for testing equality of the element.
  String createEqualityTest(
    String instance,
    List<String> modifiedInstances,
  ) {
    final buffer = StringBuffer()
      ..writeln("test('supports value equality', () {")
      ..writeln('expect($instance, equals($instance,),);')
      ..writeln();
    for (final modifiedInstance in modifiedInstances) {
      buffer
        ..writeln(
          'expect($instance, isNot(equals($modifiedInstance,),),);',
        )
        ..writeln();
    }
    buffer.writeln('});');

    return buffer.toString();
  }

  /// Creates a test for testing copyWith of the element.
  String createCopyWithTest(
    String instance,
    List<ModifiedInstance> modifiedInstances,
  ) {
    final buffer = StringBuffer()
      ..writeln("group('copyWith', () {")
      ..writeln("test('returns same instance if no fields are passed', () {")
      ..writeln('expect($instance.copyWith(), equals($instance,),);')
      ..writeln('});')
      ..writeln();

    for (final modifiedInstance in modifiedInstances) {
      buffer
        ..writeln("test('returns a new instance with updated "
            "${modifiedInstance.fieldName}', () {")
        ..writeln('expect($instance.copyWith(${modifiedInstance.fieldName}: '
            '${modifiedInstance.fieldValue}), '
            'equals(${modifiedInstance.instance},),);')
        ..writeln('});')
        ..writeln();
    }

    buffer.writeln('});');

    return buffer.toString();
  }
}
