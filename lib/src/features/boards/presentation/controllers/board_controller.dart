import 'package:flutter/material.dart';
import 'package:taskify/src/core/common/custom_snackbar.dart';
import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';
import 'package:taskify/src/features/boards/domain/usecases/create_board_usecase.dart';

class BoardController extends ChangeNotifier {
  final CreateBoardUsecase createBoardUsecase;

  BoardController({required this.createBoardUsecase});

  bool isBtnLoading = false;

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
}
