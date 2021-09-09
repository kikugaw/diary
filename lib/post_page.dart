import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  TextEditingController _diaryInputController;

  String _text = '';
  File _image;
  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });

    // setState(() {
    //   if (pickedFile != null) {
    //     _image = File(pickedFile.path);
    //   } else {
    //     print('No image selected.');
    //   }
    // });
  }

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
          Row(
            children: [
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
                onPressed: _getImage,
              ),
              SizedBox(
                height: 30,
                width: 30,
              ),
              Center(
                child: _image == null
                    ? Text('No image selected.')
                    : Image.file(_image),
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
