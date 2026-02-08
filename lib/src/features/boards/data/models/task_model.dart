import 'package:taskify/src/features/boards/domain/entities/task_entity.dart';

class TaskModel {
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
}
