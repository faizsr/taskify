import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/constants/app_constants.dart';
import 'package:taskify/src/config/styles/app_colors.dart';
import 'package:taskify/src/core/common/k_drop_down_menu.dart';
import 'package:taskify/src/core/common/k_filled_button.dart';
import 'package:taskify/src/core/common/k_text_field.dart';
import 'package:taskify/src/features/boards/domain/entities/board_entity.dart';
import 'package:taskify/src/features/boards/presentation/controllers/board_controller.dart';

class CreateBoardPage extends StatefulWidget {
  const CreateBoardPage({super.key});

  @override
  State<CreateBoardPage> createState() => _CreateBoardPageState();
}

class _CreateBoardPageState extends State<CreateBoardPage> {
  final titleCtlr = TextEditingController();
  final descriptionCtlr = TextEditingController();
  final memberSearchCtlr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<String> members = [];

  Future<void> _onCreatePressed() async {
    if (formKey.currentState!.validate()) {
      final boardCtlr = context.read<BoardController>();
      final board = BoardEntity(
        title: titleCtlr.text,
        description: descriptionCtlr.text,
        members: members,
        createdAt: DateTime.now(),
      );
      await boardCtlr.createBoard(board);
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: Text('Create new board'),
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
                  text: 'Create',
                  isLoading: isLoading,
                  onPressed: _onCreatePressed,
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
          Wrap(
            spacing: 8,
            children: List.generate(members.length, (index) {
              return _buildMemberEmailCard(members[index]);
            }),
          ),
          vSpace16,
        ],

        KDropDownMenu(
          title: 'Members',
          list: ['one', 'two'],
          controller: memberSearchCtlr,
          hintText: 'Seaerch to add members',
          onSelected: (val) {
            if (!members.contains(val)) {
              members.add(val!);
            }
            memberSearchCtlr.clear();
            setState(() {});
          },
        ),
      ],
    );
  }

  Container _buildMemberEmailCard(String member) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 4, 4, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.lightBlue.withValues(alpha: 0.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(member),
          hSpace8,
          GestureDetector(
            onTap: () => setState(() => members.remove(member)),
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
