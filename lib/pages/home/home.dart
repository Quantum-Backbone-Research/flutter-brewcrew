import 'package:flutter/material.dart';
import 'package:brewcrew/model/brew.dart';
import 'package:brewcrew/model/user.dart';
import 'package:brewcrew/pages/home/brew_list.dart';
import 'package:brewcrew/pages/home/settings_form.dart';
import 'package:brewcrew/service/auth.dart';
import 'package:brewcrew/service/database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 60.0,
              ),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: Database(user.uid).brews,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text('logout', style: TextStyle(fontSize: 12.0)),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () async {
                await _showSettingsPanel();
              },
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/coffee_bg.png'))),
            child: BrewList()),
      ),
    );
  }
}
