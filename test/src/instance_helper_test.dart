// ignore_for_file: missing_whitespace_between_adjacent_strings
// ignore_for_file: no_adjacent_strings_in_list

import 'package:model_test_generator/src/instance_helper.dart';
import 'package:model_test_generator/src/modifed_instance.dart';
import 'package:model_test_generator/src/parameter_helper.dart';
import 'package:test/test.dart';

import 'helpers/helpers.dart';

class _Class extends MockHelperCore with InstanceHelper, ParameterHelper {}

void main() {
  group('InstanceHelper', () {
    group('createRequiredInstance', () {
      test('returns correct value', () {
        final result = _Class().createRequiredInstance();
        const expected = "Foo('requiredPositionalParameter',"
            "requiredNamedParameter: 'requiredNamedParameter',)";
        expect(result, expected);
      });
    });

    group('createFullInstance', () {
      test('returns correct ModifiedInstance', () {
        final result = _Class().createFullInstance();
        const expected = "Foo('requiredPositionalParameter',"
            "requiredNamedParameter: 'requiredNamedParameter',"
            "namedParameter: 'namedParameter',)";
        expect(
          result,
          isA<ModifiedInstance>()
              .having(
                (m) => m.instance,
                'instance',
                expected,
              )
              .having((m) => m.fieldName, 'fieldName', 'full')
              .having((m) => m.fieldValue, 'fieldValue', 'null'),
        );
      });

      test('returns correct ModifiedInstance with fieldToModify', () {
        final result = _Class().createFullInstance(
          fieldToModify: 'requiredNamedParameter',
        );
        const expected = "Foo('requiredPositionalParameter',"
            "requiredNamedParameter: 'requiredNamedParameter2',"
            "namedParameter: 'namedParameter',)";
        expect(
          result,
          isA<ModifiedInstance>()
              .having(
                (m) => m.instance,
                'instance',
                expected,
              )
              .having((m) => m.fieldName, 'fieldName', 'requiredNamedParameter')
              .having(
                (m) => m.fieldValue,
                'fieldValue',
                "'requiredNamedParameter2'",
              ),
        );
      });
    });

    group('createModifiedInstances', () {
      test('returns correct value', () {
        final result = _Class().createModifiedInstances();
        const expected = [
          "Foo('requiredPositionalParameter2',"
              "requiredNamedParameter: 'requiredNamedParameter',"
              "namedParameter: 'namedParameter',)",
          "Foo('requiredPositionalParameter',"
              "requiredNamedParameter: 'requiredNamedParameter2',"
              "namedParameter: 'namedParameter',)",
          "Foo('requiredPositionalParameter',"
              "requiredNamedParameter: 'requiredNamedParameter',"
              "namedParameter: 'namedParameter2',)",
        ];
        expect(result, expected);
      });
    });

    group('createModifiedCopyWithInstances', () {
      test('returns correct value', () {
        final result = _Class().createModifiedCopyWithInstances();
        const expected = [
          ModifiedInstance(
            instance: "Foo('requiredPositionalParameter2',"
                "requiredNamedParameter: 'requiredNamedParameter',"
                "namedParameter: 'namedParameter',)",
            fieldName: 'requiredPositionalParameter',
            fieldValue: 'requiredPositionalParameter2',
          ),
          ModifiedInstance(
            instance: "Foo('requiredPositionalParameter',"
                "requiredNamedParameter: 'requiredNamedParameter2',"
                "namedParameter: 'namedParameter',)",
            fieldName: 'requiredNamedParameter',
            fieldValue: 'requiredNamedParameter2',
          ),
          ModifiedInstance(
            instance: "Foo('requiredPositionalParameter',"
                "requiredNamedParameter: 'requiredNamedParameter',"
                "namedParameter: 'namedParameter2',)",
            fieldName: 'namedParameter',
            fieldValue: 'namedParameter2',
          ),
        ];

        for (final i in result) {
          final index = result.indexOf(i);
          expect(i.instance, expected[index].instance);
          expect(i.fieldName, expected[index].fieldName);
        }
      });
    });
  });
}
