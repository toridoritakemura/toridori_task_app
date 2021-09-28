
import 'dart:async'; //非同期処理用
import 'dart:convert';
import 'package:http/http.dart' ;
import 'package:toridori_task_app/Model/label_model.dart';

Issue issue = Issue(number: 0, comments: 0, title: 'タイトル', body: '質問', since: '時刻',label_name: labelList[0].name);

List<Issue> apiList = [
  Issue(number: 1, comments: 0, title: 'タイトル1', body: '質問1', since: '時刻1',label_name: labelList[0].name),
  Issue(number: 2, comments: 1, title: 'タイトル2', body: '質問2', since: '時刻2',label_name: labelList[0].name),
];

class Issue {
  ///プロパティ
  final int? number; //No.
  final int? comments; //コメント数
  final String? title; //タイトル
  final String? body; //質問分
  final String? since; //日付
  final String? label_name;//ラベルタグ


  ///コンストラクタ
  Issue({
    required this.number,
    required this.comments,
    required this.title,
    required this.body,
    required this.since,
    required this.label_name,
  });

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
            label_name: data['labels'][3]['name']?? 'no label',
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
    const url = 'https://api.github.com/repos/flutter/flutter/issues/90597';
    try{
      final result = await get(Uri.parse(url));
      final data = jsonDecode(result.body);
      final issue = Issue(
        number : data['number']?? 0,
        comments: data['comments'],
        title: data['title'],
        body: data['body'],
        since: data['created_at'],
        label_name: data['name'],
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
          label_name: data['label_name'] ?? 'no label',
        );
      }).toList();

      return issuesList;

    }catch(e){

      rethrow;
    }
  }




