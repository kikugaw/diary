import 'package:diary_test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '新規投稿',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: ChangeForm(),
      ),
    );
  }
}

class ChangeForm extends StatefulWidget {
  @override
  _ChangeFormState createState() => _ChangeFormState();
}

class _ChangeFormState extends State<ChangeForm> {
  TextEditingController _diaryInputController;

  String _text = '';

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  //コントローラーの初期化
  void initState() {
    super.initState();
    _diaryInputController = TextEditingController();
  }

  //statefulオブジェクトが削除されるときに、参照を削除してくれる
  void dispose() {
    super.dispose();
    _diaryInputController.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: <Widget>[
          new TextField(
            controller: _diaryInputController,
            autofocus: true,
            enabled: true,
            // 入力数
            maxLength: 300,
            maxLengthEnforced: false,
            style: TextStyle(
              color: Colors.red,
              fontSize: 21,
            ),
            obscureText: false,
            minLines: 1,
            maxLines: 15,
            //パスワード
            onChanged: _handleText,
            decoration: const InputDecoration(
              icon: Icon(Icons.article_outlined),
              hintText: '今日の出来事',
            ),
          ),
          RaisedButton(
            child: Text('投稿する'),
            onPressed: () {
              /*setState(
                () {
                  // 何かしらの入力があるときだけ実行
                  if (_diaryInputController.text.length > 0) {
                    // 配列に入力値を追加
                    diaryList.add(_diaryInputController.text);
                    // テキストボックスを初期化
                    _diaryInputController.clear();
                  }
                },
              );*/
              setState(() {});
              Navigator.pop(context, _diaryInputController.text);
            },
          ),
        ],
      ),
    );
  }
}
