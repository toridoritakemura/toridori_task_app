import 'package:toridori_task_app/View/home.dart';
import 'dart:async'; //非同期処理用
import 'dart:convert';
import 'package:http/http.dart' ;


class Issue {
  ///プロパティ
  int number;//No.
  int comments;//コメント数
  String title;//タイトル
  String body;//質問分
  String since;//日付

  ///コンストラクタ
  Issue({
    required this.number,
    required this.comments,
    required this.title,
    required this.body,
    required this.since,
  });

  ///APIコール部分
  static Future<Issue> searchRepositories() async {
    String url = 'https://api.github.com/repos/flutter/flutter/issues/42';
    try{
      var result = await get(Uri.parse(url));
      Map<String,dynamic> data = jsonDecode(result.body);
      Issue issue = Issue(
        number : data['number'],
        comments: data['comments'],
        title: data['title'],
        body: data['body'],
        since: data['created_at'],
      );
        print(data);
      return issue;

    }catch(e){

      print(e);
      rethrow;


    }

  }



}











