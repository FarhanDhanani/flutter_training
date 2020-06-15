import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        getListViewCard('List Item 1'),
        getListViewCard('List Item 2'),
        getListViewCard('List Item 3'),
        getListViewCard('List Item 4'),
        getListViewCard('List Item 5'),
      ],
    );
  }

  Padding getListViewCard(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: new ListTile(
          title: new Text(text),
        ),
      ),
    );
  }

}
