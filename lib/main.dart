import 'package:diary_test/post_page.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    // 初期化時にShared Preferencesに保存している値を読み込む
    getList();
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
            child: ListView.builder(
              // リストの長さを計算
              // itemCount: diary.length > 0 ? diary.length : diaryList.length,
              itemCount: diaryList.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  padding: EdgeInsets.only(
                      top: 0.0, right: 0.0, bottom: 0.0, left: 0.0),
                  margin: EdgeInsets.only(
                      top: 1.0, right: 0.0, bottom: 0.0, left: 0.0),
                  color: Colors.cyan[600],
                  child: ListTile(
                    leading: Icon(Icons.star),
                    title: Text(
                      // リストに表示する文字列を設定
                      ("$index : ${diaryList[index]}"),

                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    // title: diary.length > 0
                    //     ? Text(
                    //         // リストに表示する文字列を設定
                    //         ("$index : ${diary[index]}"),
                    //         style: TextStyle(
                    //           fontFamily: 'OpenSans',
                    //           fontSize: 24,
                    //           color: Colors.white,
                    //         ),
                    //       )
                    //     : Text(
                    //         // リストに表示する文字列を設定
                    //         ("$index : ${diaryList[index]}"),
                    //         style: TextStyle(
                    //           fontFamily: 'OpenSans',
                    //           fontSize: 24,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                  ),
                );
              },
            ),
          ),
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
          getList();
          print(result);
          setState(() {
            return diaryList.add(result);
          });
          // saveList('my_diary', diary);
          saveList('my_diary', diaryList);
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
