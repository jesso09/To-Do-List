import 'package:flutter/material.dart';
import 'package:taksu_to_do_list/utils/typography.dart';

class EmptyDataView extends StatelessWidget {
  const EmptyDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Empty Data", style: pageTitle),
    );
  }
}