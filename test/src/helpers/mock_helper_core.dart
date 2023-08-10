import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:mocktail/mocktail.dart';
import 'package:model_test_generator/src/helper_core.dart';

import 'helpers.dart';

class MockHelperCore extends Mock implements HelperCore {
  @override
  ClassElement get element => _MockClassElement();

  @override
  ConstructorElement get constructor => _MockConstructorElement();

  @override
  String get className => 'Foo';
}

class _MockClassElement extends Mock implements ClassElement {}

class _MockConstructorElement extends Mock implements ConstructorElement {
  @override
  List<ParameterElement> get parameters => [
        _MockRequiredPositionalParameterElement(),
        _MockRequiredNamedParameterElement(),
        _MockNamedParameterElement(),
      ];
}

class _MockRequiredPositionalParameterElement extends Mock
    implements ParameterElement {
  @override
  bool get isRequiredPositional => true;

  @override
  bool get isRequiredNamed => false;

  @override
  bool get isPositional => true;

  @override
  bool get isNamed => false;

  @override
  String get name => 'requiredPositionalParameter';

  @override
  DartType get type => MockDartType(isString: true);
}

class _MockRequiredNamedParameterElement extends Mock
    implements ParameterElement {
  @override
  bool get isRequiredNamed => true;

  @override
  bool get isRequiredPositional => false;

  @override
  bool get isPositional => false;

  @override
  bool get isNamed => true;

  @override
  String get name => 'requiredNamedParameter';

  @override
  DartType get type => MockDartType(isString: true);
}

class _MockNamedParameterElement extends Mock implements ParameterElement {
  @override
  bool get isRequiredNamed => false;

  @override
  bool get isRequiredPositional => false;

  @override
  bool get isPositional => false;

  @override
  bool get isNamed => true;

  @override
  String get name => 'namedParameter';

  @override
  DartType get type => MockDartType(isString: true);
}
