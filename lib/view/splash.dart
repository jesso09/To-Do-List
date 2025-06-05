import 'package:flutter/material.dart';
import 'package:taksu_to_do_list/models/todo.dart';
import 'package:taksu_to_do_list/utils/color_palette.dart';
import 'package:taksu_to_do_list/utils/global_function.dart';
import 'package:taksu_to_do_list/utils/shared_pref.dart';
import 'package:taksu_to_do_list/view/login_view.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double opacityValue = 0.0;

  @override
  void initState() {
    super.initState();
    nextPage();
  }

  void nextPage() {
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        opacityValue = 1.0;
      });
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      SharedPref().loadName().then((value) {
        SharedPref().loadTodos().then((value) {
          initialTodo = value;
          if (mounted) {
            // if (GlobalVariable.loggedUser == "") {
            movePage(context, const LoginView());
            // } else {
            //   movePage(context, HomeView(userName: GlobalVariable.loggedUser));
            // }
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: AnimatedOpacity(
            opacity: opacityValue,
            duration: const Duration(milliseconds: 800),
            child: Icon(
              Icons.task_alt_outlined,
              size: 50,
              color: white,
            ),
          ),
        ),
      ),
    );
  }
}
