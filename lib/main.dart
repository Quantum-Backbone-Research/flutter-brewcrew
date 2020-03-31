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
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Wrapper(),
      ),
    );
  }
}
