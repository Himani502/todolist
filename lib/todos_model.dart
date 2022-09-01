import 'dart:collection';
import 'package:flutter/widgets.dart';
import 'package:todolist/todo.dart';
import 'package:todolist/todo_repository.dart';

class TodosModel extends ChangeNotifier {
  List<Todo> _todos;

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  TodosModel({@required todos}) : _todos = todos;

  void addTodo(Todo todo) {
    _todos.add(todo);

    notifyListeners();
  }

  removeTodoAt(int id) {
    _todos.removeAt(id);

    notifyListeners();
  }

  toggleCompletedAt(int id) {
    _todos[id].toggleCompleted();

    notifyListeners();
  }


  @override
  notifyListeners() {
    super.notifyListeners();
    persist(this.todos);
  }
}

persist(todos) {
  TodoRepoFactory.getInstance().saveTodos(todos);
}
