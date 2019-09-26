import 'package:flutter/material.dart';
import 'package:flusql/utils/connections.dart';
import 'package:sqflite/sqflite.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  Database _database;
  List _users = [];

  void initState() {
    ConnectionDB.connect().then((database) {
      _database = database;
      _database.rawQuery('select * from users').then((data) {
        setState(() {
          _users = data;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_users[index]['name']),
            subtitle: Text(_users[index]['email']),
          );
        },
      ),
    );
  }
}
