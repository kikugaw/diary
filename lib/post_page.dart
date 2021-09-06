import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          '新規投稿',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            //fontFamily: 'Kosygin',
            color: Colors.black,
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            /*Text(
              "$_text",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500),
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Colors.black,
                  ),
                  label: const Text(
                    '写真追加',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[300],
                    onPrimary: Colors.blue,
                    //elevation: 16,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
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
              maxLines: 30,
              //パスワード
              onChanged: _handleText,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.article_outlined,
                  size: 28,
                  color: Colors.black,
                ),
                hintText: '日記を書く',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              child: Text(
                '投稿する',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[300],
                onPrimary: Colors.blue,
                elevation: 16,
              ),
              onPressed: () {},
            )
          ],
        ));
  }
}
