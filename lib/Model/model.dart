
import 'dart:async'; //非同期処理用
import 'dart:convert';
import 'package:http/http.dart' ;
import 'package:toridori_task_app/main.dart';


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

  ///Issue1個分APIコール部分
  static Future<Issue> searchRepositories() async {
    String url = 'https://api.github.com/repos/flutter/flutter/issues/42';
    try{
      final result = await get(Uri.parse(url));
      final data = jsonDecode(result.body);
      final issue = Issue(
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

  ///Issue1個分APIコール部分
  static Future<List<Issue>> getIssueListAPI() async {
    String url = 'https://api.github.com/repos/flutter/flutter/issues';
    try{
      final result = await get(Uri.parse(url));
      final data = jsonDecode(result.body);
      final issuesListData = data ;

      final issuesList = issuesListData.map((issue){
        return Issue (
          number : data['number'],
          comments: data['comments'],
          title: data['title'],
          body: data['body'],
          since: data['created_at'],
        );

      }).toList();
      return issuesList;
    }catch(e){

      print(e);
      rethrow;
    }
  }
}











