import 'package:firebase_auth/firebase_auth.dart';
import 'CommonServices.dart';

class AuthServices {
  final _commonServices = CommonServices();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> signIn({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      if (user != null) {
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _commonServices.showToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _commonServices.showToast('Wrong password provided for that user.');
      } else {
        _commonServices.showToast('There was some error');
      }
      return false;
    }
  }
}
