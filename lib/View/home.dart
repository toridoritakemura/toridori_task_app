import 'package:flutter/material.dart';

import 'package:toridori_task_app/View/one_issue_card.dart';
import 'package:toridori_task_app/View/all_issue_page.dart';
import 'package:toridori_task_app/View/severe_page.dart';
import 'package:toridori_task_app/View/shared_page.dart';
import 'package:toridori_task_app/View/waiting_page.dart';
import 'package:toridori_task_app/View/webview_page.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

///タブリスト
const List<Tab> tabs = <Tab>[
  Tab(text: '全て',),
  Tab(text: 'p: webview',),
  Tab(text: 'p: shared_preferences',),
  Tab(text: 'waiting for customer response',),
  Tab(text: 'severe: new feature',),
  Tab(text: 'p: share',),
];



///全体ページ
class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length, //タブの数
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: TabBar(

              ///タブオプション
              isScrollable: true,
              //スクロール
              unselectedLabelColor: Colors.black.withOpacity(0.3),
              //選択されてないタブの色
              unselectedLabelStyle: const TextStyle(fontSize: 12.0),
              //選択されていないタブのフォントサイズ
              labelColor: Colors.black,
              //タブの文字の色
              labelStyle: const TextStyle(fontSize: 16.0),
              //選択されているフォントサイズ
              indicatorColor: Colors.blue,
              //インディケーターの色
              indicatorWeight: 3.0,
              //インディケーターの太さ
              ///タブに表示する内容
              tabs: tabs,
            ),
          ),
          actions: [
            Ink(
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(),
              ),
              child: IconButton(
                // 表示アイコン
                icon: const Icon(Icons.dehaze_sharp),
                // アイコン色
                color: Colors.black,
                onPressed: () {},
              ),
            )
          ],

        ),
        body: const Center(
          child: TabBarView(

            ///各内容のタブ
              children: [
                AllIssuePage(), //全て
                WebViewPage(), //p: webview
                WaitingPage(), //p: shared_preferences
                WaitingPage(), //waiting for customer response
                SeverePage(), //severe: new feature
                SharedPage(), //p: share
              ]
          ),
        ),
      ),
    );
  }


}