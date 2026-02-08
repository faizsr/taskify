import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskify/src/features/auth/data/models/user_model.dart';
import 'package:taskify/src/features/boards/data/data_sources/remote/board_remote_data_source.dart';
import 'package:taskify/src/features/boards/data/models/board_model.dart';
import 'package:taskify/src/features/boards/data/models/task_model.dart';

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
    await collection.doc(board.id).update(json);
  }

  @override
  Future<void> deleteBoard(String id) async {
    final collection = firestore.collection('boards');
    await collection.doc(id).delete();
  }

  @override
  Stream<List<BoardModel>> getAllBoards() {
    final controller = StreamController<List<BoardModel>>();
    final currentUid = firebaseAuth.currentUser?.uid ?? '';

    List<BoardModel> boards = [];
    List<TaskModel> tasks = [];

    late StreamSubscription boardsSub;
    late StreamSubscription tasksSub;

    void emit() {
      // Group tasks by boardId
      final taskMap = <String, List<TaskModel>>{};
      for (final task in tasks) {
        taskMap.putIfAbsent(task.boardId, () => []).add(task);
      }

      final populatedBoards = boards.map((board) {
        return board.copyWith(taskModels: taskMap[board.id] ?? []);
      }).toList();

      controller.add(populatedBoards);
    }

    /// Boards listener
    boardsSub = firestore
        .collection('boards')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
          boards = snapshot.docs
              .map((doc) => BoardModel.fromJson(doc.data()))
              .where(
                (board) =>
                    board.members.contains(currentUid) ||
                    board.createdBy == currentUid,
              )
              .toList();

          emit();
        });

    /// Tasks listener
    tasksSub = firestore
        .collection('tasks')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
          tasks = snapshot.docs
              .map((doc) => TaskModel.fromJson(doc.data()))
              .toList();

          emit();
        });

    controller.onCancel = () {
      boardsSub.cancel();
      tasksSub.cancel();
    };

    return controller.stream;
  }

  @override
  Stream<BoardModel> getBoard(String id) {
    final snapshot = firestore.collection('boards').doc(id).snapshots();
    return snapshot.map((e) => BoardModel.fromJson(e.data()!));
  }

  @override
  Future<void> createTask(TaskModel task) async {
    final currentUid = firebaseAuth.currentUser?.uid ?? '';
    final taskCollection = firestore.collection('tasks');
    final boardCollection = firestore.collection('boards');

    final docId = taskCollection.doc().id;
    final newTask = task.copyWith(id: docId, createdBy: currentUid);
    await taskCollection.doc(docId).set(newTask.toJson());

    final board = await boardCollection.doc(task.boardId).get();
    final tasks = BoardModel.fromJson(board.data()!).tasks;
    tasks.add(docId);
    await boardCollection.doc(task.boardId).update({'tasks': tasks});
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final collection = firestore.collection('tasks');
    Map<String, dynamic> json = {};
    if (task.status.isNotEmpty) {
      json = {'status': task.status};
    } else {
      json = {
        'title': task.title,
        'description': task.description,
        'dueDate': task.dueDate?.toIso8601String(),
      };
    }
    await collection.doc(task.id).update(json);
  }

  @override
  Future<void> deleteTask(String id) async {
    final collection = firestore.collection('tasks');
    await collection.doc(id).delete();
  }

  @override
  Stream<List<TaskModel>> getAllTasks(String boardId) {
    final collection = firestore
        .collection('tasks')
        .orderBy('createdAt', descending: true)
        .snapshots();

    return collection.map((snapshot) {
      return snapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data()))
          .where((element) => element.boardId == boardId)
          .toList();
    });
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
}
