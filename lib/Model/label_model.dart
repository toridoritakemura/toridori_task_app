
List<Label> labelList = [
  Label(id: 1, url: 'url', name: 'name', label_name: 'label_name'),
  Label(id: 1, url: 'url', name: 'name', label_name: 'label_name'),
  ];
class Label {
  ///プロパティ
  final int? id;
  final String? url;
  final String? name;
  final String? label_name;


  ///コンストラクタ
  Label({
    required this.id,
    required this.url,
    required this.name,
    required this.label_name,
  });

}