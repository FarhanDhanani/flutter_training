import 'calls.dart';
import 'package:flutter/material.dart';
import 'chats.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WhatsApp',
      theme: ThemeData(
          primaryColor: Color(0xFF128C7E)
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final appBar = AppBar(
    // Here we take the value from the MyHomePage object that was created by
    // the App.build method, and use it to set our appbar title.
    title: Text('WhatsApp'),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.search),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.more_vert),
      ),
    ],
    bottom: TabBar(
      tabs: <Widget>[
        Tab(icon: Icon(Icons.camera_alt)),
        Tab(text: 'CHATS'),
        Tab(text: 'STATUS'),
        Tab(text: 'CALLS'),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: appBar,
        body: TabBarView(
          children: <Widget>[
            Text(''),
            Chats(),
            Text('STATUS'),
            Calls()
          ],
        ),
      ),
    );
  }
}