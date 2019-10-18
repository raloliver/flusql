import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
          return Slidable(
            actionPane: SlidableBehindActionPane(),
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: Text(_users[index]['name']),
                subtitle: Text(_users[index]['email']),
              ),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Editar',
                color: Colors.blue,
                icon: Icons.edit,
                onTap: () {
                  print('editar...');
                },
              ),
              IconSlideAction(
                caption: 'Remover',
                color: Colors.red,
                icon: Icons.delete_forever,
                onTap: () {
                  print('remover...');
                },
              )
            ],
          );
        },
      ),
    );
  }
}
