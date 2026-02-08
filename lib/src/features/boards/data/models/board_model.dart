import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';

class BoardModel {
  final String id;
  final String title;
  final String description;
  final List<String> members;
  final DateTime? createdAt;

  BoardModel({
    this.id = '',
    this.title = '',
    this.description = '',
    this.members = const [],
    this.createdAt,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
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
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  BoardEntity toModel() {
    return BoardEntity(
      id: id,
      title: title,
      description: description,
      members: members,
      createdAt: createdAt,
    );
  }

  BoardModel copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? members,
    DateTime? createdAt,
  }) {
    return BoardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      members: members ?? this.members,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}