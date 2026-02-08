import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskify/src/features/boards/data/data_sources/remote/board_remote_data_source.dart';
import 'package:taskify/src/features/boards/data/models/board_model.dart';

class BoardRemoteDataSourceImpl implements BoardRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  BoardRemoteDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<void> createBoard(BoardModel board) async {
    await firebaseFirestore.collection('boards').add(board.toJson());
  }
}
