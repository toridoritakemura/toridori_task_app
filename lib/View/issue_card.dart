import 'package:flutter/material.dart';
import 'package:toridori_task_app/Model/model.dart';

class IssuePage extends StatefulWidget {
  @override
  _IssuePage createState() => _IssuePage();



}

///Issueリスト
class _IssuePage extends  State<IssuePage>{
  List<Issue> issueList = [
    Issue(number: 1, comments: 0, title: 'タイトル1', body: '質問1', since: '時刻'),
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
                                    onPressed: ()  async{

                                      setState(() {
                                        Issue.searchRepositories();
                                      });

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

class OneIssue extends StatefulWidget {
  @override
  _OneIssue createState() => _OneIssue();





}

class _OneIssue extends State<OneIssue> {
  Issue issue = Issue(number: 0, comments: 0, title: 'タイトル', body: '質問', since: '時刻');
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
                      Text(issue == null ? '-':issue.number.toString()),
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
                      Text(issue == null ? '-':issue.title),
                    ],
                  ),

                  DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.3),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Text(issue == null ? '-':issue.body)
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Text(issue == null ? '-':issue.since),
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

