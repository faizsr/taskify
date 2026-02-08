import 'package:taskify/src/features/boards/data/models/board_model.dart';

class BoardEntity {
  final String id;
  final String title;
  final String description;
  final List<String> members;
  final List<String> tasks;
  final String createdBy;
  final DateTime? createdAt;

  BoardEntity({
    this.id = '',
    this.title = '',
    this.description = '',
    this.members = const [],
    this.tasks = const [],
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
      createdBy: createdBy,
      createdAt: createdAt,
    );
  }
}
