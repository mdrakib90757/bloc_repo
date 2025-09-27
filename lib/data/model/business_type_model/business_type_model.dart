class BusinessType {
  final int id;
  final String name;
  final dynamic config;

  BusinessType({required this.id, required this.name, this.config});

  factory BusinessType.fromJson(Map<String, dynamic> json) {
    try {
      return BusinessType(
        id: int.tryParse(json["id"]?.toString() ?? '0') ?? 0,
        name: json["name"]?.toString() ?? '',
        config: json["config"],
      );
    } catch (e) {
      throw FormatException('Failed to parse BusinessType: $e');
    }
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'config': config};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessType &&
          runtimeType == other.runtimeType &&
          id == other.id;
}
