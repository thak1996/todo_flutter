class GroupModel {
  final String id;
  final String name;
  final String? description;
  final DateTime? deletedAt;
  final bool isDefault;

  GroupModel({
    required this.id,
    required this.name,
    this.description,
    this.deletedAt,
    this.isDefault = false,
  });

  factory GroupModel.fromMap(Map<String, dynamic> map, String id) => GroupModel(
    id: id,
    name: map['name'] ?? '',
    description: map['description'],
    deletedAt: map['deletedAt'] != null
        ? DateTime.tryParse(map['deletedAt'])
        : null,
    isDefault: map['isDefault'] ?? false,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'deletedAt': deletedAt?.toIso8601String(),
      'isDefault': isDefault,
    };
  }
}
