import 'package:firebase_auth/firebase_auth.dart';


class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signupWithEmailAndPassword(String email, String password)async {

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }
    catch (err){
      print("some signup error");
    }

    return null;

  }

  Future<User?> signinWithEmailAndPassword(String email, String password)async {

    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }
    catch (err){
      print(err);
    }

    return null;

  }
}

class AuthIdService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get userId => _auth.currentUser?.uid;
}