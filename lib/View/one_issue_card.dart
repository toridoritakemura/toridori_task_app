import 'package:flutter/material.dart';
import 'package:toridori_task_app/Model/issue_model.dart';
import 'package:toridori_task_app/Model/label_model.dart';



///一個分のIssueページ
class OneIssuePage extends StatefulWidget {
  const OneIssuePage({ Key? key }) : super(key: key);

  @override
  _OneIssuePage createState() => _OneIssuePage();
}


///一個分のIsuueAPI呼び出し
Future getOneAPI() async{
  issue =  await searchRepositories();
}



class _OneIssuePage extends State<OneIssuePage> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getOneAPI(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
                            Text(issue.number.toString()),
                            const Icon(Icons.comment),
                            Text(issue.comments.toString()),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border: Border.all(color: Colors.blue),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(labelList[0].name ?? '',
                                    style: const TextStyle(

                                    ),
                                  ),
                                ),
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
                              child: Text(issue.title ?? 'ー',
                                style:
                                const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),

                        DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.3),
                            ),
                            child: Text(issue.body ?? '-',
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
                              Text(issue.since ?? ''),
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
        } else {
          return const Center(child: CircularProgressIndicator());
        }

      }
    );

  }
}



