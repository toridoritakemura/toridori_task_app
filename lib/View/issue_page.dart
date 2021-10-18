import 'package:flutter/material.dart';

// ignore: implementation_imports
import 'package:provider/src/provider.dart';

import 'package:toridori_task_app/Model/my_value_notifier.dart';

///todo review: fileのメインとなるclassの名前はfile名と合わせましょう！

///IssueListページ
class IssuePage extends StatelessWidget {
  const IssuePage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Center(
      ///todo review: FutureBuilderは避けましょう！
      ///todo tabを横に移動させたらわかると思うのですが、一度読み込んだtabも再度表示するためにapiを叩いています。
      ///todo Providerとfreezedで綺麗に解決することができるので頑張ってください！
      ///todo https://note.com/mukae9/n/n91b3301ebccf
      child: Builder(builder: (context) {
        final isIssues = context.select((MyValueState state) => state.isIssues);
        final isLoading = context.select((MyValueState state) => state.isLoading);
        if (isLoading == false){
          return Builder(
            builder: (context) {
              return ListView.builder(
                itemCount: isIssues.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text('No'),
                              Text(isIssues[index].number.toString()),
                              const Icon(Icons.comment),
                              Text(isIssues[index].comments.toString()),
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
                                child: Text(
                                  isIssues[index].title ?? 'ー',
                                  style: const TextStyle(
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
                              child: Text(
                                isIssues[index].body ?? '-',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              )),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Text(isIssues[index].updatedAt ?? 'エラー'),
                                const Spacer(),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Colors.black45,
                                    ),
                                  ),
                                  child: const Text(
                                    'view full issue',
                                    style: TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                                  onPressed: () {},
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
            }
          );
        }else if (isLoading== true){
          return const CircularProgressIndicator();
        }
        else {
          return const Text('error');
        }

      }),
    );
  }
}
