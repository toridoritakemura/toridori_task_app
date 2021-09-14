import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Widget'),
          bottom: const TabBar(
            tabs: <Widget>[
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

            
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text(""),
            ),
            Center(
              child: Text(""),
            ),
            Center(
              child: Text(""),
            ),
            Center(
              child: Text(""),
            ),
            Center(
              child: Text(""),
            ),
            Center(
              child: Text(""),
            ),
          ],
        ),
      ),
    );
  }
}



//todo gitと連携する
//todo Tabを6つ作る
