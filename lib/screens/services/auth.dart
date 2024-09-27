import "package:firebase_auth/firebase_auth.dart";
import "package:gr4/models/user.dart";
import "package:gr4/screens/services/database.dart";

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object
  Users? _userFromFirebaseUser(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  //change useer stream
  Stream<Users?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  //sign in anonymous

  Future<Users?> signInAnonymously() async {
    try {
      // Sign in the user anonymously using FirebaseAuth
      UserCredential result = await FirebaseAuth.instance.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      // Log the error message
      print('Error signing in anonymously: $e');
      // Return null user
      return null;
    }
  }

  //sign in email and pwd
  Future signInWithEmailAndPwd(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register email pwd
  Future registerWithEmailAndPwd(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //create doc with uid
      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'new customer', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
