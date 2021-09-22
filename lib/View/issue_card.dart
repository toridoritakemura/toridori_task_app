import 'package:flutter/material.dart';
import 'package:toridori_task_app/Model/model.dart';

//providor freez

class IssuePage extends StatefulWidget {
  const IssuePage({ Key? key }) : super(key: key);
  @override
  _IssuePage createState() => _IssuePage();
}

List<Issue> issueList = [
  Issue(number: 1, comments: 0, title: 'タイトル1', body: '質問1', since: '時刻'),
  Issue(number: 1, comments: 0, title: 'タイトル1', body: '質問1', since: '時刻'),
];

Issue issue = Issue(number: 0, comments: 0, title: 'タ˚イトル', body: '質問', since: '時刻');


///Issueリスト
class _IssuePage extends  State<IssuePage>{
  List<Issue> issueList = [
    Issue(number: 1, comments: 0, title: 'タイトル1', body: '質問1', since: '時刻1'),
    Issue(number: 2, comments: 1, title: 'タイトル2', body: '質問2', since: '時刻2'),
  ];

  @override
  Widget build(BuildContext context) {

    return Center(

        child:
            SingleChildScrollView(
              child: Column(
                children: issueList.map((item) {
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
                                    Text(item.number.toString()),
                                    const Icon(Icons.comment),
                                    Text(item.comments.toString()),
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
                                      child: Text(item.title ?? 'ー',
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
                                    child: Text(item.body ?? '-',
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
                                      Text(item.since ?? ''),
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
                                        onPressed: ()  async{
                                          issueList = await Issue.getIssueListAPI();

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

                }).toList(),


              ),

            ),


    );

  }
}

class OneIssue extends StatefulWidget {

  const OneIssue({ Key? key }) : super(key: key);
  @override
  _OneIssue createState() => _OneIssue();

}


class _OneIssue extends State<OneIssue> {
  
  @override
  Widget build(BuildContext context) {
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
                        issue = await Issue.searchRepositories();

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

  }

}



