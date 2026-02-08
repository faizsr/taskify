import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taskify/src/core/common/custom_snackbar.dart';
import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';
import 'package:taskify/src/features/boards/domain/entities/task_entity.dart';
import 'package:taskify/src/features/boards/domain/usecases/create_board_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/create_task_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/delete_board_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/delete_task_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_all_boards_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_all_tasks_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_all_users_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_board_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_current_user_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/update_board_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/update_task_usecase.dart';

class BoardController extends ChangeNotifier {
  final CreateBoardUsecase createBoardUsecase;
  final UpdateBoardUsecase updateBoardUsecase;
  final DeleteBoardUsecase deleteBoardUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final GetAllUsersUsecase getAllUsersUsecase;
  final GetAllBoardsUsecase getAllBoardsUsecase;
  final GetBoardUsecase getBoardUsecase;
  // tasks
  final CreateTaskUsecase createTaskUsecase;
  final UpdateTaskUsecase updateTaskUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;
  final GetAllTasksUsecase getAllTasksUsecase;

  BoardController({
    required this.createBoardUsecase,
    required this.updateBoardUsecase,
    required this.deleteBoardUsecase,
    required this.getCurrentUserUsecase,
    required this.getAllUsersUsecase,
    required this.getAllBoardsUsecase,
    required this.getBoardUsecase,
    required this.createTaskUsecase,
    required this.updateTaskUsecase,
    required this.deleteTaskUsecase,
    required this.getAllTasksUsecase,
  });

  bool isLoading = false;
  bool isBtnLoading = false;

  UserEntity? currentUser;
  BoardEntity? board;
  List<UserEntity> allUsers = [];
  List<BoardEntity> boards = [];
  List<TaskEntity> tasks = [];

  StreamSubscription<List<UserEntity>>? _usersSub;
  StreamSubscription<List<BoardEntity>>? _boardsSub;
  StreamSubscription<List<TaskEntity>>? _tasksSub;
  StreamSubscription<BoardEntity?>? _boardSub;

  Future<bool> createBoard(BoardEntity board) async {
    isBtnLoading = true;
    notifyListeners();

    try {
      await createBoardUsecase.call(board);
      showCustomSnackbar(
        type: SnackType.success,
        content: 'Board created successfully',
      );
      isBtnLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      showCustomSnackbar(
        type: SnackType.error,
        content: 'Failed to create board. Please try again.',
      );
      isBtnLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateBoard(BoardEntity board) async {
    isBtnLoading = true;
    notifyListeners();

    try {
      await updateBoardUsecase.call(board);
      showCustomSnackbar(
        type: SnackType.success,
        content: 'Board updated successfully',
      );
      isBtnLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      showCustomSnackbar(
        type: SnackType.error,
        content: 'Failed to update board. Please try again.',
      );
      isBtnLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteBoard(String id) async {
    try {
      await deleteBoardUsecase.call(id);
      showCustomSnackbar(
        type: SnackType.success,
        content: 'Board deleted successfully',
      );
      return true;
    } catch (e) {
      showCustomSnackbar(
        type: SnackType.error,
        content: 'Failed to delete board. Please try again.',
      );
      return false;
    }
  }

  Future<void> getCurrentUser() async {
    try {
      currentUser = await getCurrentUserUsecase.call();
      notifyListeners();
    } catch (e) {
      showCustomSnackbar(
        type: SnackType.error,
        content: 'Failed to load user data',
      );
    }
  }

  void getBoard(String id) {
    try {
      _boardSub = getBoardUsecase.call(id).listen((data) {
        board = data;
        notifyListeners();
      });
    } catch (e) {
      showCustomSnackbar(
        type: SnackType.error,
        content: 'Failed to load user data',
      );
    }
  }

  void getAllUsers() {
    try {
      _usersSub = getAllUsersUsecase.call().listen((data) {
        allUsers = data;
        notifyListeners();
      });
    } catch (e) {
      showCustomSnackbar(
        type: SnackType.error,
        content: 'Failed to load users',
      );
      log('Failed to load users: $e');
    }
  }

  void getAllBoards() {
    try {
      _boardsSub = getAllBoardsUsecase.call().listen((data) {
        boards = data;
        notifyListeners();
      });
    } catch (e) {
      showCustomSnackbar(
        type: SnackType.error,
        content: 'Failed to load boards',
      );
      log('Failed to load boards: $e');
    }
  }

  void getAllTasks(String boardId) {
    try {
      _tasksSub = getAllTasksUsecase.call(boardId).listen((data) {
        tasks = data;
        notifyListeners();
      });
    } catch (e) {
      showCustomSnackbar(
        type: SnackType.error,
        content: 'Failed to load boards',
      );
      log('Failed to load boards: $e');
    }
  }

  Future<bool> createTask(TaskEntity task) async {
    isBtnLoading = true;
    notifyListeners();

    try {
      await createTaskUsecase.call(task);
      showCustomSnackbar(
        type: SnackType.success,
        content: 'Task created successfully',
      );
      isBtnLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      showCustomSnackbar(
        type: SnackType.error,
        content: 'Failed to task board. Please try again.',
      );
      isBtnLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> updateTask(TaskEntity task) async {
    try {
      await updateTaskUsecase.call(task);
    } catch (e) {
      log('Failed to update board. Please try again.: $e');
    }
  }

  Future<bool> deleteTask(String id) async {
    try {
      await deleteTaskUsecase.call(id);
      showCustomSnackbar(
        type: SnackType.success,
        content: 'Task deleted successfully',
      );
      return true;
    } catch (e) {
      showCustomSnackbar(
        type: SnackType.error,
        content: 'Failed to delete task. Please try again.',
      );
      return false;
    }
  }

  void clearOnLogout() {
    _usersSub?.cancel();
    _boardsSub?.cancel();
    _boardSub?.cancel();
    _tasksSub?.cancel();

    _usersSub = null;
    _boardsSub = null;
    _boardSub = null;
    _tasksSub = null;

    currentUser = null;
    allUsers = [];
    boards = [];
    tasks = [];
    board = null;

    notifyListeners();
  }
}
