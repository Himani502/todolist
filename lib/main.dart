import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/todo_repository.dart';
import 'package:todolist/todo_screen.dart';
import 'package:todolist/todos_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Color(0xff668EE6),
          fontFamily: 'Cera',
          popupMenuTheme: PopupMenuThemeData(elevation: 2)),
      home: Scaffold(
        body: SafeArea(child: MainScreen()),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TodoRepoFactory.getInstance().fetchTodos(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? _buildTodosPage(snapshot)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildTodosPage(AsyncSnapshot snapshot) {
    return ChangeNotifierProvider(
        create: (context) => TodosModel(todos: snapshot.data),
        child: TodoScreen());
  }
}
