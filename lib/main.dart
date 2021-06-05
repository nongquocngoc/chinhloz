import 'package:flutter/material.dart';
import 'package:cuoiki_flutter/listview.dart';
import 'package:cuoiki_flutter/update.dart';
void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: listview(),
        routes: <String, WidgetBuilder>{
          // '/update': (BuildContext context) => new update()
          // '/Editprofile': (BuildContext context) => new EditProfile()
        },
      )
  );
}