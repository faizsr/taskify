import 'package:hive_ce/hive.dart';
import 'package:taskify/src/features/boards/domain/entities/task_entity.dart';

part 'task_model.g.dart';

@HiveType(typeId: 3)
class TaskModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String boardId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String status;

  @HiveField(5)
  final String assignedTo;

  @HiveField(6)
  final String createdBy;

  @HiveField(7)
  final DateTime? dueDate;

  @HiveField(8)
  final DateTime? startDate;

  @HiveField(9)
  final DateTime? createdAt;

  TaskModel({
    required this.id,
    required this.boardId,
    required this.title,
    required this.description,
    required this.status,
    required this.assignedTo,
    required this.createdBy,
    this.dueDate,
    this.startDate,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      boardId: json['boardId'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      assignedTo: json['assignedTo'],
      createdBy: json['createdBy'],
      dueDate: DateTime.tryParse(json['dueDate'] ?? ''),
      startDate: DateTime.tryParse(json['startDate'] ?? ''),
      createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'boardId': boardId,
      'title': title,
      'description': description,
      'status': status,
      'assignedTo': assignedTo,
      'createdBy': createdBy,
      'dueDate': dueDate?.toIso8601String(),
      'startDate': startDate?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      boardId: boardId,
      title: title,
      description: description,
      status: status,
      assignedTo: assignedTo,
      createdBy: createdBy,
      createdAt: createdAt,
      dueDate: dueDate,
      startDate: startDate,
    );
  }

  TaskModel copyWith({
    String? id,
    String? boardId,
    String? title,
    String? description,
    String? status,
    String? assignedTo,
    String? createdBy,
    DateTime? dueDate,
    DateTime? startDate,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      boardId: boardId ?? this.boardId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      assignedTo: assignedTo ?? this.assignedTo,
      createdBy: createdBy ?? this.createdBy,
      dueDate: dueDate ?? this.dueDate,
      startDate: startDate ?? this.startDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
