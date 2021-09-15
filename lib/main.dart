import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<String> titleList = ["amazon"," 楽天","Yhoo"];

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

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
            indicatorColor: Colors.blue,//インディケーターの色
            indicatorWeight: 3.0,//インディケーターの太さ
            ///タブに表示する内容
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
