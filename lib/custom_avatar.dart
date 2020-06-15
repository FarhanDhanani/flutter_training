import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 3 / 5,
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.blue, shape: BoxShape.circle),
            child: FittedBox(
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            )),
      ),
    );
  }

}