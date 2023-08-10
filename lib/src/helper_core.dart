import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';

/// {@template helper_core}
/// Helper class that provides useful information about the element.
/// {@endtemplate}
abstract class HelperCore {
  /// {@macro helper_core}
  const HelperCore(this.element);

  /// An element that represents a class.
  final ClassElement element;

  /// Returns the [ConstructorElement] for the element.
  @protected
  ConstructorElement get constructor {
    final ctor = element.unnamedConstructor;

    if (ctor == null) {
      throw Exception('No default constructor found for ${element.name}.');
    }
    return ctor;
  }

  /// Name of the element.
  @protected
  String get className => element.name;

  /// Returns the [FieldElement]s for the element.
  @protected
  List<FieldElement> get fields =>
      element.fields.where((e) => !e.isStatic && !e.isSynthetic).toList();

  /// Checks if the element uses Equatable.
  @protected
  bool get isEquatable => element.allSupertypes
      .map((e) => e.getDisplayString(withNullability: false))
      .contains('Equatable');

  /// Checks if the element has a copyWith method.
  @protected
  bool get isCopyWith =>
      element.methods.map((e) => e.name).contains('copyWith');
}
