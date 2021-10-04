

import 'package:flutter/material.dart';
import 'package:toridori_task_app/Model/issue_model.dart';
import 'package:toridori_task_app/Model/label_model.dart';



List<Labels> labelsList = [
  Labels(labels: [LabelName(name: 'label1-1'), LabelName(name: 'label1-2'),],),
  Labels(labels: [LabelName(name: 'label2-1'), LabelName(name: 'label2-2'),],),

];


class OneIssuePage extends StatefulWidget {
  const OneIssuePage({ Key? key }) : super(key: key);

  @override
  _OneIssuePage createState() => _OneIssuePage();
}

///一個分のIssueページ
class _OneIssuePage extends State<OneIssuePage> {
  late Future<Issue> futureOneIssue;
  late Future<List<LabelName>> futureOneLabel;
  late Future<List<Labels>> futureListLabel;

  @override
  void initState() {
    super.initState();
    futureOneIssue = fetchOneIssue();
    futureOneLabel = fetchOneLabels();
    futureListLabel = fetchListLabels();
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
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  const Text('No'),
                                  Text(snapshot.data.number.toString()),
                                  const Icon(Icons.comment),
                                  Text(snapshot.data.comments.toString()),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                  child:FutureBuilder(
                                      future: futureOneLabel,
                                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          List<LabelName> labels = snapshot.data;
                                          return  Row(
                                            children: labels.map((item) {
                                              return Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .all(3.0),
                                                    child: Text(item.name ?? '',
                                                      style: const TextStyle(
                                                          backgroundColor: Colors.blue
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      }
                                    ),
                                  ),

                                ],),
                            ),
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

                                      fetchListLabels();
//                                      futureOneLabel = fetchOneLabels();


                                      setState(() {

                                      });

                                    },
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:FutureBuilder(
                                        future: futureOneLabel,
                                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                                          if (snapshot.connectionState == ConnectionState.done) {
                                            List<LabelName> labels = snapshot.data;
                                            return  Row(
                                              children: labels.map((item) {
                                                return Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(3.0),
                                                      child: Text(item.name ?? '',
                                                        style: const TextStyle(
                                                            backgroundColor: Colors.blue
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }).toList(),
                                            );
                                          } else {
                                            return const CircularProgressIndicator();
                                          }
                                        }
                                    ),
                                  ),

                                ],),
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






