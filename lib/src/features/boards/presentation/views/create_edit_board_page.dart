import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/core/common/custom_snackbar.dart';
import 'package:taskify/src/core/common/k_drop_down_menu.dart';
import 'package:taskify/src/core/common/k_filled_button.dart';
import 'package:taskify/src/core/common/k_text_field.dart';
import 'package:taskify/src/core/utils/input_validator.dart';
import 'package:taskify/src/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';
import 'package:taskify/src/features/boards/presentation/controllers/board_controller.dart';

class CreateBoardPage extends StatefulWidget {
  const CreateBoardPage({super.key, this.board});

  final BoardEntity? board;

  @override
  State<CreateBoardPage> createState() => _CreateBoardPageState();
}

class _CreateBoardPageState extends State<CreateBoardPage> {
  final titleCtlr = TextEditingController();
  final descriptionCtlr = TextEditingController();
  final memberSearchCtlr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<String> members = [];

  Future<void> _onBtnPressed() async {
    final authCtlr = context.read<AuthController>();
    if (!authCtlr.isNetworkConnected) {
      showCustomSnackbar(type: SnackType.noInternet);
      return;
    }
    if (formKey.currentState!.validate()) {
      bool success = false;
      final boardCtlr = context.read<BoardController>();

      if (widget.board != null) {
        final updatedBoard = BoardEntity(
          id: widget.board!.id,
          title: titleCtlr.text,
          description: descriptionCtlr.text,
          members: members,
        );
        success = await boardCtlr.updateBoard(updatedBoard);
      } else {
        final newBoard = BoardEntity(
          title: titleCtlr.text,
          description: descriptionCtlr.text,
          members: members,
          createdAt: DateTime.now(),
        );
        success = await boardCtlr.createBoard(newBoard);
      }
      if (success && mounted) context.pop();
    }
  }

  @override
  void initState() {
    if (widget.board != null) {
      members = widget.board!.members;
      titleCtlr.text = widget.board!.title;
      descriptionCtlr.text = widget.board!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: Text(widget.board != null ? 'Edit board' : 'Create new board'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(SolarIconsOutline.arrowLeft),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            KTextField(
              title: 'Title',
              controller: titleCtlr,
              hintText: 'Project title',
              validator: InputValidator.required,
            ),
            vSpace20,
            KTextField(
              maxLines: 5,
              title: 'Description',
              padding: EdgeInsets.all(16),
              controller: descriptionCtlr,
              hintText: 'Describe more about the project',
            ),
            vSpace20,
            _buildMembersField(context),

            vSpace24,

            Selector<BoardController, bool>(
              selector: (context, controller) => controller.isBtnLoading,
              builder: (context, isLoading, child) {
                return KFilledButton(
                  text: widget.board != null ? 'Update' : 'Create',
                  isLoading: isLoading,
                  onPressed: _onBtnPressed,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Column _buildMembersField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Members', style: Theme.of(context).textTheme.titleMedium),
        vSpace4,

        if (members.isNotEmpty) ...[
          Selector<BoardController, List<UserEntity>>(
            selector: (context, ctlr) => ctlr.allUsers,
            builder: (context, value, child) {
              return Wrap(
                spacing: 8,
                children: List.generate(members.length, (index) {
                  final user = value.firstWhere(
                    (e) => e.uid == members[index],
                    orElse: () => UserEntity(),
                  );
                  return _buildMemberEmailCard(user.email, user.uid);
                }),
              );
            },
          ),
          vSpace16,
        ],

        Consumer<BoardController>(
          builder: (context, value, child) {
            final currentUser = value.currentUser;
            final users = List<UserEntity>.from(value.allUsers)
              ..removeWhere((e) => e.uid == currentUser?.uid);
            final emails = users.map((e) => e.email).toList();
            return KDropDownMenu(
              list: emails.isEmpty ? ['none'] : emails,
              controller: memberSearchCtlr,
              hintText: 'Search to add members',
              onSelected: (val) {
                if (val != 'none') {
                  if (!members.contains(val)) {
                    final user = users.firstWhere((e) => e.email == val);
                    members.add(user.uid);
                  }
                  memberSearchCtlr.clear();
                  setState(() {});
                }
              },
            );
          },
        ),
      ],
    );
  }

  Container _buildMemberEmailCard(String email, String id) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 4, 4, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.lightBlue.withValues(alpha: 0.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(email),
          hSpace8,
          GestureDetector(
            onTap: () => setState(() => members.remove(id)),
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: Icon(Icons.close, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
