import 'listView_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_avatar.dart';

class LandscapeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ListViewWidget(),
        ),
        Expanded(
          flex: 2,
          child: CustomAvatar(),
        ),
      ],
    );
  }

}
