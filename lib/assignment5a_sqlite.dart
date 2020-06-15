import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'suggestion.dart';
import 'suggestionList.dart';
import 'dart:core';
import 'dart:math';
import 'favouritePage.dart';
import 'contants.dart' as Constants;
import 'package:random_string/random_string.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<Database> openConnection() async {
    return openDatabase(
        join(await getDatabasesPath(), 'suggestions_database_23.db'),
        version: 1, onCreate: (db, version) {
      db.execute(
          "CREATE TABLE suggestions(id INTEGER PRIMARY KEY, name TEXT, isFavourite INTEGER)");
      List<String> recordsToSeed = [];

      Constants.suggestions.forEach((item) {
        String suggestionName = item['name'];
        int isFavourite = item['isFavourite'];
        int id = item['id'];
        recordsToSeed.add("($id, '$suggestionName', $isFavourite)");
      });

      db.execute(
          "INSERT INTO suggestions (id, name, isFavourite) VALUES ${recordsToSeed.join(', ')}");
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MyHomePage(
            title: 'Flutter Demo Home Page', openConnection: openConnection),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/favourites': (context) =>
            FavouritesPage(openConnection: openConnection),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.openConnection}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final Function openConnection;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> dogsList = List<Widget>();

  // Define a function that inserts dogs into the database
  Future<void> insertSuggestion(Suggestion suggestion) async {
    // Get a reference to the database.
    final Database db = await this.widget.openConnection();

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'dogs',
      suggestion.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Suggestion>> getSuggestions({whereClause, whereArgs}) async {
    // Get a reference to the database.
    final Database db = await this.widget.openConnection();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps =
    await db.query('suggestions', where: whereClause, whereArgs: whereArgs);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Suggestion(
        id: maps[i]['id'],
        name: maps[i]['name'],
        isFavourite: maps[i]['isFavourite'],
      );
    });
  }

  Future<void> updateSuggestion(Suggestion suggestion) async {
    // Get a reference to the database.
    final db = await this.widget.openConnection();

    // Update the given Dog.
    await db.update(
      'suggestions',
      suggestion.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [suggestion.id],
    );

    setState(() {});
  }

  Future<void> deleteSuggestion(int id) async {
    // Get a reference to the database.
    final db = await this.widget.openConnection();

    // Remove the Dog from the Database.
    await db.delete(
      'suggestions',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Favourites'),
              onTap: () {
                Navigator.pushNamed(context, '/favourites');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(title: Text("Favourites App")),
      body: Container(
        child: Center(
          child: FutureBuilder<List<Suggestion>>(
            future:
            getSuggestions(), // a previously-obtained Future<String> or null
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SuggestionsList(
                    suggestions: snapshot.data,
                    updateSuggestion: updateSuggestion);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}