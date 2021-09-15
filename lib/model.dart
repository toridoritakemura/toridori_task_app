
  class Issue {
    ///プロパティ
    int code = 0;//No.
    int coment = 0;//コメント
    String title = 'タイトル';//タイトル
    String text = '質問文';//質問分
    String date = '20xx年oo月//日';//日付

    ///コンストラクタ
    Issue(
        this.code,
        this.coment,
        this.title,
        this.text,
        this.date,
        ) {}
  }