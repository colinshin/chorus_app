import 'package:flutter/material.dart';

Widget scaffoldApp({@required String title, @required Widget body}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
      actions: [
        Icon(Icons.favorite),
        Icon(Icons.search),
      ],
    ),
    body: body,
  );
}
