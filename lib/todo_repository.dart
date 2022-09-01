import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/todo.dart';

class TodoRepoFactory {
  static TodoRepository getInstance() => PrefsTodoRepo();
}

abstract class TodoRepository {
  fetchTodos();
  saveTodos(List<Todo> todos);
}

class PrefsTodoRepo implements TodoRepository {
  final kKey = 'flutter_todos';

  @override
  Future<List<Todo>> fetchTodos() async {
    var prefs = await SharedPreferences.getInstance();
    return TodosJsonDecoder().decode(prefs.getString(kKey));
  }

  @override
  saveTodos(List<Todo> todos) async {
    var prefs = await SharedPreferences.getInstance();

    var jsonString = jsonEncode(todos);

    print(await prefs.setString(kKey, jsonString));
  }
}

abstract class TodosDecoder {
  List<Todo> decode(String source);
}

class TodosJsonDecoder implements TodosDecoder {
  List<Todo> decode(String source) {
    var json = jsonDecode(source ?? '[]') as List;
    return json.map((item) => Todo.fromJson(item)).toList();
  }
}

  @override
  saveTodos(List<Todo> todos) async {
    print('about to save...');
    var json = jsonEncode(todos);
    await Future.delayed(Duration(seconds: 1), () => print('saved : $json'));
  }

