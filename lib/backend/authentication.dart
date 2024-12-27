import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nmax/models/user.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<bool> checkUsernameAvailable(String name) async {
  final data =
      await FirebaseFirestore.instance.collection('users').doc(name).get();
  return data.exists;
}

Future<bool> checkHasAccount(String email) async {
  final data = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
  return data.size!=0;
}

Future<void> createAccount(UserCredential cred, String username) async {
  await FirebaseFirestore.instance.collection('users').doc(username).set(
      UserModel(
              username: username,
              email: cred.user!.email.toString(),
              created: DateTime.now())
          .toJson());
}
