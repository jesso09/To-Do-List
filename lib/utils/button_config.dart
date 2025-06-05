library ButtonConfig;

import 'package:flutter/material.dart';
import 'package:taksu_to_do_list/utils/color_palette.dart';

ButtonStyle primaryBtn = ButtonStyle(
    backgroundColor: WidgetStateColor.resolveWith(
      (states) => third,
    ),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 29, vertical: 8),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    elevation: const WidgetStatePropertyAll(5),
  );

ButtonStyle secondaryBtn = ButtonStyle(
    backgroundColor: WidgetStateColor.resolveWith(
      (states) => secondaryBtnColor,
    ),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 29, vertical: 8),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    elevation: const WidgetStatePropertyAll(5),
  );
