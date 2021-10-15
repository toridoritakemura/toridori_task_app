import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toridori_task_app/Model/issue_model.dart';
import 'package:toridori_task_app/Model/filter_model.dart';
import 'package:toridori_task_app/Model/my_value_notifier.dart';

import 'package:toridori_task_app/View/issue_page.dart';


//todo review: おすすめしておいて申し訳ないのですが、StatefulWidgetは基本的には使わない方針で行った方がいいです！
/// いくつか理由があるのですが、シンプルにいうと、viewにmodelにあるべきデータが溜まるから/setState呼ぶ必要ある/modelと分割できないから という感じです！
///
/// この辺を参考にproviderとfreezedを導入してください！
/// https://note.com/mukae9/n/n91b3301ebccf

//todo review: fileのメインとなるclassの名前はfile名と合わせましょう！
///全体ページ
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

  //todo review: global変数は避けましょう！
/// これはwidgetの中、フィールド変数にしていいと思います。globalにあるよりかよいです！
const List<Tab> tabs = <Tab>[
  Tab(
    text: '全て',
  ),
  Tab(
    text: 'p: webview',
  ),
  Tab(
    text: 'p: shared_preferences',
  ),
  Tab(
    text: 'waiting for customer response',
  ),
  Tab(
    text: 'severe: new feature',
  ),
  Tab(
    text: 'p: share',
  ),
];

///todo  review: global変数は避けましょう！
/// 避けましょう!AllIssuePageに渡すタイミングで都度インスタンス化していいと思います！
ApiArgument url = ApiArgument(
    label: '',
    state: "all",
    since: '2001-10-16 15:54:34.467953',
    sort: 'created');

///todo  review: global変数は避けましょう！
/// 利用箇所が限られており、使用回数も少ないので"now"という変数名よりDateTime.now()という関数呼び出しの方がむしろわかりやすいと思います
/// 人の判断に寄るので決まりはなく、肌感なので慣れていきましょう！
/// 10行程下のやつ、final yearAgo = DateTime.now().add(const Duration(days: 365) * -1); でいいのではという話
DateTime now = DateTime.now();

class _HomePageState extends State<HomePage> {
  ///todo review: globalな関数は避けた方がいいので追加しました
  final issueRepository = IssueRepository();

  /// --------------------------------------------------------------------------------------
  /// review: Providerを導入したら、
  /// 上の区切りで挟んだ関数・変数たちはStateNotifierのclassに移動させましょう！
  /// viewとmodelにアーキテクチャを意識して分けていてとてもいいです！
  /// 次のレベルとして、それぞれの役割を意識してみましょう！
  /// modelの役割は下記です
  ///   - viewの状態を表すデータを持ちます.viewにこれらを持たせると再利用しにくかったり、それぞれのテストがしにくい。viewをピュアなviewに保てないので変更がしにくいなどがあげられます
  ///   - widgetを操作したときに行う処置が書かれます。api呼び出しなんかもそっちで行いましょう！
  ///   - データの変換(DateTimeをStringに変更したり)もmodelで！view複雑な処理は描画の妨げになり、表示が遅いなどの弊害が起こります
  ///
  /// viewはできるだけwidgetとmodelを持つだけ、という感じにシンプルにする方針で行くといい感じになりそうです！
  ///
  /// review: ネーミングはわかりやすいものを！
  ///todo isRemoveClosedとか、filterClosedみたいな？変数名が増えてくると名前だけでその変数に何が入っているか把握したいので今から意識してみてください！
  bool isRemoveClosed = false; //Close状態のIssueを除外するチェックボックス
  bool isRemoveUpdateYear = false; //一年以上の更新しないIssueを除外するチェックボックス
  int changeSort = 1; //3つのRadio

  DateTime yearAgo = now.add(const Duration(days: 365) * -1); //一年前
  DateTime longAgo = now.add(const Duration(days: 365) * -20);

  bool isVisible = false; //絞り込みボタンON/OFF



  ///Close状態のIssueを除外する機能
  void getState() {
    if (isRemoveClosed == false) {
      url.state = 'all';
    } else if (isRemoveClosed == true) {
      url.state = 'open';
    }
    issueRepository.fetchLabelsIssue('', url.state, url.since, url.sort);
  }

  ///一年以上の更新しないIssueを除外する機能
  void getSince() {
    if (isRemoveUpdateYear == false) {
      url.since = longAgo.toString();
    } else if (isRemoveUpdateYear == true) {
      url.since = yearAgo.toString();
    }
    issueRepository.fetchLabelsIssue('', url.state, url.since, url.sort);
  }

  ///一年以上の更新しないIssueを除外する機能
  void getSort() {
    ///作成日時の新しい順
    if (changeSort == 1) {
      url.sort = 'created';
    }

    ///更新日時の古い順
    else if (changeSort == 2) {
      url.sort = 'updated-asc';
    }

    ///コメントの多い順
    else if (changeSort == 3) {
      url.sort = 'comments';
    }
    issueRepository.fetchLabelsIssue('', url.state, url.since, url.sort);
  }

