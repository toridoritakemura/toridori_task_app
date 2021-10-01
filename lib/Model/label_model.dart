
import 'dart:convert';

import 'package:http/http.dart';


List<Label> labelsList = [
  Label(name: 'label1'),
  Label(name: 'label2'),
  Label(name: 'label3'),

];


class Label {
  ///プロパティ
  final String? name;

  ///コンストラクタ
  Label({
    required this.name,

  });

}

///LabelsList一個分APIコール部分
Future<List<Label>> getLabelAPI() async {
  String url = 'https://api.github.com/repos/flutter/flutter/issues/90597';
  try{
    final result = await get(Uri.parse(url));
    final data = jsonDecode(result.body);
    final labelListData = data ;

    final labelList = labelListData.map<Label>((data){
      return Label (
        name: data['name'] ?? 'no label',
      );
    }).toList();

    return labelList;

  }
  catch (e){
    rethrow;
  }
}
