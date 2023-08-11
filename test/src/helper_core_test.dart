import 'package:analyzer/dart/element/element.dart';
import 'package:mocktail/mocktail.dart';
import 'package:model_test_generator/src/helper_core.dart';
import 'package:test/test.dart';

class _Class extends HelperCore {
  _Class(super.element);
}

class _MockClassElement extends Mock implements ClassElement {
  @override
  ConstructorElement? get unnamedConstructor => null;

  @override
  String get name => 'Foo';
}

void main() {
  group('HelperCore', () {
    group('constructor', () {
      test('throws Exception if no default constructor can be found', () {
        final dartClass = _Class(_MockClassElement());

        expect(
          // ignore: invalid_use_of_protected_member
          () => dartClass.constructor,
          throwsException,
        );
      });
    });
  });
}
