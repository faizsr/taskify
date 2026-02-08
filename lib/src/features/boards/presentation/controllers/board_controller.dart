import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taskify/src/core/common/custom_snackbar.dart';
import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';
import 'package:taskify/src/features/boards/domain/usecases/create_board_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_all_boards_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_all_users_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_board_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/get_current_user_usecase.dart';
import 'package:taskify/src/features/boards/domain/usecases/update_board_usecase.dart';

class BoardController extends ChangeNotifier {
  final CreateBoardUsecase createBoardUsecase;
  final UpdateBoardUsecase updateBoardUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final GetAllUsersUsecase getAllUsersUsecase;
  final GetAllBoardsUsecase getAllBoardsUsecase;
  final GetBoardUsecase getBoardUsecase;

  BoardController({
    required this.createBoardUsecase,
    required this.updateBoardUsecase,
    required this.getCurrentUserUsecase,
    required this.getAllUsersUsecase,
    required this.getAllBoardsUsecase,
    required this.getBoardUsecase,
  });

  bool isLoading = false;
  bool isBtnLoading = false;

  UserEntity? currentUser;
  BoardEntity? board;
  List<UserEntity> allUsers = [];
  List<BoardEntity> boards = [];

  StreamSubscription<List<UserEntity>>? _usersSub;
  StreamSubscription<List<BoardEntity>>? _boardsSub;
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

  Future<void> updateBoard(BoardEntity board) async {
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
    } catch (e) {
      showCustomSnackbar(
        type: SnackType.error,
        content: 'Failed to update board. Please try again.',
      );
      isBtnLoading = false;
      notifyListeners();
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

  void clearOnLogout() {
    _usersSub?.cancel();
    _boardsSub?.cancel();
    _boardSub?.cancel();

    _usersSub = null;
    _boardsSub = null;
    _boardSub = null;

    currentUser = null;
    allUsers = [];
    boards = [];
    board = null;

    notifyListeners();
  }
}
