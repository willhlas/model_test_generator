// ignore_for_file: prefer_const_constructors
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';
import 'package:model_test_generator/src/model_test_generator.dart';
import 'package:test/test.dart';

class _MockHookContext extends Mock implements HookContext {}

class _MockLogger extends Mock implements Logger {}

// ignore: one_member_abstracts
abstract class _ResolveFile {
  Future<ResolvedUnitResult> resolveFile2({required String path});
}

class _MockResolveFile extends Mock implements _ResolveFile {}

class _MockResolvedUnitResult extends Mock implements ResolvedUnitResult {}

class _MockLibraryElement extends Mock implements LibraryElement {
  _MockLibraryElement({
    this.testNull = false,
  });

  final bool testNull;

  @override
  ClassElement? getClass(String name) => testNull ? null : _MockClassElement();
}

class _MockClassElement extends Mock implements ClassElement {}

void main() {
  group('ModelTestGenerator', () {
    test('can be instantiated', () {
      expect(ModelTestGenerator(), isNotNull);
    });

    group('generateForMason', () {
      late HookContext context;
      late Logger logger;
      late _ResolveFile resolveFile;
      late ModelTestGenerator generator;
      late ResolvedUnitResult resolvedUnitResult;

      setUp(() {
        context = _MockHookContext();
        logger = _MockLogger();
        resolveFile = _MockResolveFile();
        generator = ModelTestGenerator(
          resolveFile: resolveFile.resolveFile2,
        );
        resolvedUnitResult = _MockResolvedUnitResult();
        when(() => context.logger).thenReturn(logger);
      });

      test('logs an error if the file cannot be resolved', () async {
        when(() => context.vars).thenReturn({
          'className': 'Foo',
          'path': 'foo.dart',
        });
        when(() => logger.err(any())).thenReturn(null);
        when(() => resolveFile.resolveFile2(path: any(named: 'path')))
            .thenThrow(Exception('oops'));

        await generator.generateForMason(context);

        verify(() => logger.err('Exception: oops')).called(1);
      });

      test('logs an error if the class is not found', () async {
        when(() => context.vars).thenReturn({
          'className': 'Foo',
          'path': 'foo.dart',
        });
        when(() => logger.err(any())).thenReturn(null);
        when(() => resolveFile.resolveFile2(path: any(named: 'path')))
            .thenAnswer((_) async => resolvedUnitResult);
        when(() => resolvedUnitResult.libraryElement).thenReturn(
          _MockLibraryElement(testNull: true),
        );

        await generator.generateForMason(context);

        verify(
          () => logger.err(
            'No class named Foo found in foo.dart',
          ),
        ).called(1);
      });

      test('completes', () async {
        when(() => context.vars).thenReturn({
          'className': 'Foo',
          'path': 'foo.dart',
        });
        when(() => logger.err(any())).thenReturn(null);
        when(() => resolveFile.resolveFile2(path: any(named: 'path')))
            .thenAnswer((_) async => resolvedUnitResult);
        when(() => resolvedUnitResult.libraryElement).thenReturn(
          _MockLibraryElement(),
        );

        expect(
          generator.generateForMason(context),
          completes,
        );
      });
    });
  });
}
