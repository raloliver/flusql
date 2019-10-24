import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flusql/utils/connections.dart';
import 'package:flusql/edit.dart';

class Users extends StatefulWidget {
  List users;
  var pullUser;
  //constructor
  Users({Key key, this.users, this.pullUser}) : super(key: key);

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
            //use just 'actions' do show icons from left
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Editar',
                color: Colors.blue,
                icon: Icons.edit,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Editing User'),
                          content: EditUser(),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Cancelar'),
                            )
                          ],
                        );
                      });
                },
              ),
              IconSlideAction(
                caption: 'Remover',
                color: Colors.red,
                icon: Icons.delete_forever,
                onTap: () {
                  ConnectionDB.connect().then((db) {
                    return db.delete('people',
                        where: 'id=?', whereArgs: [_users[index]['id']]);
                  }).then((data) {
                    widget.pullUser();
                  });
                },
              )
            ],
          );
        },
      ),
    );
  }
}
