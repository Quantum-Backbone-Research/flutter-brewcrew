import 'package:flutter/material.dart';
import 'package:brewcrew/model/user.dart';
import 'package:brewcrew/pages/authenticate/authenticate.dart';
import 'package:brewcrew/pages/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either Auth or Home page based on if user is signed in
    return user == null ? Authenticate() : HomePage();
  }
}
