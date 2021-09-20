// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:toridori_task_app/View/home.dart';
import 'Model/model.dart';
import 'View/test.dart';
import 'dart:async'; //非同期処理用
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
  GithubClient()._searchRepositories('date').catchError((e)=>print(e));
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


class MyStatelessWidget extends StatelessWidget {
  final Issue issue = Issue('#0000', '0', 'Title', 'Text', 'Date');

  MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }

}



///APIコール部分
class GithubClient {
  Future<List<Issue>> _searchRepositories(String searchWord) async {
    print('test');
    final response = await http.get(Uri.parse('https://github.com/flutter/flutter/issues'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<Issue> list = [];
      Map<String, dynamic> decoded = json.decode(response.body);
      for (var item in decoded['items']) {
        list.add(Issue.fromJson(item));
      }
      print(list.length);
      return list;
    } else {
      throw Exception('Fail to search repository');
    }
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