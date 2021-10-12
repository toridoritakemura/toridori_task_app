import 'package:flutter/material.dart';
import 'package:toridori_task_app/Model/issue_model.dart';

class OneIssuePage extends StatefulWidget {
  const OneIssuePage({Key? key}) : super(key: key);

  @override
  _OneIssuePage createState() => _OneIssuePage();
}

///一個分のIssueページ
class _OneIssuePage extends State<OneIssuePage> {
  late Future<Issue> futureOneIssue;

  @override
  void initState() {
    super.initState();
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
                                  ],
                                ),
                              ),
                              Row(children: [
                                const Icon(
                                  Icons.info_outline,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                Flexible(
                                  child: Text(
                                    snapshot.data.title ?? 'ー',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ]),
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent.withOpacity(0.3),
                                  ),
                                  child: Text(
                                    snapshot.data.body ?? '-',
                                    style: const TextStyle(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  )),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  children: [
                                    Text(snapshot.data.updatedAt ?? ''),
                                    const Spacer(),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          color: Colors.black45,
                                        ),
                                      ),
                                      child: const Text(
                                        'view full isue',
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      ),
                                      onPressed: () async {
                                        setState(() {});
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
        });
  }
}
