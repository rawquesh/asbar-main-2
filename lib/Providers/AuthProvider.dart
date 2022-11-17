import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  get isLoggedIn => auth.currentUser != null;

  get userId => auth.currentUser?.uid;

  ///Firebase

  signOut() async => await auth.signOut();
}
