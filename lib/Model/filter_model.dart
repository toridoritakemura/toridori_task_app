
/// review: ネーミングはわかりやすいものを！
/// ApiArgumentsとかがいいと思います！あくまで例で僕がデタラメ言っている可能性を捨てないで自分で考えてみてください！笑
class ApiArgument {
  String label;
  String state;
  String since;
  String sort;

  ApiArgument({
    required this.label,
    required this.state,
    required this.since,
    required this.sort,
  });
}
