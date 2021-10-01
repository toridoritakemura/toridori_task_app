
import 'dart:async'; //非同期処理用
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http ;///1,httpパッケージを追加


///Issue単体のAPIデータ取得
Future<Issue> fetchOneIssue() async {
  final response = await http
      .get(Uri.parse('https://api.github.com/repos/flutter/flutter/issues/90597'),
    headers: {
      HttpHeaders.authorizationHeader: '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',
    },
  );

  //サーバーが200 OK のレスポンスを返した場合、
  if (response.statusCode == 200) {
    //JSONを解析。
    return Issue.fromJson(jsonDecode(response.body));
  } else {

    throw Exception('Failed to load album');
  }
}

///IssueのListのAPIコール部分
Future<List<Issue>> fetchListIssue() async {

    final response = await http.get(Uri.parse('https://api.github.com/repos/flutter/flutter/issues'),
      headers: {
      HttpHeaders.authorizationHeader: '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',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Issue.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
}


///3.JSONを解析して写真のリストに変換
///Issueクラスの作成
class Issue {

  final int? number; //No.
  final int? comments; //コメント数
  final String? title; //タイトル
  final String? body; //質問分
  final String? since; //日付
//  final List<String>? label_name;//ラベルタグ


  Issue({
    required this.number,
    required this.comments,
    required this.title,
    required this.body,
    required this.since,
//    required this.label_name,
  });

  //Jsonオブジェクトの作成
  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
        number: json['number'],
        comments: json['comments'],
        title: json['title'],
        body: json['body'],
        since: json['since'],
//        label_name: json['labels']['name'],
    );
  }

}
















