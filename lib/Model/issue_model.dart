
import 'dart:async'; //非同期処理用
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http ;///1,httpパッケージを追加


///Issueクラスの作成
class Issue {

  final int? number; //No.
  final int? comments; //コメント数
  final String? title; //タイトル
  final String? body; //質問分
  final String? updatedAt; //日付
  final String? state;//closeされてるか
  final String? updated;//更新日時


  Issue({
    required this.number,
    required this.comments,
    required this.title,
    required this.body,
    required this.updatedAt,
    required this.state,
    required this.updated,
  });

  //Jsonオブジェクトの作成
  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      number: json['number'],
      comments: json['comments'],
      title: json['title'],
      body: json['body'],
      updatedAt: json['updated_at'],
      state: json['state'],
      updated: json['updated_at'],
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

///Issue呼び出し[各ラベル
Future<List<Issue>> fetchLabelsIssue(String labels,String state,String since,String sort) async {

  final response = await http.get(Uri.parse('https://api.github.com/repos/flutter/flutter/issues?labels=$labels&state=$state&since=$since&sort=$sort'),
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
