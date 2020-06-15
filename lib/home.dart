import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_avatar.dart';
import 'landscape_view.dart';
import 'listView_widget.dart';

class HomeWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context)  => _buildLayoutWithMediaQuery(context);

  @override
  Widget _buildLayout(BuildContext context, var isLargeScreen) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Week 3 Assignment')
        ),
        drawer: isLargeScreen ? Container() :  new Drawer(child: ListViewWidget()),
        body: isLargeScreen ? LandscapeView() : CustomAvatar()
    );
  }

  Widget _buildLayoutWithMediaQuery(BuildContext context) => _buildLayout(context, MediaQuery.of(context).size.width > 600);

}