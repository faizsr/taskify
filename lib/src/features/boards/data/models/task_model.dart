import 'package:taskify/src/features/boards/domain/entities/task_entity.dart';

class TaskModel {
  final String id;
  final String boardId;
  final String title;
  final String description;
  final String status;
  final String assignedTo;
  final String createdBy;
  final DateTime? dueDate;
  final DateTime? startDate;
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
      dueDate: DateTime.tryParse(json['dueDate']),
      startDate: DateTime.tryParse(json['startDate']),
      createdAt: DateTime.tryParse(json['createdAt']),
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
