import 'package:firedart/firedart.dart';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthService{

  var logger = Logger();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signInState() async {
    return _firebaseAuth.isSignedIn;
  }


  Future currentUser() async { //! Get Current User
    var user = await _firebaseAuth.getUser();
    return user.id;
  }

  Future signUp(String email, String pass) async {
    try {
      await _firebaseAuth.signUp(email, pass);
      var user = await _firebaseAuth.getUser();
      return user;
    } catch(e) {
      logger.e(e.toString());
      return e.toString();
    }
  }

  Future signIn(String email, String pass) async {
    try {
      await _firebaseAuth.signIn(email, pass);
      var user = await _firebaseAuth.getUser();
      return user;
    } catch(e) {
      logger.e(e.toString());
      return e.toString();
    }
  }


  Future signOut() async {
    return _firebaseAuth.signOut();

  }

}