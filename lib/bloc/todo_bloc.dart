import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:taksu_to_do_list/models/todo.dart';
import 'package:taksu_to_do_list/models/user.dart';
import 'package:taksu_to_do_list/utils/global_variable.dart';
import 'package:taksu_to_do_list/utils/shared_pref.dart';
import 'package:uuid/uuid.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  void loadTodo(String username) {
    final userTodos = initialTodo.where((t) => t.user == username).toList();
    emit(userTodos);
  }

  Future<bool> loadThenUpdateTodo() async {
    DateTime now = DateTime.now();
    final formatter = DateFormat('dd MMMM yyyy HH:mm a');

    try {
      final currentTodos = await SharedPref().loadTodos();

      final updatedTodos = currentTodos.map((todo) {
        if (formatter.parse(todo.dueDate).isBefore(now)) {
          return Todo(
            id: todo.id,
            title: todo.title,
            dueDate: todo.dueDate,
            status: "OVERDUE",
            user: todo.user,
          );
        }
        return todo;
      }).toList();

      await SharedPref().saveTodos(updatedTodos);

      emit(updatedTodos);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String username) async {
    final userExists = dummyUser.any((user) => user.name == username);

    if (userExists) {
      return true;
    }
    return false;
  }

  Future<bool> addTodo(String title, String dueDate) async {
    final uuid = Uuid();
    String generateId = uuid.v4();

    try {
      Todo newData = Todo(
        id: generateId,
        title: title,
        dueDate: dueDate,
        status: "OPEN",
        user: GlobalVariable.loggedUser,
      );

      final updatedList = [...state, newData];
      emit(updatedList);

      await SharedPref().saveTodos(updatedList);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTodo(String id) async {
    try {
      SharedPref().saveTodos(state.where((data) => data.id != id).toList());
      emit(state.where((data) => data.id != id).toList());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateTodo(String idTodo, String status) async {
    try {
      final currentTodos = await SharedPref().loadTodos();

      final updatedTodos = currentTodos.map((todo) {
        if (todo.id == idTodo) {
          return Todo(
            id: todo.id,
            title: todo.title,
            dueDate: todo.dueDate,
            status: status,
            user: todo.user,
          );
        }
        return todo;
      }).toList();

      await SharedPref().saveTodos(updatedTodos);

      emit(updatedTodos);

      return true;
    } catch (e) {
      return false;
    }
  }

  // ~ Observer Cubit
  @override
  void onChange(Change<List<Todo>> change) {
    super.onChange(change);
    print("Data berubah dari ${change.currentState.length} menjadi ${change.nextState.length} item");
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // print("Error : $error");
    // print("StackTrace : $stackTrace");
    super.onError(error, stackTrace);
  }
}
