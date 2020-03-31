import 'package:flutter/material.dart';
import 'package:brewcrew/pages/wrapper.dart';
import 'package:brewcrew/service/auth.dart';
import 'package:provider/provider.dart';

import 'model/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: Auth().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Brew Crew',
        theme: ThemeData(primarySwatch: Colors.brown),
        home: Wrapper(),
      ),
    );
  }
}
