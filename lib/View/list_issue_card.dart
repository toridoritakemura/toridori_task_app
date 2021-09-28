import 'package:flutter/material.dart';
import 'package:toridori_task_app/Model/issue_model.dart';




///IssueListページ
class IssueListPage extends StatefulWidget {
  const IssueListPage({ Key? key }) : super(key: key);
  @override
  _IssueListPage createState() => _IssueListPage();
}

///ListのIssueAPI呼び出し
Future getListAPI() async{
//  issue =  await Issue.searchRepositories();
  apiList = await getIssueListAPI();//APIデータ入れ込み

}

class _IssueListPage extends  State<IssueListPage>{

  @override
  Widget build(BuildContext context) {

    return Center(
      child: FutureBuilder(
          future: getListAPI(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Column(
                  children: apiList.map((item) {
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
                                          maxLines: 3,

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
                                            apiList = await getIssueListAPI();//APIデータ入れ込み
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
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
      ),
    );
  }
}