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
  String _text = '';

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            /*Text(
              "$_text",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500),
            ),*/
            new TextField(
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
              onPressed: () {},
            )
          ],
        ));
  }
}
