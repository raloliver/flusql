import 'package:flutter/material.dart';
import 'package:flusql/utils/connections.dart';

class Users extends StatefulWidget {
  List users;
  var onChange;
  Users({Key key, this.users, this.onChange}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    List _users = widget.users;

    return Expanded(
      child: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('User ' + index.toString()),
            subtitle: Text('Email ' + index.toString()),
          );
        },
      ),
    );
  }
}
