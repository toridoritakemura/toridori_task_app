import 'package:flutter/material.dart';
import 'package:toridori_task_app/Model/model.dart';
import 'package:toridori_task_app/main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


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
            IssuePage(),
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

///Issueリスト
class IssuePage extends StatelessWidget{
  List<Issue> issueList = [
    Issue(number: 1, comments: 0, title: 'タイトル1', body: '質問1', since: '時刻'),
    Issue(number: 2, comments: 1, title: 'タイトル2', body: '質問2', since: '時刻'),
    Issue(number: 3, comments: 2, title: 'タイトル3', body: '質問3', since: '時刻'),
    Issue(number: 4, comments: 3, title: 'タイトル4', body: '質問4', since: '時刻'),
    Issue(number: 5, comments: 4, title: 'タイトル5', body: '質問5', since: '時刻'),
    Issue(number: 6, comments: 5, title: 'タイトル6', body: '質問6', since: '時刻'),
  ];

  @override
  Widget build(BuildContext context) {

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: issueList.map((issue) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DecoratedBox(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            const Text('No'),
                            Text(issue.number.toString()),
                            const Icon(Icons.comment),
                            Text(issue.comments.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Colors.green,
                            ),
                            Text(issue.title),
                          ],
                        ),

                        DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.3),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Text(issue.body)
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              Text(issue.since),
                              const Spacer(),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.black45,),
                                ),
                                child: const Text(
                                  'view full isue',
                                  style: TextStyle(
                                    color: Colors.black45,
                                  ),
                                ),
                                onPressed: () {
                                  Issue.searchRepositories();


                                },

                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.green),
                  ),

                ),
              ),
            ],
          );
          }).toList(),
        ),
      )
    );
  }
}

