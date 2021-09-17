// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'model.dart';
import 'test.dart';
import 'dart:async'; //非同期処理用
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
  GithubClient()._searchRepositories('date').catchError((e)=>print(e));
}

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

///タブリスト
const List<Tab> tabs = <Tab>[
  Tab(text: '全て',),
  Tab(text: 'p: webview',),
  Tab(text: 'p: shared_preferences',),
  Tab(text: 'waiting for customer response',),
  Tab(text: 'severe: new feature',),
  Tab(text: 'p: share',),
];


class MyStatelessWidget extends StatelessWidget {
  final Issue issue = Issue('#0000', '0', 'Title', 'Text', 'Date');

  MyStatelessWidget({Key? key}) : super(key: key);

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
            Center(
              child:
              ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) {
                  return TextPage();
                },
              ),
            ),
            Center(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) {
                  return IssuePage();
                },
              ),
            ),
            Center(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) {
                  return IssuePage();
                },
              ),
            ),
            Center(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) {
                  return IssuePage();
                },
              ),
            ),
            Center(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) {
                  return IssuePage();
                },
              ),
            ),
            Center(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) {
                  return IssuePage();
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

}

Widget _buildCard(GithubRepository repository) {
  return Card(
    margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            repository.fullName,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16.0
            ),
          ),
        ),
        repository.language != null ? Padding(
          padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
          child: Text(
            repository.language,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12.0
            ),
          ),
        ) : Container(),
        repository.description != null ? Padding(
          padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
          child: Text(
              repository.description,
              style: TextStyle(
                  fontWeight: FontWeight.w200,
                  color: Colors.grey
              )
          ),
        ) : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.star),
            SizedBox(
              width: 50.0,
              child: Text(repository.stargazersCount.toString()),
            ),
            Icon(Icons.remove_red_eye),
            SizedBox(
              width: 50.0,
              child: Text(repository.watchersCount.toString()),
            ),
            Text("Fork:"),
            SizedBox(
              width: 50.0,
              child: Text(repository.forksCount.toString()),
            ),
          ],
        ),
        SizedBox(height: 16.0,)
      ],
    )
    ,);
}

///Issue一個分
class IssuePage extends  StatelessWidget {//継承
  IssuePage({Key? key}) : super(key: key);
  final Issue issue = Issue('#0000', '0', 'Title', 'Text', 'Date');
  @override
  Widget build(BuildContext context) {
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
                            onPressed: (){
                            },

                          ),

                        ],
                      ),
                    ),
                  ],
                )
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.green),
            ),

          ),
        ),
      ],
    );
  }
}


///APIコール部分
class GithubClient {
  Future<List<Issue>> _searchRepositories(String searchWord) async {
    print('test');
    final response = await http.get(Uri.parse('https://github.com/flutter/flutter/issues'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<Issue> list = [];
      Map<String, dynamic> decoded = json.decode(response.body);
      for (var item in decoded['items']) {
        list.add(Issue.fromJson(item));
      }
      print(list.length);
      return list;
    } else {
      throw Exception('Fail to search repository');
    }
  }
}

///入力部分
class TextPage extends  StatelessWidget {//継承
  TextPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return Container(
          margin: EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Please enter a search repository name.',
                labelText: "search"
            ),
            onChanged: (inputString) {

            },
          )
      );
    }
  }





/////リスト部分
//class CardPage extends  StatelessWidget {//継承
//  CardPage({Key? key}) : super(key: key);
//  final repository = GithubRepository();
//  @override
//  Widget build(BuildContext context) {
//    return Card(
//      margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Padding(
//            padding: EdgeInsets.all(12.0),
//            child: Text(
//              repository.fullName,
//              style: TextStyle(
//                  fontWeight: FontWeight.bold, fontSize: 16.0
//              ),
//            ),
//          ),
//          repository.language != null ? Padding(
//            padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
//            child: Text(
//              repository.language,
//              style: TextStyle(
//                  fontWeight: FontWeight.bold, fontSize: 12.0
//              ),
//            ),
//          ) : Container(),
//          repository.description != null ? Padding(
//            padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
//            child: Text(
//                repository.description,
//                style: TextStyle(
//                    fontWeight: FontWeight.w200,
//                    color: Colors.grey
//                )
//            ),
//          ) : Container(),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              Icon(Icons.star),
//              SizedBox(
//                width: 50.0,
//                child: Text(repository.stargazersCount.toString()),
//              ),
//              Icon(Icons.remove_red_eye),
//              SizedBox(
//                width: 50.0,
//                child: Text(repository.watchersCount.toString()),
//              ),
//              Text("Fork:"),
//              SizedBox(
//                width: 50.0,
//                child: Text(repository.forksCount.toString()),
//              ),
//            ],
//          ),
//          SizedBox(height: 16.0,)
//        ],
//      )
//      ,);
//  }
//
//}



//todo gitと連携する
//todo Tabを6つ作る
//todo Tabbarの作成
//todo Dart Analysis のエラー解消

//APi通信　Httpリクエスト

// ? スクロールできるTabBarとアイコンボタンの並列配置
// ? クラスの引継ぎ方がわからない

//ウィジェットは変数にしない
//StaelessWidgetの変数にはfinalをつける。