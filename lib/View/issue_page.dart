
import 'package:flutter/material.dart';
import 'package:toridori_task_app/Model/issue_model.dart';

import 'home.dart';




class AllIssuePage extends StatefulWidget {
  const AllIssuePage({ Key? key }) : super(key: key);
  @override
  _IssueListPage createState() => _IssueListPage();
}


///IssueListページ
class _IssueListPage extends  State<AllIssuePage>{
  late Future <List<Issue>> futureListIssue;

  @override
  void initState() {
    super.initState();
    futureListIssue = fetchLabelsIssue(url.label,url.state,url.since,url.sort);
  }


  @override
  Widget build(BuildContext context) {

    return Center(
      child: FutureBuilder <List<Issue>>(
          future: futureListIssue,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Issue> issues = snapshot.data;
              return ListView.builder(
                  itemCount: issues.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text('No'),
                                      Text(issues[index].number.toString()),
                                      const Icon(Icons.comment),
                                      Text(issues[index].comments.toString()),
//                                      Text(issues[index].state ?? 'state'),
//                                      Text(issues[index].updated ?? 'updated'),


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
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,

                                      )
                                  ),

                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Row(
                                      children: [
                                        Text(issues[index].updatedAt ?? 'エラー'),
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
                    );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
      ),
    );
  }
}