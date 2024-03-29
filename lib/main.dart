import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> tasks = [];

  void addTask(Task newTask) {
    setState(() {
      tasks.add(newTask);
    });
  }

  void editTask(int index, String newTitle) {
    setState(() {
      tasks[index].title = newTitle;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ColumnScreen(tasks: tasks, addTask: addTask, editTask: editTask, deleteTask: deleteTask)),
                );
              },
              child: Text("Column"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListViewScreen(tasks: tasks, addTask: addTask, editTask: editTask, deleteTask: deleteTask)),
                );
              },
              child: Text("ListView"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListViewSeparatedScreen(tasks: tasks, addTask: addTask, editTask: editTask, deleteTask: deleteTask)),
                );
              },
              child: Text("ListView Separated"),
            ),
          ],
        ),
      ),
    );
  }
}

class ColumnScreen extends StatefulWidget {
  final List<Task> tasks;
  final Function(Task) addTask;
  final Function(int, String) editTask;
  final Function(int) deleteTask;

  ColumnScreen({required this.tasks, required this.addTask, required this.editTask, required this.deleteTask});

  @override
  _ColumnScreenState createState() => _ColumnScreenState();
}

class _ColumnScreenState extends State<ColumnScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Column"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int index = 0; index < widget.tasks.length; index++)
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Text(widget.tasks[index].title),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editTask(context, index);
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        widget.deleteTask(index);
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Task newTask = Task(title: "New Task");
          widget.addTask(newTask);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _editTask(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTitle = widget.tasks[index].title;
        return AlertDialog(
          title: Text("Edit Task"),
          content: TextField(
            onChanged: (value) {
              newTitle = value;
            },
            controller: TextEditingController(text: widget.tasks[index].title),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                widget.editTask(index, newTitle);
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}

class ListViewScreen extends StatefulWidget {
  final List<Task> tasks;
  final Function(Task) addTask;
  final Function(int, String) editTask;
  final Function(int) deleteTask;

  ListViewScreen({required this.tasks, required this.addTask, required this.editTask, required this.deleteTask});

  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
      ),
      body: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            key: ValueKey(widget.tasks[index]),
            title: Text(widget.tasks[index].title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editTask(context, index);
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    widget.deleteTask(index);
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Task newTask = Task(title: "New Task");
          widget.addTask(newTask);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _editTask(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTitle = widget.tasks[index].title;
        return AlertDialog(
          title: Text("Edit Task"),
          content: TextField(
            onChanged: (value) {
              newTitle = value;
            },
            controller: TextEditingController(text: widget.tasks[index].title),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                widget.editTask(index, newTitle);
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}

class ListViewSeparatedScreen extends StatefulWidget {
  final List<Task> tasks;
  final Function(Task) addTask;
  final Function(int, String) editTask;
  final Function(int) deleteTask;

  ListViewSeparatedScreen({required this.tasks, required this.addTask, required this.editTask, required this.deleteTask});

  @override
  _ListViewSeparatedScreenState createState() => _ListViewSeparatedScreenState();
}

class _ListViewSeparatedScreenState extends State<ListViewSeparatedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView Separated"),
      ),
      body: ListView.separated(
        itemCount: widget.tasks.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            key: ValueKey(widget.tasks[index]),
            title: Text(widget.tasks[index].title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editTask(context, index);
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    widget.deleteTask(index);
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Task newTask = Task(title: "New Task");
          widget.addTask(newTask);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _editTask(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTitle = widget.tasks[index].title;
        return AlertDialog(
          title: Text("Edit Task"),
          content: TextField(
            onChanged: (value) {
              newTitle = value;
            },
            controller: TextEditingController(text: widget.tasks[index].title),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                widget.editTask(index, newTitle);
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
