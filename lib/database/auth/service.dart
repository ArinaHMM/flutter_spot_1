import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spot_1/database/auth/model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String verificationId = '';

  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user!;

      return UserModel.fromFirebase(user);
    } catch (e) {
      debugPrint('Ошибка при входе: $e');
      return null;
    }
  }

  Future<UserModel?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user!;

      return UserModel.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future<void> logOut() async {
    return await _firebaseAuth.signOut();
  }

  Stream<UserModel?> get currentUser {
    return _firebaseAuth
        .authStateChanges()
        .map((user) => user != null ? UserModel.fromFirebase(user) : null);
  }

  Future<bool> verifyPhoneNumber(
      String phoneNumber, BuildContext context) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint('Ошибка: ${e.message}');
          return;
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;
          Navigator.pushNamed(context, '/ver');
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(seconds: 60),
      );
      return true;
    } catch (e) {
      debugPrint('Ошибка: $e');
      return false;
    }
  }

  Future<bool> verifyCode(String verificationCode) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: verificationCode,
      );
      await _firebaseAuth.signInWithCredential(credential);
      return true;
    } catch (e) {
      debugPrint('Ошибка: $e');
      return false;
    }
  }
}
