// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:toridori_task_app/View/home.dart';

import 'Model/model.dart';
import 'View/issue_card.dart';

void main() {

  runApp(const MyApp());
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
      home: const MyStatelessWidget(),//home.dart
    );
  }
}

class MyStatelessWidget extends StatefulWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);



  @override
  State<MyStatelessWidget> createState() => _MyStatelessWidget();
}

class _MyStatelessWidget extends State<MyStatelessWidget> {

  //API呼び出し
  Future getAPI() async{
    issue = await Issue.searchRepositories();
    apiList = await Issue.getIssueListAPI();//APIデータ入れ込み
  }

  @override
  void initState() {
    //アプリ起動時に一度だけ実行する
    super.initState();
    setState(() {
      getAPI();
    });

  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();

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