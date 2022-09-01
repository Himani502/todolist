
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolist/todo.dart';
import 'package:todolist/todos_model.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final int index;

  TodoItem({this.todo, this.index});

  @override
  Widget build(BuildContext context) {

    Widget getDissmissBackground(bool left) {
      return Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.red[400]),
        alignment: Alignment(left ? -0.9 : 0.9, 0),
        child: Icon(
          FontAwesomeIcons.trash,
          color: Colors.white,
          size: 20,
        ),
      );
    }

    return Dismissible(
      key: ValueKey<String>(todo.text),
      background: getDissmissBackground(true),
      secondaryBackground: getDissmissBackground(false),
      onDismissed: (DismissDirection direction) =>
          Provider.of<TodosModel>(context, listen: false).removeTodoAt(index),
      child: Card(
        elevation: 0,
        color: Color(0xfffff5fb),
        child: ListTile(
          title: Text(
            todo.text,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black),
          ),
          subtitle: Text('${todo.time.hour}:${todo.time.minute}'),
        ),
      ),
    );
  }
}
