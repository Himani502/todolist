import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/todo.dart';
import 'package:todolist/todo_item.dart';
import 'package:todolist/todos_model.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen();

  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final textctrl = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
        /*decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pattern-hd.jpg'),
              fit: BoxFit.cover),
        ),*/
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: <Widget>[
              const CustomAppBar(),
              _buildList(),
              _buildInputRow(),
            ],
          ),
        ));
  }

  Widget _buildList() {
    return Consumer<TodosModel>(
      builder: (context, model, _) => Expanded(
          child: model.todos.length != 0
              ? ListView.builder(
                  controller: _scrollController,
                  itemCount: model.todos.length,
                  itemBuilder: _todoItemBuilder,
                )
              : Center(
                  child: Text('Add something!'),
                )),
    );
  }

  Widget _buildInputRow() {
    return Container(
      margin: EdgeInsets.only(top: 7),
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: textctrl,
              decoration: InputDecoration(
                hintText: 'I want to ...',
                border: InputBorder.none,
              ),
            ),
          ),
          FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Color(0xff2c2f36),
            textColor: Colors.white,
            child: Text('Add Task'),
            onPressed: () {
              if (textctrl.text.isNotEmpty) {
                var todo = Todo(text: textctrl.text.trim());
                Provider.of<TodosModel>(context, listen: false).addTodo(todo);

                setState(() {
                  textctrl.text = '';
                });

                _scrollToBottom();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _todoItemBuilder(BuildContext context, int index) {
    final todo = Provider.of<TodosModel>(context, listen: false).todos[index];
    return TodoItem(
      todo: todo,
      index: index,
    );
  }

  void _scrollToBottom() {
    if (_scrollController.positions.toList().isNotEmpty) {
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease);
    }
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 18, bottom: 18, right: 5),
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          'To-do list',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
        ),

      ]),
    );
  }
}
