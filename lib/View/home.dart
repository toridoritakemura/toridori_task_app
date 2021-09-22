import 'package:flutter/material.dart';
import 'package:toridori_task_app/Model/model.dart';
import 'package:toridori_task_app/View/issue_card.dart';
import 'package:toridori_task_app/main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();



}


///全体ページ
class _HomePageState extends State<HomePage> {
  void _getRepository() {


    setState(() async{
      issue = await Issue.searchRepositories();

    });

  }

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
            unselectedLabelStyle: const TextStyle(fontSize: 12.0),//選択されていないタブのフォントサイズ
            labelColor: Colors.black,//タブの文字の色
            labelStyle: const TextStyle(  fontSize: 16.0),//選択されているフォントサイズ
            indicatorColor: Colors.blue,//インディケーターの色
            indicatorWeight: 3.0,//インディケーターの太さ
            ///タブに表示する内容
            tabs: tabs,
          ),
        ),
        body: TabBarView(

          ///各内容のタブ
          children: [
            OneIssue(),
            IssuePage(),
            IssuePage(),
            IssuePage(),
            IssuePage(),
            IssuePage(),


          ],

        ),
      ),
    );
  }
}