  void getLabel() {
    ///作成日時の新しい順
    if (changeSort == 1) {
      url.sort = 'created';
    }

    ///更新日時の古い順
    else if (changeSort == 2) {
      url.sort = 'updated-asc';
    }

    ///コメントの多い順
    else if (changeSort == 3) {
      url.sort = 'comments';
    }
    issueRepository.fetchLabelsIssue('', url.state, url.since, url.sort);
  }

  /// --------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length, //タブの数
      child: Stack(
        children: [
          /// review: Providerを導入したら、
          /// 巨大なbuild関数を避けましょう！
          /// StatefulWidgetの弊害なのですが、widgetを複数に分けづらいと思います。
          /// このfileの一番下にProviderを入れたらこんな風に分割したらいいと思うよ！というのを書いておきます。よければ参考にしてください。
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              flexibleSpace: SafeArea(
                /// review: tabbarの横においているiconが重なってしまっている
                /// アイコン横に置けていい感じですね！
                /// ただ、最後のタブを表示したとき重なってしまっています。下記は修正の一例です！参考にしてください
                child: Row(
                  children: [
                    /// tabbar
                    Expanded(
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
                          tabs: tabs,
                          onTap: (index) {
                            if (index == 0) {
                              url.label = '';
                            } else if (index == 1) {
                              url.label = 'p: webview';
                            } else if (index == 2) {
                              url.label = 'p: shared_preferences';
                            } else if (index == 3) {
                              url.label = 'waiting for customer response';
                            } else if (index == 4) {
                              url.label = 'severe: new feature';
                            } else if (index == 5) {
                              url.label = 'p: share';
                            } else {
                              url.label = '';
                            }

                            setState(() {});
                          }),
                    ),

                    /// review: このInkっているのかな？単純な疑問
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
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: const Center(
              child: TabBarView(

                  ///各内容のタブ
                  children: [
                    AllIssuePage(), //全て
                    AllIssuePage(), //p: webview
                    AllIssuePage(), //p: shared_preferences
                    AllIssuePage(), //waiting for customer response
                    AllIssuePage(), //severe: new feature
                    AllIssuePage(), //p: share
                  ]),
            ),
          ),
          Visibility(
            //表示ON/OFF
            visible: isVisible,
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
                                    value: isRemoveClosed,
                                    onChanged: (e) {
                                      isRemoveClosed = !isRemoveClosed;
                                      setState(() {});
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
                                    value: isRemoveUpdateYear,
                                    onChanged: (e) {
                                      setState(() {
                                        isRemoveUpdateYear = !isRemoveUpdateYear;
                                      });
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
                                    groupValue: changeSort,
                                    onChanged: (value) {
                                      setState(() {
                                        changeSort = 1;
                                      });
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
                                    groupValue: changeSort,
                                    onChanged: (value) {
                                      setState(() {
                                        changeSort = 2;
                                      });
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
                                    groupValue: changeSort,
                                    onChanged: (e) {
                                      setState(() {
                                        changeSort = 3;
                                      });
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
                              onPressed: () {
                                setState(() {
                                  getState();
                                  getSince();
                                  getSort();
                                  isVisible = !isVisible;
                                });
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
          ),
        ],
      ),
    );
  }
}

/// review: 参考
/// Provider入れていないので操作してもUIに変更は起こりません
class HomeScreen extends StatelessWidget {
  const HomeScreen();

  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Scaffold(
          body: _Body(),
        ),
        _Dialog(),
      ],
    );
  }
}

/// 別ファイルに分ける
class _Dialog extends StatelessWidget {
  const _Dialog();

  Widget build(BuildContext context) {
    return const Center(
      child: Text('title!!!'),
    );
  }
}

/// 別ファイルに分ける
class _Body extends StatelessWidget {
  const _Body();

  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('Body'),
      ],
    );
  }
}


class CountData extends ChangeNotifier{
  int count = 0;

  void increment() {
    count = count + 1;
    // 値が変更したことを知らせる
    //  >> UIを再構築する
    notifyListeners();
  }
}

class ParentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider<T>() で子Widgetにデータを渡す
    // ※ 渡すデータの クラス と <T> は揃えましょう
    return ChangeNotifierProvider<CountData>(
      // 渡すデータ
      create: (context) => CountData(),
      child: Container(
        child: ChildWidget(),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider.of<T>(context) で親Widgetからデータを受け取る
    // ※ 受け取るデータの クラス と <T> は揃えましょう
    final CountData data = Provider.of<CountData>(context);

    return Column(
      children: <Widget>[
        // 受け取ったデータを使いUI作成
        Text('count is ${data.count.toString()}'),
        ElevatedButton(
          child: Text('Increment'),
          onPressed: () {
            // データを更新
            data.increment();
          },
        ),
      ],
    );
  }
}