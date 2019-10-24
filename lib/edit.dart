import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  Map getUser = {};

  EditUser({Key key, this.getUser}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {

  
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {'enabled': false};

  @override
  Widget build(BuildContext context) {
    print(widget.getUser);
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
                  'Salvar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    _editUser();
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
}

_editUser() async {}
