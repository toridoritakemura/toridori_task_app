import 'dart:convert';

class Issue {
  ///プロパティ
  final String issue_number;//No.
  final String comment;//コメント
  final String title;//タイトル
  final String text;//質問分
  final String date;//日付

  ///コンストラクタ
  Issue(this.issue_number, this.comment, this.title, this.text, this.date,);

  Issue.fromJson(Map<String, dynamic> json)
      : issue_number = json['issue_number'],
        comment = json['comment'],
        title = json['title'],
        text = json['text'],
        date = json['date'];


}








