import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:mocktail/mocktail.dart';

class MockDartType extends Mock implements DartType {
  MockDartType({
    this.isString = false,
    this.isBool = false,
    this.isDouble = false,
    this.isInt = false,
    this.isEnum = false,
  });

  final bool isString;
  final bool isBool;
  final bool isDouble;
  final bool isInt;
  final bool isEnum;

  @override
  bool get isDartCoreString => isString;

  @override
  bool get isDartCoreBool => isBool;

  @override
  bool get isDartCoreDouble => isDouble;

  @override
  bool get isDartCoreInt => isInt;

  @override
  Element? get element => isEnum ? MockEnumElement() : null;
}

class MockEnumElement extends Mock implements EnumElement {
  @override
  String get name => 'EnumName';

  @override
  List<FieldElement> get fields => [
        _MockFieldElement('fieldName'),
        _MockFieldElement('fieldName2'),
      ];
}

class _MockFieldElement extends Mock implements FieldElement {
  _MockFieldElement(this.fieldName);

  final String fieldName;

  @override
  String get name => fieldName;

  @override
  bool get isEnumConstant => true;
}
