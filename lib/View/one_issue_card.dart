

import 'package:flutter/material.dart';
import 'package:toridori_task_app/Model/issue_model.dart';
import 'package:toridori_task_app/Model/label_model.dart';





class OneIssuePage extends StatefulWidget {
  const OneIssuePage({ Key? key }) : super(key: key);

  @override
  _OneIssuePage createState() => _OneIssuePage();
}


///Issue（仮）
Issue issue = Issue(number: 0, comments: 0, title: 'タイトル', body: '質問', since: '時刻');


///label　呼び出し
Future getLabel() async{
  labelsList =  await getLabelAPI();

}


///一個分のIssueページ
class _OneIssuePage extends State<OneIssuePage> {
  late Future<Issue> futureOneIssue;

  @override
  void initState() {
    super.initState();
    futureOneIssue = fetchOneIssue();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureOneIssue,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                const Text('No'),
                                Text(snapshot.data.number.toString()),
                                const Icon(Icons.comment),
                                Text(snapshot.data.comments.toString()),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:FutureBuilder(
                                      future: getLabel(),
                                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      return Row(
                                        children: labelsList.map((item) {
                                          return Card(
                                            child: Row(
                                              children: [
                                                DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    border: Border.all(color: Colors.blue),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(3.0),
                                                    child: Text((item.name == 'p: webview' ? item.name : null) ?? '',),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }
                                  ),
                                ),

                              ],),
                            Row(
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  color: Colors.green,
                                  size: 30,
                                ),

                                Flexible(
                                  child: Text(snapshot.data.title ?? 'ー',
                                    style:
                                    const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ]
                            ),

                            DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent.withOpacity(0.3),
                                ),
                                child: Text(snapshot.data.body ?? '-',
                                  style:
                                  const TextStyle(

                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,

                                )
                            ),

                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                children: [
                                  Text(snapshot.data.since ?? ''),
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
                                    onPressed: ()  async{
                                      futureOneIssue = fetchOneIssue();
                                      setState(() {

                                      });

                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }

      }
    );

  }
}






