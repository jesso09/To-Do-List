library GlobalFunction;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void movePage(BuildContext context, Widget destination) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
}

Future<void> selecteDate(BuildContext context, TextEditingController controller) async {
  final datePicked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return child!;
    },
  );

  if (datePicked != null) {
    if (context.mounted) {
      final timePicked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(datePicked),
          initialEntryMode: TimePickerEntryMode.dialOnly,
          builder: (context, child) {
            return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), child: child!);
          });

      if (timePicked != null) {
        final combinedDateTime = DateTime(
          datePicked.year,
          datePicked.month,
          datePicked.day,
          timePicked.hour,
          timePicked.minute,
        );

        controller.text = DateFormat('dd MMMM yyyy HH:mm a').format(combinedDateTime);
      }
    }
  }
}
