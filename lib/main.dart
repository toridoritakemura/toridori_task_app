// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:toridori_task_app/View/home.dart';



void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,//タグ非表示
      title: _title,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyStatelessWidget(),//home.dart
    );
  }
}

class MyStatelessWidget extends StatefulWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  State<MyStatelessWidget> createState() => _MyStatelessWidget();
}

class _MyStatelessWidget extends State<MyStatelessWidget> {

  @override
  Widget build(BuildContext context) {
    return const HomePage();

  }

}
