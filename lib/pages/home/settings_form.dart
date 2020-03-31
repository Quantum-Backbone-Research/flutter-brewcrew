import 'package:flutter/material.dart';
import 'package:brewcrew/model/user.dart';
import 'package:brewcrew/service/database.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<int> sugars = [0, 1, 2, 3, 4];

  //form values
  String _currentName;
  int _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: Database(user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Text(
                    'Update settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 5.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: TextInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
//                  SizedBox(height: 5.0),
                  DropdownButtonFormField(
                    decoration: TextInputDecoration,
                    value: _currentSugar ?? userData.sugar,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugar = val),
                  ),
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? 100],
                    inactiveColor: Colors.brown[_currentStrength ?? 100],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child:
                        Text('Update', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await Database(user.uid).updateUserData(
                            name: _currentName ?? userData.name,
                            sugar: _currentSugar ?? userData.sugar,
                            strength: _currentStrength ?? userData.strength);
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
