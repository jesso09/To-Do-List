import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksu_to_do_list/models/todo.dart';
import 'package:taksu_to_do_list/utils/global_variable.dart';

class SharedPref {
  Future<void> saveName(String username) async {
    SharedPreferences saveItem = await SharedPreferences.getInstance();
    await saveItem.setString('username', username);
  }

  Future<void> loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GlobalVariable.loggedUser = prefs.getString('username') ?? "";
    print(GlobalVariable.loggedUser);
  }

  Future<void> saveTodos(List<Todo> todoList) async {
    final prefs = await SharedPreferences.getInstance();
    final todoListJson = todoList.map((todo) => todo.toJson()).toList();
    await prefs.setString("todo", json.encode(todoListJson));
  }

  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getString("todo");
    
    if (todosJson != null) {
      final List<dynamic> decoded = json.decode(todosJson);
      return decoded.map((json) => Todo.fromJson(json)).toList();
    }
    return [];
  }
}