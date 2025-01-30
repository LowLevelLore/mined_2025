import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mined_2025/client/models/user_model.dart';
import '../../helper_functions/toasts.dart';
import '../init/config.dart';

class AuthApi {
  static Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      await Config.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      WebToasts.showToastification("Confirmation", "Login Successful!",
          Icon(Icons.check_circle_outline, color: Colors.green), context);

      // navigate page here
    } on FirebaseAuthException catch (e) {
      WebToasts.showToastification("Error", "Something went wrong!",
          Icon(Icons.error, color: Colors.red), context);
    } catch (e) {
      WebToasts.showToastification("Error", "Something went wrong!",
          Icon(Icons.error, color: Colors.red), context);
    }
  }

  static Future<void> signUp(
      BuildContext context, String email, String password, String name) async {
    try {
      final existingUser = await AuthApi.userExistsEmail(email);

      if (existingUser) {
        WebToasts.showToastification("Error", "This email is already in use.",
            Icon(Icons.error, color: Colors.red), context);
        return;
      }

      UserCredential userCredential =
          await Config.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await createUserEmail(userCredential, email, name);
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email format.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Password is too weak.';
      } else {
        errorMessage = 'An unknown error occurred.';
      }
      WebToasts.showToastification(
          "Error", errorMessage, Icon(Icons.error, color: Colors.red), context);
    } catch (e) {
      print(e);
      // HelperFunctions.showToast("Something went wrong!");
      WebToasts.showToastification("Error", "Something went wrong!",
          Icon(Icons.error, color: Colors.red), context);
    }
  }

  static Future<void> createUserEmail(
      UserCredential userCredential, String email, String name) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final user = WebUser(
      userID: userCredential.user?.uid,
      name: name,
      email: email,
      createAt: time,
    );

    return await Config.firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(user.toJson());
  }

  static Future<bool> userExistsEmail(String email) async {
    final querySnapshot = await Config.firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  static Future<bool> userExistsById(String userId) async {
    final docSnapshot =
        await Config.firestore.collection('users').doc(userId).get();
    return docSnapshot.exists;
  }
}
