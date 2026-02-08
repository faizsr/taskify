import 'package:taskify/src/features/boards/data/models/board_model.dart';

class BoardEntity {
  final String id;
  final String title;
  final String description;
  final List<String> members;
  final DateTime? createdAt;

  BoardEntity({
    this.id = '',
    this.title = '',
    this.description = '',
    this.members = const [],
    this.createdAt,
  });

  BoardModel toModel() {
    return BoardModel(
      id: id,
      title: title,
      description: description,
      members: members,
      createdAt: createdAt,
    );
  }
}
