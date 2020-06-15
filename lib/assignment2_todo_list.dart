import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

final List<String> todos = new List();
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = todos.map((String string) {
      return ListTile(
        title: Text(
          string,
          style: _biggerFont,
        ),
      );
    },
    );
    final List<Widget> divided = ListTile.divideTiles(
        context: context, tiles: tiles).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text('Todo List Application'),
        ),
        body: ListView(
          children: divided,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addToDo,
          child: Icon(Icons.add),
        )
    );
  }

  void _addToDo() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Add ToDo'),
              ),
              body: TextField(
                onSubmitted: (String value) async {
                  todos.add(value);

                  await showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Thanks!'),
                          content: Text('Added Successfully'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                },
              )
          );
        },
      ),
    );
  }
}