import 'package:diary_test/post_page.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostPage()),
          );
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
