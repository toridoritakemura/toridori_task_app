
import 'dart:async'; //非同期処理用
import 'dart:convert';
import 'package:http/http.dart' ;




class Issue {
  ///プロパティ
  final int? number; //No.
  final int? comments; //コメント数
  final String? title; //タイトル
  final String? body; //質問分
  final String? since; //日付


  ///コンストラクタ
  Issue({
    required this.number,
    required this.comments,
    required this.title,
    required this.body,
    required this.since,
  });

  factory Issue.fromJson(final json) {
    return Issue(
      number: json['number'],
      comments: json['comments'],
      title: json['title'],
      body: json['body'],
      since: json['since'],
    );
  }

  ///IssueListのAPIコール部分
  Future<List<Issue>> getIssueListAPI() async {
    try{
      const url = 'https://api.github.com/repos/flutter/flutter/issues';
      final result = await get(Uri.parse(url));
      if (result.statusCode == 200) {
        final data = jsonDecode(result.body);
        final issuesListData = data ;

        final issuesList = issuesListData.list<Issue>((){
          return Issue (
            number : data['number'] ?? 0,
            comments: data['comments'] ?? 0,
            title: data['title'] ?? 'no title',
            body: data['body' ] ?? 'no body',
            since: data['created_at'] ?? 'no since',
          );
        }).toList();

        return issuesList;
      } else {
        throw Exception('Failed to load Issue');

      }
    }
    catch (e){
      rethrow;
    }



  }


}



  ///Issue1個分APIコール部分
  Future<Issue> searchRepositories() async {
    const url = 'https://api.github.com/repos/flutter/flutter/issues/42';
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

      return issue;

    }catch(e){

      rethrow;
    }

  }

  ///IssueListのAPIコール部分
  Future<List<Issue>> getIssueListAPI() async {
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

      return issuesList;

    }catch(e){

      rethrow;
    }
  }




