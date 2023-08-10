/// {@template modified_instance}
/// A class that represents a modified instance.
/// {@endtemplate}
class ModifiedInstance {
  /// {@macro modified_instance}
  const ModifiedInstance({
    required this.instance,
    required this.fieldName,
    required this.fieldValue,
  });

  /// The instance.
  final String instance;

  /// The name of the field.
  final String fieldName;

  /// The value of the field.
  final String fieldValue;
}
