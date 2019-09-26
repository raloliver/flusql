import 'package:flutter/material.dart';
import 'package:flusql/utils/connections.dart';
import 'package:flusql/signup.dart';

class Users extends StatefulWidget {
  List users;
  //constructor
  Users({Key key, this.users}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    List _users = widget.users;
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
