
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';


List<LabelName> labelsList = [
  LabelName(name: 'label1'),
  LabelName(name: 'label2'),
  LabelName(name: 'label3'),
  LabelName(name: 'label4'),
  LabelName(name: 'label5'),

];

Future<List<LabelName>> fetchListLabel() async {
  final response = await http.get(Uri.parse('https://api.github.com/repos/flutter/flutter/issues/90597'),
    headers: {
      HttpHeaders.authorizationHeader: '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',
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return jsonResponse.map((data) => LabelName.fromJson(data)).toList() ?? 'no label';

  } else {
    throw Exception('Unexpected error occured!');
  }
}

///LabelsList一個分APIコール部分
Future<List<LabelName>> getLabelAPI() async {
  String url = 'https://api.github.com/repos/flutter/flutter/issues/90597/labels';
  try{
    final result = await get(Uri.parse(url));
    final data = jsonDecode(result.body);
    final labelListData = data;

    final labelList = labelListData.map<LabelName>((data){
      return LabelName (
        name: data['name'] ?? 'no label',
      );
    }).toList();

    return labelList;

  }
  catch (e){
    rethrow;
  }
}



class LabelName {
  ///プロパティ
  final String? name;

  ///コンストラクタ
  LabelName({
    required this.name,

  });

  factory LabelName.fromJson(Map<String, dynamic> json) {
    return LabelName(
      name: json['name'],

    );
  }

}

class Labels {
  ///プロパティ
  final List<LabelName> labels;

  ///コンストラクタ
  Labels({
    required this.labels,

  });

  factory Labels.fromJson(Map<String, dynamic> json) {

    return Labels(

        labels: json['labels'],

//        final labelsFromJson = json['labels'];
    );
  }

}



