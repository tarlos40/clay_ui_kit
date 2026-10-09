class ClayProp {
  final String name;
  final String type;
  final String description;

  final String? defaultValue;
  final bool required;

  const ClayProp({
    required this.name,
    required this.type,
    required this.description,
    this.defaultValue,
    this.required = false,
  });
}
