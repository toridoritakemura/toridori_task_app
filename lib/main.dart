import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyStatelessWidget(),
    );
  }
}

const List<Tab> tabs = <Tab>[
  Tab(text: '全て',),
  Tab(text: 'p: webview',),
  Tab(text: 'p: shared_preferences',),
  Tab(text: 'waiting for customer response',),
  Tab(text: 'severe: new feature',),
  Tab(text: 'p: share',),
];


class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: tabs.length,//タブの数
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            ///タブオプション
            isScrollable: true,//スクロール
            unselectedLabelColor: Colors.black.withOpacity(0.3),//選択されてないタブの色
            unselectedLabelStyle: TextStyle(fontSize: 12.0),//選択されていないタブのフォントサイズ
            labelColor: Colors.black,//タブの文字の色
            labelStyle: TextStyle(fontSize: 16.0),//選択されているフォントサイズ
            indicatorColor: Colors.blue,//インディケーターの色
            indicatorWeight: 3.0,//インディケーターの太さ

            ///タブに表示する内容
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          ///各内容のタブ
          children: <Widget>[
            Center(
              child: Text("全てのIssueを表示する"),
            ),
            Center(
              child: Text("p: webviewラベルの付いたIssueを表示する"),
            ),
            Center(
              child: Text("p: shared_preferencesラベルの付いたIssueを表示する"),
            ),
            Center(
              child: Text("waiting for customer responseラベルの付いたIssueを表示する"),
            ),
            Center(
              child: Text("severe: new featureラベルの付いたIssueを表示する"),
            ),
            Center(
              child: Text("severe: new featureラベルの付いたIssueを表示する"),
            ),
          ],
        ),
      ),
    );
  }
}



//todo gitと連携する
//todo Tabを6つ作る
// ? スクロールできるTabBarとアイコンボタンの並列配置