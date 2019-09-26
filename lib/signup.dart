import 'package:flutter/material.dart';
import 'package:flusql/utils/connections.dart';

class Signup extends StatefulWidget {
  var pushUser;
  //constructor
  Signup({Key key, this.pushUser}): super (key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {'enabled': false};

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              TextFormField(
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Este campo é obrigatório';
                    }
                  },
                  onSaved: (value) {
                    _formData['name'] = value;
                  }),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Este campo é obrigatório';
                    }
                  },
                  onSaved: (value) {
                    _formData['email'] = value;
                  }),
              Switch(
                value: _formData['enabled'],
                onChanged: (value) {
                  _formData['enabled'] = value;
                },
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Cadastrar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    _addUser();
                    _formKey.currentState.reset();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addUser() async {
    var data = [
      _formData['name'],
      _formData['email'],
      _formData['enabled'],
    ];
    //await for database connect
    var database = await ConnectionDB.connect();
    //transaction is better than just insert
    database.transaction((txn) async {
      //we use ? ? ? to prevent sql injection
      int id = await txn.rawInsert(
          'INSERT INTO users (name, email, enabled) VALUES (?, ?, ?)', data);
      widget.pushUser();
    });
  }
}
