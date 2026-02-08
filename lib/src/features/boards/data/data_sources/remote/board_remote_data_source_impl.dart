import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskify/src/features/auth/data/models/user_model.dart';
import 'package:taskify/src/features/boards/data/data_sources/remote/board_remote_data_source.dart';
import 'package:taskify/src/features/boards/data/models/board_model.dart';

class BoardRemoteDataSourceImpl implements BoardRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  BoardRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });

  @override
  Future<void> createBoard(BoardModel board) async {
    final currentUid = firebaseAuth.currentUser?.uid ?? '';
    final collection = firestore.collection('boards');
    final docId = collection.doc().id;
    final newBoard = board.copyWith(id: docId, createdBy: currentUid);
    await collection.doc(docId).set(newBoard.toJson());
  }

  @override
  Future<void> updateBoard(BoardModel board) async {
    final collection = firestore.collection('boards');
    final json = board.toJson()
      ..remove('createdBy')
      ..remove('createdAt');
    log('Update Json: $json');
    await collection.doc(board.id).update(json);
  }

  @override
  Future<void> deleteBoard(String id) async {
    final collection = firestore.collection('boards');
    await collection.doc(id).delete();
  }

  @override
  Stream<List<UserModel>> getAllUsers() {
    final collection = firestore.collection('users').snapshots();

    return collection.map((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final currentUid = firebaseAuth.currentUser?.uid ?? '';
    final snapshot = await firestore.collection('users').doc(currentUid).get();
    return UserModel.fromJson(snapshot.data()!);
  }

  @override
  Stream<BoardModel> getBoard(String id) {
    final snapshot = firestore.collection('boards').doc(id).snapshots();
    return snapshot.map((e) => BoardModel.fromJson(e.data()!));
  }

  @override
  Stream<List<BoardModel>> getAllBoards() {
    final collection = firestore
        .collection('boards')
        .orderBy('createdAt', descending: true)
        .snapshots();

    return collection.map((snapshot) {
      return snapshot.docs
          .map((doc) => BoardModel.fromJson(doc.data()))
          .toList();
    });
  }
}
