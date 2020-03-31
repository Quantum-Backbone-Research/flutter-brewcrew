import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:brewcrew/model/user.dart';
import 'package:brewcrew/service/database.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_fromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      return _fromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _fromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await Database(user.uid)
          .updateUserData(name: 'new crew member', sugar: 0, strength: 100);
      return _fromFirebaseUser(result.user);
    } catch (e) {
      print('register error');
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('signin error');
      print(e.toString());
      return null;
    }
  }

  User _fromFirebaseUser(FirebaseUser user) {
    return user != null ? User(user.uid) : null;
  }
}
