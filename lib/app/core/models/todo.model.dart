import 'dart:convert';

enum TodoPriority { low, medium, high }

class TodoModel {
  final String? id;
  final String userId;
  final String title;
  final String? description;
  final bool completed;
  final DateTime? completedAt;
  final DateTime? createAt;
  final DateTime? deletedAt;
  final String? groupId;
  final TodoPriority priority;

  TodoModel({
    this.id,
    required this.userId,
    required this.title,
    this.description,
    this.completed = false,
    this.completedAt,
    this.createAt,
    this.deletedAt,
    this.groupId,
    this.priority = TodoPriority.medium,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map, String id) => TodoModel(
    id: id ,
    userId: map['userId'] ?? '',
    title: map['title'] ?? '',
    description: map['description'],
    completed: map['completed'] ?? false,
    completedAt: map['completedAt'] != null
        ? DateTime.tryParse(map['completedAt'])
        : null,
    createAt: map['createAt'] != null
        ? DateTime.tryParse(map['createAt'])
        : null,
    deletedAt: map['deletedAt'] != null
        ? DateTime.tryParse(map['deletedAt'])
        : null,
    groupId: map['groupId'],
    priority: TodoPriority.values[map['priority'] ?? 0],
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'completed': completed,
      'completedAt': completedAt?.millisecondsSinceEpoch,
      'createAt': createAt?.millisecondsSinceEpoch,
      'deletedAt': deletedAt?.millisecondsSinceEpoch,
      'groupId': groupId,
      'priority': priority.index,
    };
  }

  TodoModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    bool? completed,
    DateTime? completedAt,
    DateTime? createAt,
    DateTime? deletedAt,
    String? groupId,
    TodoPriority? priority,
  }) {
    return TodoModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      completedAt: completedAt ?? this.completedAt,
      createAt: createAt ?? this.createAt,
      deletedAt: deletedAt ?? this.deletedAt,
      groupId: groupId ?? this.groupId,
      priority: priority ?? this.priority,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) {
    final map = json.decode(source) as Map<String, dynamic>;
    return TodoModel.fromMap(map, map['id'] ?? '');
  }

  @override
  String toString() {
    return 'TodoModel(id: $id, userId: $userId, title: $title, description: $description, completed: $completed, completedAt: $completedAt, createAt: $createAt, deletedAt: $deletedAt, groupId: $groupId, priority: $priority)';
  }

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.title == title &&
        other.description == description &&
        other.completed == completed &&
        other.completedAt == completedAt &&
        other.createAt == createAt &&
        other.deletedAt == deletedAt &&
        other.groupId == groupId &&
        other.priority == priority;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        completed.hashCode ^
        completedAt.hashCode ^
        createAt.hashCode ^
        deletedAt.hashCode ^
        groupId.hashCode ^
        priority.hashCode;
  }
}
