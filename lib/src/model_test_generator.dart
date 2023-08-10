import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:mason/mason.dart';
import 'package:model_test_generator/src/generator_helper.dart';

/// Type definition for a function that resolves a file path to a resolved unit.
typedef ResolveFile = Future<SomeResolvedUnitResult> Function({
  required String path,
});

/// {@template model_test_generator}
/// A generator for generating model tests.
/// {@endtemplate}
class ModelTestGenerator {
  /// {@macro model_test_generator}
  ModelTestGenerator({
    ResolveFile resolveFile = resolveFile2,
  }) : _resolveFile2 = resolveFile;

  final ResolveFile _resolveFile2;

  /// Generates tests for the given path and className via mason.
  Future<void> generateForMason(HookContext context) async {
    try {
      final className = context.vars['className'] as String;
      final path = context.vars['path'] as String;
      final absolutePath = File(path).absolute.path;

      final unitResult = await _resolveFile2(path: absolutePath);

      if (unitResult is ResolvedUnitResult) {
        final classElement = unitResult.libraryElement.getClass(className);
        if (classElement == null) {
          throw MasonException(
            'No class named $className found in $path',
          );
        }
        await GeneratorHelper(classElement).generateForMason(context);
      }
    } catch (e) {
      context.logger.err(e.toString());
      exit(1);
    }
  }
}
