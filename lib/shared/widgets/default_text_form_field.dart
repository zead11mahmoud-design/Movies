import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';

class DefaultTextFormField extends StatefulWidget {
  String hintText;
  TextEditingController? controller;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  String? prefixIconImageName;
  String? suffixIconImageName;
  bool isPassword;
  int maxLines;

  DefaultTextFormField({
    required this.hintText,
    this.controller,
    this.onChanged,
    this.validator,
    this.isPassword = false,
    this.prefixIconImageName,
    this.suffixIconImageName,
    this.maxLines = 1,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late bool isObScure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIconImageName == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/icons/${widget.prefixIconImageName}.svg',
                  width: 24,
                  height: 24,
                  fit: .scaleDown,
                ),
              ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObScure = !isObScure;
                  setState(() {});
                },
                icon: Icon(
                  isObScure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppTheme.white,
                ),
              )
            : widget.suffixIconImageName == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/icons/${widget.suffixIconImageName}.svg',
                  width: 24,
                  height: 24,
                  fit: .scaleDown,
                ),
              ),
      ),
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: isObScure,
      autovalidateMode: .onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      maxLines: widget.maxLines,
    );
  }
}
