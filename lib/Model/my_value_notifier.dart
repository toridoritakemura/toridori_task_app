import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_notifier/state_notifier.dart';


part 'my_value_notifier.freezed.dart';

@freezed //freezedを生成させるための場所
abstract class MyValueState
    with _$MyValueState {
  const factory MyValueState({
    @Default(0) int count, //状態管理されている実際の値
  }) = _MyValueState;
}

class MyValueNotifier extends StateNotifier<MyValueState> with LocatorMixin {
  MyValueNotifier({
    required this.context,
  }) : super(const MyValueState());

  final BuildContext context;

  @override
  void dispose() {

    super.dispose();
  }

  @override
  void initState() {}
}

