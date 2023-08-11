import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';
import 'package:model_test_generator/src/generator_helper.dart';
import 'package:test/test.dart';

import 'helpers/mock_helper_core.dart';

class _MockHookContext extends Mock implements HookContext {}

void main() {
  group('GeneratorHelper', () {
    late GeneratorHelper generatorHelper;
    late HookContext context;

    setUp(() {
      generatorHelper = GeneratorHelper(MockClassElement());
      context = _MockHookContext();
      when(() => context.vars).thenReturn(<String, dynamic>{});
    });

    test('can instantiate', () {
      expect(generatorHelper, isNotNull);
    });

    group('generateForMason', () {
      test('adds variables to mason', () async {
        await generatorHelper.generateForMason(context);
        expect(context.vars['fileName'], 'foo');
        expect(context.vars['pathToFile'], 'package:foo/foo.dart');
        expect(context.vars['instantionTest'], _expectedInstantiationTest);
        expect(context.vars['equalityTest'], _expectedEqualityTest);
        expect(context.vars['copyWithTest'], _expectedCopyWithTest);
      });
    });
  });
}

const _expectedInstantiationTest = '''
test('can instantiate', () {
expect(Foo('requiredPositionalParameter',requiredNamedParameter: 'requiredNamedParameter',), isNotNull,);
});
''';

const _expectedEqualityTest = '''
test('supports value equality', () {
expect(Foo('requiredPositionalParameter',requiredNamedParameter: 'requiredNamedParameter',namedParameter: 'namedParameter',), equals(Foo('requiredPositionalParameter',requiredNamedParameter: 'requiredNamedParameter',namedParameter: 'namedParameter',),),);

expect(Foo('requiredPositionalParameter',requiredNamedParameter: 'requiredNamedParameter',namedParameter: 'namedParameter',), isNot(equals(Foo('requiredPositionalParameter2',requiredNamedParameter: 'requiredNamedParameter',namedParameter: 'namedParameter',),),),);

expect(Foo('requiredPositionalParameter',requiredNamedParameter: 'requiredNamedParameter',namedParameter: 'namedParameter',), isNot(equals(Foo('requiredPositionalParameter',requiredNamedParameter: 'requiredNamedParameter2',namedParameter: 'namedParameter',),),),);

expect(Foo('requiredPositionalParameter',requiredNamedParameter: 'requiredNamedParameter',namedParameter: 'namedParameter',), isNot(equals(Foo('requiredPositionalParameter',requiredNamedParameter: 'requiredNamedParameter',namedParameter: 'namedParameter2',),),),);

});
''';

const _expectedCopyWithTest = '''
group('copyWith', () {
test('returns same instance if no fields are passed', () {
expect(Foo('requiredPositionalParameter',requiredNamedParameter: 'requiredNamedParameter',namedParameter: 'namedParameter',).copyWith(), equals(Foo('requiredPositionalParameter',requiredNamedParameter: 'requiredNamedParameter',namedParameter: 'namedParameter',),),);
});

test('returns a new instance with updated requiredPositionalParameter', () {
expect(Foo('requiredPositionalParameter',requiredNamedParameter: 'requiredNamedParameter',namedParameter: 'namedParameter',).copyWith(requiredPositionalParameter: 'requiredPositionalParameter2'), equals(Foo('requiredPositionalParameter2',requiredNamedParameter: 'requiredNamedParameter',namedParameter: 'namedParameter',),),);
});

test('returns a new instance with updated requiredNamedParameter', () {
expect(Foo('requiredPositionalParameter',requiredNamedParameter: 'requiredNamedParameter',namedParameter: 'namedParameter',).copyWith(requiredNamedParameter: 'requiredNamedParameter2'), equals(Foo('requiredPositionalParameter',requiredNamedParameter: 'requiredNamedParameter2',namedParameter: 'namedParameter',),),);
});

test('returns a new instance with updated namedParameter', () {
expect(Foo('requiredPositionalParameter',requiredNamedParameter: 'requiredNamedParameter',namedParameter: 'namedParameter',).copyWith(namedParameter: 'namedParameter2'), equals(Foo('requiredPositionalParameter',requiredNamedParameter: 'requiredNamedParameter',namedParameter: 'namedParameter2',),),);
});

});
''';
