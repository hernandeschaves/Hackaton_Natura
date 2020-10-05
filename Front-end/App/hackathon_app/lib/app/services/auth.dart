import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/app/model/user_model.dart';
import 'package:hackathon_app/main.dart';
import 'connection.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ConnectionFirebase _conncetionFirebase = ConnectionFirebase();
  UserModel _currentUser;
  UserModel get currentUser => _currentUser;

  Future loginWithEmail() async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: userController.formEmail,
        password: userController.formPassword,
      );
      //if (authResult.user.emailVerified) {
      await _populateCurrentUser(authResult.user);
      return true;
      //} else {
      //return "Email não verificado";
      //}
    } catch (e) {
      return e;
    }
  }

  Future<String> signUpWithEmail() async {
    //Manda um email de verificação:
    //await authResult.user.sendEmailVerification();
    try {
      UserCredential authResult =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: userController.formEmail,
        password: userController.formPassword,
      );
      // create a new user profile on firestore
      _currentUser = UserModel(
        id: authResult.user.uid,
        name: userController.formName,
        email: userController.formEmail,
        saldo: 0.0,
      );
      await _conncetionFirebase.createUser(_currentUser);
      return "Usuário cadastrado";
    } catch (e) {
      return e.message;
    }
  }

  Future<dynamic> resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: userController.user.email);
    } catch (e) {
      //There is no user record corresponding to this identifier. The user may have been deleted.
      //Given String is empty or null
      return e.message;
    }
    return true;
  }

  Future<bool> isUserLoggedIn() async {
    var user = _firebaseAuth.currentUser;
    await _populateCurrentUser(user);
    return user != null;
  }

  Future _populateCurrentUser(User user) async {
    if (user != null) {
      _currentUser = await _conncetionFirebase.getUser(user.uid);
      userController.setUserModel(_currentUser);
      //print("CurrentUser: ${_currentUser.id}");
    }
  }

  Future<bool> singOut() async {
    await _firebaseAuth.signOut().then((value) => {
          print("Usuário deslogado"),
        });
    return true;
  }
}
