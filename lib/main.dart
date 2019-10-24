import 'package:flutter/material.dart';
import 'package:flusql/utils/connections.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flusql/signup.dart';
import 'package:flusql/users.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FluSQL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'FluSQL'),
      debugShowCheckedModeBanner: false,
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
  Database _database;
  List _users = [];

  void initState() {
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Signup(pushUser: () {
            getUsers();
          }),
          Users(
              users: _users,
              updateUsers: () {
                getUsers();
              }),
        ],
      ),
    );
  }

  getUsers() {
    ConnectionDB.connect().then((database) {
      _database = database;
      _database.rawQuery('select * from people').then((data) {
        setState(() {
          _users = data;
        });
      });
    });
  }
}
