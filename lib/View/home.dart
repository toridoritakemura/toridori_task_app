import 'package:flutter/material.dart';


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
  bool isVisible = false; //絞り込みボタン

  bool checkBox1 = false;
  bool checkBox2 = false;

  int val = -1;



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length, //タブの数
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              flexibleSpace: SafeArea(
                child: TabBar(
                  ///タブオプション
                  isScrollable: true, //スクロール
                  unselectedLabelColor: Colors.black.withOpacity(0.3), //選択されてないタブの色
                  unselectedLabelStyle: const TextStyle(fontSize: 12.0), //選択されていないタブのフォントサイズ
                  labelColor: Colors.black, //タブの文字の色
                  labelStyle: const TextStyle(fontSize: 16.0), //選択されているフォントサイズ
                  indicatorColor: Colors.blue, //インディケーターの色
                  indicatorWeight: 3.0, //インディケーターの太さ
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
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                  ),
                )
              ],

            ),
            body:  const Center(
              child:
                  TabBarView(
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
          Visibility(
            visible: isVisible,
            child:DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black12.withOpacity(0.3),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: AspectRatio(
                    aspectRatio: 1/2,
                    child: Card(
                      child: Column(
                        children:[
                          Padding(
                            padding: const EdgeInsets.only(top:25,right:15,bottom: 5,left: 15,),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Checkbox(
                                    activeColor: Colors.blue,
                                    value: checkBox1,
                                    onChanged: (e) {
                                      setState(() {
                                        checkBox1 = !checkBox1;
                                      });
                                    },
                                  ),
                                ),

                                const Flexible(
                                  child: Text('Closed状態のIssueを除外する',
                                    overflow: TextOverflow.fade,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                            child: Row(
                              children:   [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Checkbox(
                                    activeColor: Colors.blue,
                                    value: checkBox2,
                                    onChanged: (e) {
                                      setState(() {
                                        checkBox2 = !checkBox2;
                                      });
                                    },
                                  ),
                                ),

                                const Flexible(
                                  child: Text('1年以上更新のないIssueを除外する',
                                    overflow: TextOverflow.fade,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                            child: Row(
                              children:   [

                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Radio(
                                    activeColor: Colors.blue,
                                    value: 1,
                                    groupValue: val,
                                    onChanged:(value) {
                                      setState(() {
                                        val = 1;
                                      });
                                    },
                                  ),
                                ),

                                const Flexible(
                                  child: Text('更新日時の新しい順',
                                    overflow: TextOverflow.fade,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                            child: Row(
                              children:   [

                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Radio(
                                    activeColor: Colors.blue,
                                    value: 2,
                                    groupValue: val,
                                    onChanged: (value) {
                                      setState(() {
                                        val = 2;
                                      });
                                    },
                                  ),
                                ),

                                const Flexible(
                                  child: Text('更新日時の古い順',
                                    overflow: TextOverflow.fade,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                            child: Row(
                              children:   [

                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Radio(
                                    activeColor: Colors.blue,
                                    value: 3,
                                    groupValue: val,
                                    onChanged: (e) {
                                      setState(() {
                                        val = 3;
                                      });
                                    },
                                  ),
                                ),

                                const Flexible(
                                  child: Text('コメント数の多い順',
                                    overflow: TextOverflow.fade,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ElevatedButton(
                              child: Row(
                                children: const [
                                  Spacer(),
                                  Text('更新する'),
                                  Spacer(),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white60,
                                onPrimary: Colors.black,
                                shape: const StadiumBorder(),
                              ),
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

