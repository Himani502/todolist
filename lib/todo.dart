import 'package:meta/meta.dart';

class Todo {
  final String text;
  bool completed;
  DateTime time;

  Todo({@required this.text, DateTime time, this.completed = false})
      : time = time ?? DateTime.now();

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        text: json['text'],
        completed: json['completed'],
        time: DateTime.parse(json['time']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'completed': completed,
        'time': time.toString(),
      };

  @override
  String toString() {
    return 'text: $text, completed: $completed, time: $time';
  }

  void toggleCompleted() {
    completed = !completed;
  }

  bool operator ==(oper) =>
      oper is Todo &&
      oper.text == this.text &&
      oper.completed == this.completed &&
      oper.time == this.time;

  @override
  int get hashCode => text.hashCode ^ time.hashCode ^ time.toString().hashCode;
}
