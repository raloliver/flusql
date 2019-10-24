import 'package:flutter/material.dart';
import 'package:flusql/utils/connections.dart';

class EditUser extends StatefulWidget {
  Map getUser = {};

  var updateUser;
  EditUser({Key key, this.getUser, this.updateUser}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {'enabled': false};

  @override
  Widget build(BuildContext context) {
    // _formData = widget.getUser;
    //if does not get data, set value for one each prop (_formData['prop'] = widget.getUser['prop'])
    _formData['name'] = widget.getUser['name'];
    _formData['email'] = widget.getUser['email'];
    _formData['enabled'] = widget.getUser['enabled'];
    _formData['id'] = widget.getUser['id'];

    return Card(
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              TextFormField(
                  initialValue: widget.getUser['name'],
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
                  initialValue: widget.getUser['email'],
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
                //its necessary to check type and value
                value: widget.getUser['enabled'] == 1 ? true : false,
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

  _editUser() async {
    //declare in the same order you update
    var data = [
      _formData['name'],
      _formData['email'],
      _formData['enabled'],
      _formData['id']
    ];
    var db = await ConnectionDB.connect();
    await db.rawUpdate(
        'UPDATE people SET name=?, email=?, enabled=? WHERE id=?', data);
    widget.updateUser();
  }
}
