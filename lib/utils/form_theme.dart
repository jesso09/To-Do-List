library FormTheme;

import 'package:flutter/material.dart';
import 'package:taksu_to_do_list/utils/color_palette.dart';

import 'typography.dart';

ThemeData noOutlineForm = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    fillColor: secondary,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: secondary,
      ),
    ),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: secondary,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: error,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: error,
      ),
    ),
  ),
);

class SingleInput<T> extends StatelessWidget {
  final String hint1;
  final String title1;
  final TextEditingController controller1;
  final bool? readOnly;
  final bool? interactiveSelec;
  final String? Function(String?)? validator1;
  final TextInputType? keyboardType;
  final TextCapitalization? capitalization;
  final void Function()? onTap1;
  final ValueChanged<String>? isChanged;

  const SingleInput({
    super.key,
    required this.hint1,
    required this.title1,
    this.readOnly,
    this.interactiveSelec,
    required this.controller1,
    this.validator1,
    this.keyboardType,
    this.capitalization,
    this.onTap1,
    this.isChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title1,
          style: formTitle,
        ),
        const SizedBox(height: 10),
        TextFormField(
          cursorColor: white,
          readOnly: readOnly ?? false,
          keyboardType: keyboardType ?? TextInputType.text,
          controller: controller1,
          decoration: InputDecoration(
            hintText: hint1,
            hintStyle: formInput,
          ),
          onChanged: isChanged,
          style: formInput,
          onTap: onTap1,
          textCapitalization: capitalization ?? TextCapitalization.none,
          enableInteractiveSelection: interactiveSelec ?? true,
          validator: (value) {
            final result = validator1?.call(value);
            return result?.isEmpty ?? true ? null : result;
          },
        ),
      ],
    );
  }
}
