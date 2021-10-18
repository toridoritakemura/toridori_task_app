//todo review: ignore_for_fileはいらなさそう
import 'package:flutter/material.dart';

import 'package:toridori_task_app/View/home.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //タグ非表示
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      //todo review: MyStatelessWidgetは何もしていないのでいらなさそう
      /// const使ってていいね！
      home: HomePage.wrapped(), //home.dart
    );
  }
}
