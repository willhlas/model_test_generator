import 'package:model_test_generator/src/type_to_code.dart';
import 'package:test/test.dart';

import 'helpers/helpers.dart';

void main() {
  group('typeToCode', () {
    group('String', () {
      final type = MockDartType(isString: true);

      test('returns default value', () {
        expect(typeToCode(type, 'foo'), "'foo'");
      });

      test('returns alternate value', () {
        expect(
          typeToCode(type, 'foo', useDefault: false),
          "'foo2'",
        );
      });
    });

    group('Bool', () {
      final type = MockDartType(isBool: true);

      test('returns default value', () {
        expect(typeToCode(type, 'foo'), isTrue);
      });

      test('returns alternate value', () {
        expect(typeToCode(type, 'foo', useDefault: false), isFalse);
      });
    });

    group('Double', () {
      final type = MockDartType(isDouble: true);

      test('returns default value', () {
        expect(typeToCode(type, 'foo'), 1.5);
      });

      test('returns alternate value', () {
        expect(typeToCode(type, 'foo', useDefault: false), 2.5);
      });
    });

    group('Int', () {
      final type = MockDartType(isInt: true);

      test('returns default value', () {
        expect(typeToCode(type, 'foo'), 1);
      });

      test('returns alternate value', () {
        expect(typeToCode(type, 'foo', useDefault: false), 2);
      });
    });

    group('Enum', () {
      test('returns first value in enum fields', () {
        final type = MockDartType(isEnum: true);

        expect(
          typeToCode(type, 'foo'),
          'EnumName.fieldName',
        );
      });

      test('returns last value in enum fields if alternate', () {
        final type = MockDartType(isEnum: true);

        expect(
          typeToCode(type, 'foo', useDefault: false),
          'EnumName.fieldName2',
        );
      });
    });
  });
}
