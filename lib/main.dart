// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:toridori_task_app/View/home.dart';
import 'Model/model.dart';
import 'View/test.dart';
import 'package:toridori_task_app/Model/model.dart';
import 'dart:async'; //非同期処理用
import 'dart:convert';
import 'package:http/http.dart' ;


void main() {
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
      home: MyStatelessWidget(),//home.dart
    );
  }
}

///タブリスト
const List<Tab> tabs = <Tab>[
  Tab(text: '全て',),
  Tab(text: 'p: webview',),
  Tab(text: 'p: shared_preferences',),
  Tab(text: 'waiting for customer response',),
  Tab(text: 'severe: new feature',),
  Tab(text: 'p: share',),
];

Issue issue = Issue(number: 0, comments: 0, title: 'タイトル', body: '質問', since: '時刻');



class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }

}



//todo gitと連携する
//todo Tabを6つ作る
//todo Tabbarの作成
//todo Dart Analysis のエラー解消

//APi通信　Httpリクエスト

// ? スクロールできるTabBarとアイコンボタンの並列配置
// ? クラスの引継ぎ方がわからない

//ウィジェットは変数にしない
//StaelessWidgetの変数にはfinalをつける。