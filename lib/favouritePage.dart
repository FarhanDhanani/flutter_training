import 'package:flutter/material.dart';
import 'suggestion.dart';
import 'package:sqflite/sqflite.dart';

class FavouritesPage extends StatelessWidget {
  FavouritesPage({Key key, this.openConnection}) : super(key: key);

  final Function openConnection;

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Suggestion>> getSuggestions({whereClause, whereArgs}) async {
    // Get a reference to the database.
    final Database db = await openConnection();

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favourites App")),
      body: Container(
        child: Center(
          child: FutureBuilder<List<Suggestion>>(
            future: getSuggestions(
                whereClause: 'isFavourite = ?',
                whereArgs: [1]), // a previously-obtained Future<String> or null
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(snapshot.data[index].name ?? ""),
                  ),
                );
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