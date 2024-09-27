import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gr4/models/trophy.dart';
import 'package:gr4/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  //collection refenrence
  final CollectionReference trophyCollection =
      FirebaseFirestore.instance.collection('trophies');

  Future<void> updateUserData(String x, String y, int z) async {
    await trophyCollection.doc(uid).set({
      'x': x, //design
      'y': y, //material
      'z': z, //engraving
    });
  }

  //trophy list from snapshot
  List<Trophy> _trophyListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Trophy(
        x: doc.get('x') ?? '',
        y: doc.get('y') ?? 0,
        z: doc.get('z') ?? '0',
      );
    }).toList();
  }

  UserData? _userDataFromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        return UserData(
          uid: data['uid'] ?? '',
          x: data['x'] ?? '',
          y: data['y'] ?? '',
          z: data['z'] ?? 0,
        );
      }
    }

    return null;
  }

  //get trophy stream
  Stream<List<Trophy>> get trophy {
    return trophyCollection.snapshots().map(_trophyListFromSnapshot);
  }

  //get user stream
  Stream<UserData?> get userData {
    return trophyCollection.doc(uid).snapshots().map((snapshot) {
      return _userDataFromSnapshot(snapshot);
    });
  }
}
