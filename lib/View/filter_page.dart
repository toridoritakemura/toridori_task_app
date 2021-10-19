import 'package:flutter/material.dart';

// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:toridori_task_app/ViewModel/my_value_notifier.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<MyValueNotifier>();
    return Builder(builder: (context) {
      final isFilter = context.select((MyValueState state) => state.isFilter);
      final isState = context.select((MyValueState state) => state.isState);
      final isSince = context.select((MyValueState state) => state.isSince);
      final isSort = context.select((MyValueState state) => state.isSort);

      return Visibility(
        //表示ON/OFF
        visible: isFilter,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black12.withOpacity(0.3),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: AspectRatio(
                aspectRatio: 1 / 2,
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25,
                          right: 15,
                          bottom: 5,
                          left: 15,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Checkbox(
                                activeColor: Colors.blue,
                                value: isState,
                                onChanged: (e) {
                                  notifier.switchState();
                                },
                              ),
                            ),
                            const Flexible(
                              child: Text(
                                'Closed状態のIssueを除外する',
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Checkbox(
                                activeColor: Colors.blue,
                                value: isSince,
                                onChanged: (e) {
                                  notifier.switchSince();
                                },
                              ),
                            ),
                            const Flexible(
                              child: Text(
                                '1年以上更新のないIssueを除外する',
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Radio(
                                activeColor: Colors.blue,
                                value: 1,
                                groupValue: isSort,
                                onChanged: (value) {
                                  notifier.switchSort(value);
                                },
                              ),
                            ),
                            const Flexible(
                              child: Text(
                                '作成日時の新しい順',
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Radio(
                                activeColor: Colors.blue,
                                value: 2,
                                groupValue: isSort,
                                onChanged: (value) {
                                  notifier.switchSort(value);
                                },
                              ),
                            ),
                            const Flexible(
                              child: Text(
                                '更新日時の古い順',
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Radio(
                                activeColor: Colors.blue,
                                value: 3,
                                groupValue: isSort,
                                onChanged: (value) {
                                  notifier.switchSort(value);
                                },
                              ),
                            ),
                            const Flexible(
                              child: Text(
                                'コメント数の多い順',
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          child: Row(
                            children: const [
                              Spacer(),
                              Text('更新する'),
                              Spacer(),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white60,
                            onPrimary: Colors.black,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: ()  {
                            notifier.getState();
                            notifier.getSince();
                            notifier.getSort();
                            notifier.switchFilter();

                            notifier.getIssues();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
