import 'package:flutter/material.dart';

class Chats extends StatelessWidget {

  List<Widget> listWidget () {
    List<Widget> list = new List();
    for(int i = 1 ; i <= 15 ; i++) {
      list.add(ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.person),
        ),
        title: Text('Contact ' + i.toString()),
        subtitle: Text('hi there'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('2:53 am')],
        ),
      ));
      list.add(Divider());
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: listWidget()
    );
  }

}