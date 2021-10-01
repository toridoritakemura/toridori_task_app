

import 'package:flutter/material.dart';
import 'package:toridori_task_app/Model/issue_model.dart';
import 'package:toridori_task_app/Model/label_model.dart';



class IssueListPage extends StatefulWidget {
  const IssueListPage({ Key? key }) : super(key: key);
  @override
  _IssueListPage createState() => _IssueListPage();
}


///label　呼び出し
Future getLabelList() async{
  labelsList =  await getLabelAPI();

}
///IssueListページ
class _IssueListPage extends  State<IssueListPage>{

  late Future <List<Issue>> futureListIssue;

  @override
  void initState() {
    super.initState();
    futureListIssue = fetchListIssue();
  }


  @override
  Widget build(BuildContext context) {

    return Center(
      child: FutureBuilder <List<Issue>>(
          future: futureListIssue,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Issue> issues = snapshot.data;
              return Center(
                child: ListView.builder(
                  itemCount: issues.length,
                  itemBuilder: (context, index) {
                    return Padding(
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
                                      Text(issues[index].number.toString()),
                                      const Icon(Icons.comment),
                                      Text(issues[index].comments.toString()),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:FutureBuilder(
                                            future: getLabelAPI(),
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
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.info_outline,
                                        color: Colors.green,
                                        size: 30,
                                      ),

                                      Flexible(
                                        child: Text(issues[index].title ?? 'ー',
                                          style:
                                          const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.fade,
                                          maxLines: 3,

                                        ),
                                      ),
                                    ],
                                  ),

                                  DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent.withOpacity(0.3),
                                      ),
                                      child: Text(issues[index].body ?? '-',
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
                                        Text(issues[index].since ?? ''),
                                        const Spacer(),
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(color: Colors.black45,),
                                          ),
                                          child: const Text(
                                            'view full issue',
                                            style: TextStyle(
                                              color: Colors.black45,
                                            ),
                                          ),
                                          onPressed: (){


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
                    );
              },
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
      ),
    );
  }
}