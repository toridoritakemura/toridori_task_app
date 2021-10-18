import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:toridori_task_app/ViewModel/my_value_notifier.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<MyValueNotifier>();
    return  /// review: このInkっているのかな？単純な疑問
      //右上ボタン
      Ink(
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(),
        ),
        child: IconButton(
          // 表示アイコン
          icon: const Icon(Icons.dehaze_sharp),
          // アイコン色
          color: Colors.black,
          onPressed: () {
            notifier.switchFilter();
          },
        ),
      );
  }
}
