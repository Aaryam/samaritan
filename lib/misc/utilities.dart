import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SamaritanColors {
  static MaterialColor primaryColor = const MaterialColor(0xFF5c5b8c, <int, Color>{
    900: Color.fromARGB(255, 92, 91, 140),
    800: Color.fromARGB(255, 92, 91, 140),
    700: Color.fromARGB(255, 92, 91, 140),
    600: Color.fromARGB(255, 92, 91, 140),
    500: Color.fromARGB(255, 92, 91, 140),
    400: Color.fromARGB(255, 92, 91, 140),
    300: Color.fromARGB(255, 92, 91, 140),
    200: Color.fromARGB(255, 92, 91, 140),
    100: Color.fromARGB(255, 92, 91, 140),
    50: Color.fromARGB(255, 92, 91, 140),
  });

  static MaterialColor secondaryColor = const MaterialColor(0xFF928fdd, <int, Color>{
    900: Color.fromRGBO(146, 143, 221, 1),
    800: Color.fromRGBO(146, 143, 221, 1),
    700: Color.fromRGBO(146, 143, 221, 1),
    600: Color.fromRGBO(146, 143, 221, 1),
    500: Color.fromRGBO(146, 143, 221, 1),
    400: Color.fromRGBO(146, 143, 221, 1),
    300: Color.fromRGBO(146, 143, 221, 1),
    200: Color.fromRGBO(146, 143, 221, 1),
    100: Color.fromRGBO(146, 143, 221, 1),
    50: Color.fromRGBO(146, 143, 221, 1),
  });

  static MaterialColor tertiaryColor = const MaterialColor(0xFFFFFFFF, <int, Color>{
    900: Color.fromARGB(255, 255, 255, 255),
    800: Color.fromARGB(255, 255, 255, 255),
    700: Color.fromARGB(255, 255, 255, 255),
    600: Color.fromARGB(255, 255, 255, 255),
    500: Color.fromARGB(255, 255, 255, 255),
    400: Color.fromARGB(255, 255, 255, 255),
    300: Color.fromARGB(255, 255, 255, 255),
    200: Color.fromARGB(255, 255, 255, 255),
    100: Color.fromARGB(255, 255, 255, 255),
    50: Color.fromARGB(255, 255, 255, 255),
  });
}

class AuthenticationUtilities {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            print(e);
          } else if (e.code == 'invalid-credential') {
            print(e);
          }
        } catch (e) {
          print(e);
        }
      }
    }

    await UserUtilities.createUser(user!.email as String);

    return user;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

class UserUtilities {
  static Future<bool> createUser(String email) async {
    FirebaseFirestore.instance.collection('users').doc(email).set({
      'username': email.split("@")[0],
      'lastLogged': DateTime.now().millisecondsSinceEpoch,
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('following')
        .doc(email);

    if (await userExists(email)) {
      FirebaseFirestore.instance.collection('users').doc(email).update({
        'lastLogged': DateTime.now().millisecondsSinceEpoch,
      });
    } else {}

    return true;
  }

  static bool createPost(String authorEmail, String content, int likes) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(authorEmail)
        .collection('posts')
        .doc()
        .set({
      'content': content,
      'authorEmail': authorEmail,
      'likes': likes,
      'time': DateTime.now().millisecondsSinceEpoch
    });

    return true;
  }

  static Future<bool> userExists(String email) async {
    return (await FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .get())
        .exists;
  }
}

class ModelUtilities {
  static Map<String, Object> instantiateUser(
      username, following, followers, posts, blocked, likedPosts, lastLogged) {
    return {
      'username': username,
      'following': following,
      'followers': followers,
      'posts': posts,
      'blocked': blocked,
      'likedPosts': likedPosts,
      'lastLogged': lastLogged,
    };
  }
}