import 'package:taskify/src/features/boards/data/models/board_model.dart';
import 'package:taskify/src/features/boards/domain/entities/task_entity.dart';

class BoardEntity {
  final String id;
  final String title;
  final String description;
  final List<String> members;
  final List<String> tasks;
  final List<TaskEntity> taskEntities;
  final String createdBy;
  final DateTime? createdAt;

  BoardEntity({
    this.id = '',
    this.title = '',
    this.description = '',
    this.members = const [],
    this.tasks = const [],
    this.taskEntities = const [],
    this.createdBy = '',
    this.createdAt,
  });

  BoardModel toModel() {
    return BoardModel(
      id: id,
      title: title,
      description: description,
      members: members,
      tasks: tasks,
      taskModels: taskEntities.map((e) => e.toModel()).toList(),
      createdBy: createdBy,
      createdAt: createdAt,
    );
  }
}
