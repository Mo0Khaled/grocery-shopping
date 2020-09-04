import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Auth with ChangeNotifier{

  Future<bool> get isAuth async{
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    String token = await auth.currentUser.getIdToken();
    return token != null;
  }
  Future<void> registration(String email,String password)async{
    await Firebase.initializeApp();
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    );
    notifyListeners();
  }
  Future<void> signIn(String email,String password)async{
//    await Firebase.initializeApp();
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    notifyListeners();
  }
  Future<void> signOut()async{
    await FirebaseAuth.instance.signOut();
  }
  Future<void> tryLogin()async{
    String email = 'shikosc@yahoo.com';
    String password = '123456';

    EmailAuthCredential credential = EmailAuthProvider.credential(email:email ,password: password);

    await FirebaseAuth.instance.currentUser.reauthenticateWithCredential(credential);
  }


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}