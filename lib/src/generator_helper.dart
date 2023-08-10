import 'package:mason/mason.dart';
import 'package:model_test_generator/src/helper_core.dart';
import 'package:model_test_generator/src/instance_helper.dart';
import 'package:model_test_generator/src/modifed_instance.dart';
import 'package:model_test_generator/src/parameter_helper.dart';
import 'package:model_test_generator/src/test_helper.dart';

/// {@template generator_helper}
/// A helper class for generating tests.
/// {@endtemplate}
class GeneratorHelper extends HelperCore
    with InstanceHelper, TestHelper, ParameterHelper {
  /// {@macro generator_helper}
  GeneratorHelper(super.element);

  /// Generates tests for the given [element] that will be used by mason.
  Future<void> generateForMason(HookContext context) async {
    context.vars['fileName'] =
        element.librarySource.uri.pathSegments.last.split('.').first;
    context.vars['pathToFile'] = element.library.identifier;

    final requiredInstance = createRequiredInstance();

    context.vars['instantionTest'] = createInstantiationTest(requiredInstance);

    ModifiedInstance? fullInstance;
    List<String>? modifiedInstances;
    List<ModifiedInstance>? modifiedCopyWithInstances;

    if (isEquatable || isCopyWith) {
      fullInstance = createFullInstance();
      modifiedInstances = createModifiedInstances();
      if (isCopyWith) {
        modifiedCopyWithInstances = createModifiedCopyWithInstances();
      }
    }

    if (isEquatable && fullInstance != null && modifiedInstances != null) {
      context.vars['equalityTest'] = createEqualityTest(
        fullInstance.instance,
        modifiedInstances,
      );
    }

    if (isCopyWith &&
        fullInstance != null &&
        modifiedCopyWithInstances != null) {
      context.vars['copyWithTest'] = createCopyWithTest(
        fullInstance.instance,
        modifiedCopyWithInstances,
      );
    }
  }
}
