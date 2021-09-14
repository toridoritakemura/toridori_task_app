import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 6,//タブの数
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
            indicatorColor: Colors.blue,
            indicatorWeight: 3.0,


            tabs: <Widget>[
              Tab(
                text: '全て',
              ),
              Tab(
                text: 'p: webview',
              ),
              Tab(
                text: 'p: shared_preferences',
              ),
              Tab(
                text: 'waiting for customer response',
              ),
              Tab(
                text: 'severe: new feature',
              ),
              Tab(
                text: 'p: share',
              ),



            ],
          ),
        ),
        body: const TabBarView(
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
