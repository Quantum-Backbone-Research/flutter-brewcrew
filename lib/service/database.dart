import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brewcrew/model/brew.dart';
import 'package:brewcrew/model/user.dart';

class Database {
  final String uid;

  Database(this.uid);

// collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  // update data for the uid
  Future updateUserData({String name, int sugar, int strength}) async {
    await brewCollection.document(uid).setData(
        {'name': name ?? '', 'sugar': sugar ?? 0, 'strength': strength ?? 0});
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_fromFibebaseQuerySnapshot);
  }

  // get UserData stream
  Stream<UserData> get userData {
    return brewCollection
        .document(uid)
        .snapshots()
        .map(_fromSnapshotToUserData);
  }

  List<Brew> _fromFibebaseQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) => Brew(
            name: doc.data['name'],
            sugar: doc.data['sugar'],
            strength: doc.data['strength']))
        .toList();
  }

  UserData _fromSnapshotToUserData(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugar: snapshot.data['sugar'],
        strength: snapshot.data['strength']);
  }
}
