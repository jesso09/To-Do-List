import 'package:flutter/material.dart';
import 'package:taksu_to_do_list/utils/color_palette.dart';
import 'package:taksu_to_do_list/utils/typography.dart';

class Handling {
  void errorHandling(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: error,
        content: Text(
          message,
          style: formInput,
        ),
      ),
    );
  }
  
  void successHandling(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: third,
        content: Text(
          message,
          style: formInput,
        ),
      ),
    );
  }
}
