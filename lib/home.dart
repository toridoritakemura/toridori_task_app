import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:toridori_task_app/View/AppBar/filter_button.dart';
import 'package:toridori_task_app/View/filter_page.dart';
import 'package:toridori_task_app/View/AppBar/tab_bar.dart';

import 'package:toridori_task_app/ViewModel/my_value_notifier.dart';

import 'package:toridori_task_app/View/Body/issue_page.dart';

//todo review: おすすめしておいて申し訳ないのですが、StatefulWidgetは基本的には使わない方針で行った方がいいです！
///todo  いくつか理由があるのですが、シンプルにいうと、viewにmodelにあるべきデータが溜まるから/setState呼ぶ必要ある/modelと分割できないから という感じです！

///todo この辺を参考にproviderとfreezedを導入してください！
///todo https://note.com/mukae9/n/n91b3301ebccf

//todo review: fileのメインとなるclassの名前はfile名と合わせましょう！
///全体ページ

//todo review: global変数は避けましょう！
///todo これはwidgetの中、フィールド変数にしていいと思います。globalにあるよりかよいです！

///todo  review: global変数は避けましょう！
///todo 避けましょう!AllIssuePageに渡すタイミングで都度インスタンス化していいと思います！

///todo  review: global変数は避けましょう！
///todo 利用箇所が限られており、使用回数も少ないので"now"という変数名よりDateTime.now()という関数呼び出しの方がむしろわかりやすいと思います
///todo 人の判断に寄るので決まりはなく、肌感なので慣れていきましょう！
///todo 10行程下のやつ、final yearAgo = DateTime.now().add(const Duration(days: 365) * -1); でいいのではという話

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Widget wrapped() {
    //wrappedは引数とかでこのページに渡された値をクラス全体で利用できる
    return MultiProvider(
      providers: [
        StateNotifierProvider<MyValueNotifier, MyValueState>(
          //StateNotifierProviderはこれを通してmy_page.dartとmy_page_notifier.dartを連結・状態管理を可能
          create: (context) => MyValueNotifier(
            context: context,
          ),
        )
      ],
      child: const HomePage(),
    );
  }

  ///todo review: globalな関数は避けた方がいいので追加しました

  /// --------------------------------------------------------------------------------------
  ///todo review: Providerを導入したら、
  ///todo 上の区切りで挟んだ関数・変数たちはStateNotifierのclassに移動させましょう！
  /// viewとmodelにアーキテクチャを意識して分けていてとてもいいです！
  /// 次のレベルとして、それぞれの役割を意識してみましょう！
  /// modelの役割は下記です
  ///   - viewの状態を表すデータを持ちます.viewにこれらを持たせると再利用しにくかったり、それぞれのテストがしにくい。viewをピュアなviewに保てないので変更がしにくいなどがあげられます
  ///   - widgetを操作したときに行う処置が書かれます。api呼び出しなんかもそっちで行いましょう！
  ///   - データの変換(DateTimeをStringに変更したり)もmodelで！view複雑な処理は描画の妨げになり、表示が遅いなどの弊害が起こります
  ///
  /// viewはできるだけwidgetとmodelを持つだけ、という感じにシンプルにする方針で行くといい感じになりそうです！
  ///
  ///todo review: ネーミングはわかりやすいものを！
  ///todo isRemoveClosedとか、filterClosedみたいな？変数名が増えてくると名前だけでその変数に何が入っているか把握したいので今から意識してみてください！

  /// --------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<MyValueNotifier>();
    return DefaultTabController(
      initialIndex: 0,
      length: MyValueNotifier.tabs.length, //タブの数
      child: Stack(
        children: [
          ///todo review: Providerを導入したら、
          ///todo 巨大なbuild関数を避けましょう！
          ///todo StatefulWidgetの弊害なのですが、widgetを複数に分けづらいと思います。
          ///todo このfileの一番下にProviderを入れたらこんな風に分割したらいいと思うよ！というのを書いておきます。よければ参考にしてください。
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              flexibleSpace: SafeArea(
                ///todo review: tabbarの横においているiconが重なってしまっているアイコン横に置けていい感じですね！
                ///todo ただ、最後のタブを表示したとき重なってしまっています。下記は修正の一例です！参考にしてください
                child: Row(
                  children: const [
                    TabsBar(), //TabBar
                    FilterButton(), //FilterButton

                  ],
                ),
              ),
            ),
            body: const Center(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),

                  ///各内容のタブ
                  children: [
                    IssuePage(), //全て
                    IssuePage(), //p: webview
                    IssuePage(), //p: shared_preferences
                    IssuePage(), //waiting for customer response
                    IssuePage(), //severe: new feature
                    IssuePage(), //p: share
                  ]),

            ),
          ),
          const FilterPage(),
        ],
      ),
    );
  }
}

///todo review: 参考
///todo Provider入れていないので操作してもUIに変更は起こりません
//class HomeScreen extends StatelessWidget {
//  const HomeScreen();
//
//  Widget build(BuildContext context) {
//    return Stack(
//      children: const [
//        Scaffold(
//          body: _Body(),
//        ),
//        _Dialog(),
//      ],
//    );
//  }
//}
//
///// 別ファイルに分ける
//class _Dialog extends StatelessWidget {
//  const _Dialog();
//
//  Widget build(BuildContext context) {
//    return const Center(
//      child: Text('title!!!'),
//    );
//  }
//}
//
///// 別ファイルに分ける
//class _Body extends StatelessWidget {
//  const _Body();
//
//  Widget build(BuildContext context) {
//    return Column(
//      children: const [
//        Text('View.Body'),
//      ],
//    );
//  }
//}
//
//class CountData extends ChangeNotifier {
//  int count = 0;
//
//  void increment() {
//    count = count + 1;
//    // 値が変更したことを知らせる
//    //  >> UIを再構築する
//    notifyListeners();
//  }
//}
//
//class ParentWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // Provider<T>() で子Widgetにデータを渡す
//    // ※ 渡すデータの クラス と <T> は揃えましょう
//    return ChangeNotifierProvider<CountData>(
//      // 渡すデータ
//      create: (context) => CountData(),
//      child: Container(
//        child: ChildWidget(),
//      ),
//    );
//  }
//}
//
//class ChildWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // Provider.of<T>(context) で親Widgetからデータを受け取る
//    // ※ 受け取るデータの クラス と <T> は揃えましょう
//    final CountData data = Provider.of<CountData>(context);
//
//    return Column(
//      children: <Widget>[
//        // 受け取ったデータを使いUI作成
//        Text('count is ${data.count.toString()}'),
//        ElevatedButton(
//          child: Text('Increment'),
//          onPressed: () {
//            // データを更新
//            data.increment();
//          },
//        ),
//      ],
//    );
//  }
//}
