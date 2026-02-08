import 'package:taskify/src/features/boards/data/models/task_model.dart';

class TaskEntity {
  final String boardId;
  final String title;
  final String description;
  final String status;
  final String assignedTo;
  final String createdBy;
  final DateTime? dueDate;
  final DateTime? startDate;
  final DateTime? createdAt;

  TaskEntity({
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

  TaskModel toModel() {
    return TaskModel(
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
