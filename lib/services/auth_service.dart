import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Register a new user
  Future<User?> registerUser(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store user data in Firestore
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "name": name,
        "email": email,
      });

      return userCredential.user;
    } catch (e) {
      print("Registration Error: $e");
      return null;
    }
  }

  /// Login user and save token in SharedPreferences
  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? token = await userCredential.user!.getIdToken();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token!);

      return userCredential.user;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  /// Logout user and clear token
  Future<void> logout() async {
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  /// Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
