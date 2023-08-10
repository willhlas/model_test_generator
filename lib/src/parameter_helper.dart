import 'package:analyzer/dart/element/element.dart';
import 'package:model_test_generator/src/helper_core.dart';

/// {@template parameter_helper}
/// A helper class for decoding parameters of a [ClassElement].
/// {@endtemplate}
mixin ParameterHelper implements HelperCore {
  /// Returns the [ParameterElement]s for the element.
  List<ParameterElement> get parameters => constructor.parameters;

  /// Returns the required positional [ParameterElement]s for the element.
  ///
  /// String represents the name of the parameter.
  Map<String, ParameterElement> get requiredPositionalParameters {
    final params = <String, ParameterElement>{};

    for (final param in parameters) {
      if (param.isRequiredPositional) {
        params[param.name] = param;
      }
    }

    return params;
  }

  /// Returns the required named [ParameterElement]s for the element.
  ///
  /// String represents the name of the parameter.
  Map<String, ParameterElement> get requiredNamedParameters {
    final params = <String, ParameterElement>{};

    for (final param in parameters) {
      if (param.isRequiredNamed) {
        params[param.name] = param;
      }
    }

    return params;
  }

  /// Returns the positional [ParameterElement]s for the element.
  ///
  /// String represents the name of the parameter.
  Map<String, ParameterElement> get positionalParameters {
    final params = <String, ParameterElement>{};

    for (final param in parameters) {
      if (param.isPositional) {
        params[param.name] = param;
      }
    }

    return params;
  }

  /// Returns the named [ParameterElement]s for the element.
  ///
  /// String represents the name of the parameter.
  Map<String, ParameterElement> get namedParameters {
    final params = <String, ParameterElement>{};

    for (final param in parameters) {
      if (param.isNamed) {
        params[param.name] = param;
      }
    }

    return params;
  }
}
