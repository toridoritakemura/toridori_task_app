import 'package:flutter/material.dart';

// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:toridori_task_app/ViewModel/my_value_notifier.dart';

class TabsBar extends StatelessWidget with PreferredSizeWidget {
  const TabsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<MyValueNotifier>();

    /// TabBar
    return Expanded(
      child: TabBar(
          //タブオプション
          isScrollable: true,
          //スクロール
          unselectedLabelColor: Colors.black.withOpacity(0.3),
          //選択されてないタブの色
          unselectedLabelStyle: const TextStyle(fontSize: 12.0),
          //選択されていないタブのフォントサイズ
          labelColor: Colors.black,
          //タブの文字の色
          labelStyle: const TextStyle(fontSize: 16.0),
          //選択されているフォントサイズ
          indicatorColor: Colors.blue,
          //インディケーターの色
          indicatorWeight: 3.0,
          //インディケーターの太さ
          ///タブに表示する内容
          tabs: MyValueNotifier.tabs,

          onTap: (index) {
            notifier.getLabel(index);
            notifier.getIssues();
          }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}