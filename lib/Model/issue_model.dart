
import 'dart:async'; //非同期処理用
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http ;///1,httpパッケージを追加

///3.JSONを解析して写真のリストに変換
///Issueクラスの作成
class Issue {

  final int? number; //No.
  final int? comments; //コメント数
  final String? title; //タイトル
  final String? body; //質問分
  final String? createdAt; //日付
  final String? state;


  Issue({
    required this.number,
    required this.comments,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.state

  });

  //Jsonオブジェクトの作成
  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      number: json['number'],
      comments: json['comments'],
      title: json['title'],
      body: json['body'],
      createdAt: json['created_at'],
      state: json['state'],
    );
  }
}

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


///[各ラベル]のIssue呼び出し
Future<List<Issue>> fetchLabelsIssue(labels) async {

  final response = await http.get(Uri.parse('https://api.github.com/repos/flutter/flutter/issues?labels=$labels'),
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
