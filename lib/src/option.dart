import 'package:flutter/foundation.dart' show immutable;

///Option for a multi select field
///
///use [extra] field for pass some additional information for a option.
@immutable
class Option<T> {
  ///label for a option. This is required field.
  final String label;

  ///value for a option. This is required field.
  final String value;

  ///Addition information for a option. This is optional field.
  final T? extra;

  ///Option for a multi select field
  ///
  ///use [extra] field for pass some additional information for a option.
  const Option({
    required this.label,
    required this.value,
    this.extra,
  });

  @override
  bool operator ==(covariant Option other) =>
      label == other.label && value == other.value;

  @override
  int get hashCode => Object.hash(value, label);
}
