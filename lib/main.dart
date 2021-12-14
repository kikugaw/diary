import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:diary_test/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'calender_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Diary'),
      // home: CalenderExample(),"
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> diaryList = [];
  List<String> diary = [];
  File imageFile;
  String imagePath;

  Future<void> update() async {
    setState(() {});
  }

  removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('my_diary');
  }

  saveList(key, list) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, list);
  }

  getList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // diary = prefs.getStringList('my_diary') ?? [];
      diaryList = prefs.getStringList('my_diary') ?? [];
    });
  }

  saveImage(imagePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('image', imagePath);
  }

  Future<Uint8List> getImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() async {
    // diary = prefs.getStringList('my_diary') ?? [];
    imagePath = prefs.getString('image');
    //imageのpathをByteDataに変換
    ByteData byte = await rootBundle.load(imagePath);

    //ByteDataをUint8List変換
    final Uint8List list = byte.buffer.asUint8List();
    return list;
    // });
  }

  @override
  void initState() {
    super.initState();
    // 初期化時にShared Preferencesに保存している値を読み込む
    getList();
    getImage();
    final imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 35,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.today_sharp,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalenderExample()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(children: <Widget>[
          DrawerHeader(
            child: Text('メニューバー'),
            // decoration: BoxDecoration(
            //   color: Colors.blue[100],
            // ),
          ),
          ListTile(
            title: Text("トップページへ"),
            trailing: Icon(Icons.home),
            // onTap: () {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => SelectPage()));
            // },
          ),
        ]),
      ),
      body: Column(
        // column widgetにwidgetのセットを配列で渡す
        children: <Widget>[
          Expanded(
              child: GridView.builder(
                  itemCount: diaryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: imageFile != null
                          ? Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/cat.png'),
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: ListTile(
                                  title: Text(
                                    // リストに表示する文字列を設定
                                    ("$index : ${diaryList[index]}"),
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 24,
                                    ),
                                  ),
                                  leading: Icon(Icons.star),
                                  subtitle: Text("Date"),
                                ),
                              ),
                            )
                          : Container(
                              color: Colors.grey[300],
                              margin: EdgeInsets.all(10.0),
                              child: Center(
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  child: ListTile(
                                    title: Text(
                                      // リストに表示する文字列を設定
                                      ("$index : ${diaryList[index]}"),
                                      style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                    leading: Icon(Icons.star),
                                    subtitle: Text("Date"),
                                  ),
                                ),
                              ),
                            ),
                    );
                  })),

          // TextButton(onPressed: removeData, child: Text('更新')),
          TextButton(onPressed: removeData, child: Text('削除')),
          Container(
            // child: Text('$diary'),
            child: Text('$diaryList'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostPage()),
          );
          print(result);
          setState(() {
            return diaryList.add(result);
          });
          // saveList('my_diary', diary);
          saveList('my_diary', diaryList);
          getList();
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.art_track_sharp,
          size: 35,
        ),
      ),
    );
  }
}
