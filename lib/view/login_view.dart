import 'package:flutter/material.dart';
import 'package:taksu_to_do_list/bloc/todo_bloc.dart';
import 'package:taksu_to_do_list/utils/button_config.dart';
import 'package:taksu_to_do_list/utils/color_palette.dart';
import 'package:taksu_to_do_list/utils/form_theme.dart';
import 'package:taksu_to_do_list/utils/global_function.dart';
import 'package:taksu_to_do_list/utils/handling.dart';
import 'package:taksu_to_do_list/utils/shared_pref.dart';
import 'package:taksu_to_do_list/utils/typography.dart';
import 'package:taksu_to_do_list/view/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  TodoCubit todoCubit = TodoCubit();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  Future<void> handleLogin() async {
    if (formKey.currentState!.validate()) {
      todoCubit.login(nameController.text).then((value) {
        if (!mounted) return;
        if (mounted) {
          if (value) {
            SharedPref().saveName(nameController.text);
            Handling().successHandling(context, "Login Succesfully!");
            movePage(context, HomeView(userName: nameController.text));
          } else {
            Handling().errorHandling(context, "User Not Found!");
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Form(
        key: formKey,
        child: Theme(
          data: noOutlineForm,
          child: Padding(
            padding: const EdgeInsets.only(left: 70, right: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleInput(
                  hint1: "Input Name",
                  title1: "Name",
                  controller1: nameController,
                  validator1: (name) {
                    if (name == "" || nameController.text == "") return "Name Cannot Be Empty!";
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    handleLogin();
                  },
                  style: primaryBtn,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Next", style: formInput),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 24,
                        color: white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
