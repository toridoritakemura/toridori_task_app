import 'package:flutter/material.dart';
import 'package:toridori_task_app/Model/model.dart';
import 'package:toridori_task_app/main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final issue = Issue('0000', '0', 'タイトル', '質問', '時刻');
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

///Issue一個分
class IssuePage extends StatelessWidget{
  final issue = Issue('0000', '0', 'タイトル', '質問', '時刻');
  List<Issue> issueList = [
    Issue('0001', '0', 'タイトル1', '質問1', '時刻'),
    Issue('0002', '0', 'タイトル2', '質問2', '時刻'),
    Issue('0003', '0', 'タイトル3', '質問3', '時刻'),
    Issue('0004', '0', 'タイトル4', '質問4', '時刻'),
  ];
  @override
  Widget build(BuildContext context) {

    return Center(
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
      itemCount: 50,
      itemBuilder: (BuildContext context, int index) {
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
                          Text(issue.issue_number),
                          const Icon(Icons.comment),
                          Text(issue.comment),
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
                          child: Text(issue.text)
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            Text(issue.date),
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
                              onPressed: () {},

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
      }),
    );

  }
}

