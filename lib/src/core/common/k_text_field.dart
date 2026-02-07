import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:taskify/src/config/styles/app_colors.dart';

class KTextField extends StatefulWidget {
  const KTextField({
    super.key,
    this.hintText = '',
    this.controller,
    this.validator,
    this.height = double.infinity,
    this.textAlign = TextAlign.start,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.readOnly = false,
    this.onChanged,
    this.suffixPadding = 12,
    this.prefixPadding = 12,
    this.isPassword = false,
    this.initialValue,
    this.autovalidateMode,
    this.maxLines = 1,
    this.maxLength,
    this.padding,
  });

  final String hintText;
  final double height;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextAlign textAlign;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final bool readOnly;
  final void Function(String)? onChanged;
  final double suffixPadding;
  final double prefixPadding;
  final bool isPassword;
  final String? initialValue;
  final AutovalidateMode? autovalidateMode;
  final int? maxLines;
  final int? maxLength;
  final EdgeInsets? padding;

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool obscure = false;

  void onEyePressed() => setState(() => obscure = !obscure);

  @override
  void initState() {
    if (widget.isPassword) obscure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      initialValue: widget.initialValue,
      obscureText: obscure,
      textAlign: widget.textAlign,
      controller: widget.controller,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      onChanged: widget.onChanged,
      maxLength: widget.maxLength,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: widget.prefixPadding),
          child: widget.prefix,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: widget.suffixPadding),
          child: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    obscure ? SolarIconsBold.eye : SolarIconsBold.eyeClosed,
                    color: AppColors.grey,
                    size: 20,
                  ),
                  onPressed: onEyePressed,
                )
              : null,
        ),
        prefixIconConstraints: BoxConstraints(maxHeight: widget.height),
        suffixIconConstraints: BoxConstraints(maxHeight: widget.height),
        hintStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
        contentPadding: widget.padding ?? EdgeInsets.fromLTRB(16, 0, 16, 0),
        constraints: BoxConstraints(maxHeight: widget.height),
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
      ),
    );
  }
}
