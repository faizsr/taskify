import 'package:flutter/material.dart';
import 'package:taskify/src/config/styles/app_colors.dart';

class KDropDownMenu extends StatefulWidget {
  const KDropDownMenu({
    super.key,
    this.onSelected,
    this.fillColor,
    this.hintText,
    this.initialSelection,
    this.border = true,
    this.borderRadius = 8,
    required this.list,
    this.enableFilter = true,
    this.controller,
    this.hintOpc = 0.6,
    this.enableValidator = true,
    this.isUnderline = false,
    this.padding,
    this.height = 50,
  });

  final void Function(String?)? onSelected;
  final Color? fillColor;
  final String? hintText;
  final String? initialSelection;
  final bool border;
  final double borderRadius;
  final List<String> list;
  final bool enableFilter;
  final TextEditingController? controller;
  final double hintOpc;
  final bool enableValidator;
  final bool isUnderline;
  final EdgeInsets? padding;
  final double height;

  @override
  State<KDropDownMenu> createState() => _KDropDownMenuState();
}

class _KDropDownMenuState extends State<KDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: null,
      controller: widget.controller,
      hintText: widget.hintText,

      inputDecorationTheme: InputDecorationTheme(
        isCollapsed: true,
        hintStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.lightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: widget.padding ?? EdgeInsets.fromLTRB(16, 0, 16, 0),
      ),
      requestFocusOnTap: true,
      onSelected: widget.onSelected,
      expandedInsets: EdgeInsets.zero,
      menuStyle: MenuStyle(
        elevation: WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(AppColors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: AppColors.lightGrey),
          ),
        ),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
      ),
      dropdownMenuEntries: widget.list
          .map<DropdownMenuEntry<String>>(
            (String option) => DropdownMenuEntry<String>(
              value: option,
              label: option,
              enabled: true,
              labelWidget: Text(
                option,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          )
          .toList(),
    );
  }
}
