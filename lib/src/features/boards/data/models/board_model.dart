import 'package:taskify/src/features/boards/data/models/task_model.dart';
import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';

class BoardModel {
  final String id;
  final String title;
  final String description;
  final List<String> members;
  final List<String> tasks;
  final List<TaskModel> taskModels;
  final String createdBy;
  final DateTime? createdAt;

  BoardModel({
    this.id = '',
    this.title = '',
    this.description = '',
    this.members = const [],
    this.tasks = const [],
    this.taskModels = const [],
    this.createdBy = '',
    this.createdAt,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      members: List<String>.from(json['members'] ?? []),
      tasks: List<String>.from(json['tasks'] ?? []),
      createdBy: json['createdBy'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'members': members,
      'createdBy': createdBy,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  BoardEntity toEntity() {
    return BoardEntity(
      id: id,
      title: title,
      description: description,
      members: members,
      tasks: tasks,
      taskEntities: taskModels.map((e) => e.toEntity()).toList(),
      createdBy: createdBy,
      createdAt: createdAt,
    );
  }

  BoardModel copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? members,
    List<String>? tasks,
    List<TaskModel>? taskModels,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return BoardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      members: members ?? this.members,
      tasks: tasks ?? this.tasks,
      taskModels: taskModels ?? this.taskModels,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
