
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;



///LabelsList一個分APIコール部分
Future<List<LabelName>> fetchOneLabels() async {

  final response = await http.get(Uri.parse('https://api.github.com/repos/flutter/flutter/issues/90597'),
    headers: {
      HttpHeaders.authorizationHeader: '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',
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);

    final labelJsonResponse = jsonResponse['labels'];
    return labelJsonResponse.map<LabelName>((data) => LabelName.fromJson(data)).toList() ?? 'no label';

  } else {
    throw Exception('Unexpected error occured!');
  }

}

Future<List<Labels>> fetchListLabels() async {
  final response = await http.get(Uri.parse('https://api.github.com/repos/flutter/flutter/issues'),
    headers: {
      HttpHeaders.authorizationHeader: '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',
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
//    print(jsonResponse);
    final labelJsonResponse = jsonResponse;

    return labelJsonResponse.map<LabelName>((data) => LabelName.fromJson(data)).toList() ?? 'no label';

  } else {
    throw Exception('Unexpected error occured!');
  }
}





//[labels][name]を取得するクラス
class LabelName {
  final String? name;

  LabelName({
    required this.name,

  });
  factory LabelName.fromJson(Map<String, dynamic> json) {
    return LabelName(
      name: json['name'],
    );
  }
}

//[labels]を取得するクラス
class Labels {
  final List<LabelName> labels;

  Labels({
    required this.labels,
  });

  factory Labels.fromJson(Map<String, dynamic> json) {
    Iterable list = json['products'];

    List<LabelName> labels = list.map((i) =>
        LabelName.fromJson(i)).toList();

    return Labels(
        labels: labels,

    );
  }
}






