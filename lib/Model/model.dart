
import 'dart:async'; //非同期処理用
import 'dart:convert';
import 'package:http/http.dart' ;
import 'package:toridori_task_app/main.dart';


class Issue {
  ///プロパティ
  final int? number;//No.
  final int? comments;//コメント数
  final String? title;//タイトル
  final String? body;//質問分
  final String? since;//日付

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
        number : data['number']?? 0,
        comments: data['comments'],
        title: data['title'],
        body: data['body'],
        since: data['created_at'],
      );
      print(issue);

      return issue;

    }catch(e){

      print(e);
      rethrow;
    }

  }

  ///IssueListのAPIコール部分
  static Future<List<Issue>> getIssueListAPI() async {
    String url = 'https://api.github.com/repos/flutter/flutter/issues';
    try{

      final result = await get(Uri.parse(url));
      final data = jsonDecode(result.body);
      final issuesListData = data ;


      final issuesList = issuesListData.map<Issue>((data){
        return Issue (
          number : data['number'] ?? 0,
          comments: data['comments'] ?? 0,
          title: data['title'] ?? 'no title',
          body: data['body' ] ?? 'no body',
          since: data['created_at'] ?? 'no since',
        );
      }).toList();
      print(issuesList);
      return issuesList;

    }catch(e){

      print(e);
      rethrow;
    }
  }
}











