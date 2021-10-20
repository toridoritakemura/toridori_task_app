import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:toridori_task_app/Model/issue_model.dart';

import '../Model/filter_model.dart';

part 'my_value_notifier.freezed.dart';

@freezed //freezedを生成させるための場所
class MyValueState with _$MyValueState {
  const factory MyValueState({
    @Default(0) int count, //状態管理されている実際の値
    @Default(0) int tabIndex,
    @Default(false) bool isLoading, //処理中のUI
    @Default(false) bool isFilter, //絞り込みボタンON/OFF
    @Default(false) bool isState, //Close状態のIssueを除外するチェックボックス
    @Default(false) bool isSince, //一年以上の更新しないIssueを除外するチェックボックス
    @Default(1) int isSort, //3つのRadio
    @Default([]) List<Issue> isIssues,
  }) = _MyValueState;
//  flutter pub run build_runner build --delete-conflicting-outputs
}

class MyValueNotifier extends StateNotifier<MyValueState> with LocatorMixin {
  MyValueNotifier({
    required this.context,
  }) : super(const MyValueState());
  final BuildContext context;


  ///todo review: globalな関数は避けた方がいいので追加しました
  final issueRepository = IssueRepository();


  ApiArgument url = ApiArgument(
      label: '',
      state: "all",
      since: '2001-10-16 15:54:34.467953',
      sort: 'created');

  static const tabs = <Tab>[
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




  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getIssues();
//    getLabel(index);

  }

  ///Issue更新
  void getIssues() async {
    getLoading();
    final issueRepository = IssueRepository();
    final issueList = await issueRepository.fetchLabelsIssue(
        url.label, url.state, url.since, url.sort);
    state = state.copyWith(isIssues: issueList);
    getLoading();
  }

  ///更新中処理
  void getLoading() async {
    state = state.copyWith(isLoading: !state.isLoading);
  }

  ///Filter切り替え
  void switchFilter() {
    state = state.copyWith(isFilter: !state.isFilter);
  }

  ///State切り替え
  void switchState() {
    state = state.copyWith(isState: !state.isState);
  }

  ///Since切り替え
  void switchSince() {
    state = state.copyWith(isSince: !state.isSince);
  }

  ///Sort切り替え
  void switchSort(value) {
    state = state.copyWith(isSort: value);
  }

  ///label取得
  void getLabel(int index) {
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
  }

  ///Close状態のIssueを除外する機能
  void getState() {
    final issueRepository = IssueRepository();
    if (state.isState == false) {
      url.state = 'all';
    } else if (state.isState == true) {
      url.state = 'open';
    }
    issueRepository.fetchLabelsIssue(url.label, url.state, url.since, url.sort);
  }

  ///一年以上の更新しないIssueを除外する機能
  void getSince() {
    DateTime now = DateTime.now();
    final issueRepository = IssueRepository();
    DateTime yearAgo = now.add(const Duration(days: 365) * -1); //一年前
    DateTime longAgo = now.add(const Duration(days: 365) * -20);
    if (state.isSince == false) {
      url.since = longAgo.toString();
    } else if (state.isSince == true) {
      url.since = yearAgo.toString();
    }
    issueRepository.fetchLabelsIssue(url.label, url.state, url.since, url.sort);
  }

  ///一年以上の更新しないIssueを除外する機能
  void getSort() {
    final issueRepository = IssueRepository();

    ///作成日時の新しい順
    if (state.isSort == 1) {
      url.sort = 'created';
    }

    ///更新日時の古い順
    else if (state.isSort == 2) {
      url.sort = 'updated-asc';
    }

    ///コメントの多い順
    else if (state.isSort == 3) {
      url.sort = 'comments';
    }

  }
}
