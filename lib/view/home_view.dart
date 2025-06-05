import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taksu_to_do_list/bloc/todo_bloc.dart';
import 'package:taksu_to_do_list/models/todo.dart';
import 'package:taksu_to_do_list/utils/button_config.dart';
import 'package:taksu_to_do_list/utils/color_palette.dart';
import 'package:taksu_to_do_list/utils/form_theme.dart';
import 'package:taksu_to_do_list/utils/global_function.dart';
import 'package:taksu_to_do_list/utils/handling.dart';
import 'package:taksu_to_do_list/utils/typography.dart';
import 'package:taksu_to_do_list/view/empty_data_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.userName});

  final String userName;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TodoCubit todoCubit = TodoCubit();
  bool isLoading = false;

  @override
  void initState() {
    todoCubit.loadTodo(widget.userName);
    super.initState();
  }

  @override
  void dispose() {
    todoCubit.close();
    super.dispose();
  }

  Color getStatusColor(String status) {
    return status.toLowerCase() == "open"
        ? fourth
        : status.toLowerCase() == "done"
            ? third
            : error;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        automaticallyImplyLeading: false,
        title: Text("Hi, ${widget.userName}", style: pageTitle),
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        bloc: todoCubit,
        buildWhen: (previous, current) {
          if (isLoading) {
            return false;
          } else {
            return true;
          }
        },
        builder: (context, todo) {
          if (todo.isEmpty) {
            return const EmptyDataView();
          } else {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                  itemCount: todo.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 26),
                      decoration: BoxDecoration(
                        color: secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: getStatusColor(todo[index].status),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.all(7),
                                child: Text(
                                  todo[index].status,
                                  style: todo[index].status.toLowerCase() == "open" ? statusText : wstatusText,
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(5)),
                                child: IconButton(
                                  color: white,
                                  onPressed: () {
                                    todoCubit.deleteTodo(todo[index].id).then((value) {
                                      if (context.mounted) {
                                        if (value) {
                                          Handling().successHandling(context, "Data Deleted!");
                                        } else {
                                          Handling().errorHandling(context, "Failed Add Data");
                                        }
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.delete_forever),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 9),
                          Text(todo[index].title, style: listTitle),
                          const SizedBox(height: 9),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Due Date :\n${todo[index].dueDate}", style: listDesc),
                              todo[index].status.toLowerCase() == "done"
                                  ? const SizedBox()
                                  : ElevatedButton(
                                      onPressed: () {
                                        todoCubit.updateTodo(todo[index].id, "DONE").then((value) {
                                          if (context.mounted) {
                                            if (value) {
                                              Handling().successHandling(context, "Status Edited");
                                            } else {
                                              Handling().errorHandling(context, "Failed Edit Status");
                                            }
                                          }
                                        });
                                      },
                                      style: secondaryBtn,
                                      child: Text("Done", style: formInput),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            );
          }
        },
      ),
      floatingActionButton: SizedBox(
        width: 65,
        height: 65,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: third,
          onPressed: () {
            dialogBuilder(context, todoCubit);
          },
          child: Icon(
            Icons.add,
            color: primary,
            size: 38,
          ),
        ),
      ),
    );
  }
}

Future<void> dialogBuilder(BuildContext context, TodoCubit todoCubit) {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        backgroundColor: primary,
        title: Text(
          'New Todo',
          style: pageTitle,
        ),
        content: SizedBox(
          width: MediaQuery.sizeOf(context).width - 20,
          child: Form(
            key: formKey,
            child: Theme(
              data: noOutlineForm,
              child: Column(
                children: [
                  SingleInput(
                    hint1: "Input Title",
                    title1: "Title",
                    capitalization: TextCapitalization.words,
                    controller1: titleController,
                    validator1: (item) {
                      if (item == null || titleController.text == "") return "Title Cannot Be Empty!";
                      return null;
                    },
                  ),
                  const SizedBox(height: 19),
                  SingleInput(
                    hint1: "Input Title",
                    title1: "Due Date",
                    readOnly: true,
                    onTap1: () {
                      selecteDate(context, dueDateController);
                    },
                    controller1: dueDateController,
                    validator1: (item) {
                      if (item == null || dueDateController.text == "") return "Date Cannot Be Empty!";
                      return null;
                    },
                  ),
                  const SizedBox(height: 19),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        todoCubit.addTodo(titleController.text, dueDateController.text).then((value) {
                          if (context.mounted) {
                            if (value) {
                              Handling().successHandling(context, "New Data Added!");
                              Navigator.pop(context);
                            } else {
                              Handling().errorHandling(context, "Failed Add New Data!");
                            }
                          }
                        });
                      }
                    },
                    style: secondaryBtn,
                    child: Text("Save", style: formInput),
                  ),
                  const SizedBox(height: 7),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel", style: formInput),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
