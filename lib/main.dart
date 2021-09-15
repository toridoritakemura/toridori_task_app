import 'package:flutter/material.dart';
import 'model.dart';

void main() {

  runApp(const MyApp());
}
Issue issue = Issue('#0000', '', '', '', '');


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
              child: Column(
                children: [
                  Text("全てのIssueを表示する"),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: issueContainer(),
                  ),
                ],
              ),
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

  ///issue一個分
  Container issueContainer() {
    return Container(
                    child: Container(
                      alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('No'),
                                Text(issue.code),
                                Icon(Icons.comment),
                                Text(issue.coment),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.info),
                                Text(issue.code),
                              ],
                            ),

                            Text('質問文'),
                            Text('投稿時間'),
                          ],
                        )
                    ),
                    width: double.infinity,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    border: Border.all(color: Colors.green),
                  ),

                  );
  }
}



//todo gitと連携する
//todo Tabを6つ作る
//todo Tabbarの作成

// ? スクロールできるTabBarとアイコンボタンの並列配置
// ? クラスの引継ぎ方がわからない