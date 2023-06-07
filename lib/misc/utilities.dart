import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upi_india/upi_india.dart';
import 'package:uuid/uuid.dart';

class SamaritanColors {
  static MaterialColor primaryColor =
      const MaterialColor(0xFF5c5b8c, <int, Color>{
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

  static MaterialColor secondaryColor =
      const MaterialColor(0xFF928fdd, <int, Color>{
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

  static MaterialColor tertiaryColor =
      const MaterialColor(0xFFFFFFFF, <int, Color>{
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

    return user;
  }

  static Future<bool> isSignedIn() async {
    return FirebaseAuth.instance.currentUser != null;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> registerWithEmail(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

  static Future<bool> signInWithEmail(
      BuildContext context, String email, String password) async {
    var finalResult = false;

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      finalResult = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Email is invalid.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password is incorrect.')));
      }
    }

    return finalResult;
  }
}

class UserUtilities {
  static Future<bool> createPost(
      String organizationName,
      String authorEmail,
      String description,
      double targetAmount,
      double raisedAmount,
      XFile? imageFile) async {
    var uuid = const Uuid();

    String docID = uuid.v4();
    int time = DateTime.now().millisecondsSinceEpoch;

    FirebaseFirestore.instance.collection('posts').doc(docID).set({
      'organization': organizationName,
      'email': FirebaseAuth.instance.currentUser!.email,
      'description': description,
      'imageURL': '',
      'targetAmount': targetAmount,
      'raisedAmount': raisedAmount,
      'time': time
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('posts')
        .doc(docID)
        .set({
      'time': time,
    });

    if (imageFile != null) {
      await UserUtilities.uploadFile(imageFile, docID);
    }

    return true;
  }

  static Future<void> createUser(
      String email, String name, String upiID) async {
    await FirebaseFirestore.instance.collection('users').doc(email).set({
      'name': name,
      'upiID': upiID,
    });
  }

  static Future<bool> initializeUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (!(await UserUtilities.userExists(
        FirebaseAuth.instance.currentUser!.email as String))) {
      return false;
    } else {
      String name = (await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get())['name'];
      String upiID = (await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get())['upiID'];

      sharedPreferences.setString('name', name);
      sharedPreferences.setString('upiID', upiID);

      return true;
    }
  }

  static Future<String> getUPIFromEmail(String email) async {
    String upiID = (await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get())['upiID'];

    return upiID;
  }

  static Future<String> getNameFromEmail(String email) async {
    String name = (await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get())['name'];

    return name;
  }

  static Future<bool> userExists(String email) async {
    return (await FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .get())
        .exists;
  }

  static Future<bool> updatePayment(
      String docID, String recieverEmail, double payment) async {
    double raisedBeforePayment = (await FirebaseFirestore.instance
        .collection('posts')
        .doc(docID)
        .get())['raisedAmount'];
    double raisedAfterPayment = raisedBeforePayment + payment;

    await FirebaseFirestore.instance.collection('posts').doc(docID).update({
      'raisedAmount': raisedAfterPayment,
    });

    /*await FirebaseFirestore.instance
        .collection('users')
        .doc(recieverEmail)
        .collection('posts')
        .doc(docID)
        .update({
      'raisedAmount': raisedAfterPayment,
    });*/

    return true;
  }

  static Future<bool> uploadFile(XFile file, String postDocID) async {

    String fileExtension = file.path.substring(file.path.lastIndexOf("."), file.path.length);

    final metadata = SettableMetadata(
      contentType: 'image/$fileExtension',
      customMetadata: {'picked-file-path': file.path},
    );

    final storageRef = FirebaseStorage.instance.ref();
    final imagesRef = storageRef.child("images");

    if (kIsWeb) {
      UploadTask uploadTask =
          imagesRef.putData(await file.readAsBytes(), metadata);

      uploadTask.then((res) async {
        String downloadURL = await res.ref.getDownloadURL();

        FirebaseFirestore.instance.collection('posts').doc(postDocID).update({
          'imageURL': downloadURL,
        });
      });
    } else {
      UploadTask uploadTask = imagesRef.putFile(File(file.path), metadata);

      uploadTask.then((res) async {
        String downloadURL = await res.ref.getDownloadURL();

        FirebaseFirestore.instance.collection('posts').doc(postDocID).update({
          'imageURL': downloadURL,
        });
      });
    }

    return true;
  }
}

class UPIUtilities {
  static Future doUpiTransation(
      UpiApp appMeta,
      double amount,
      String recieverName,
      String receiverUpiAddress,
      String transactionRef,
      String transactionNote,
      BuildContext context) async {
    String? validationMsg = validateUPIAddress(receiverUpiAddress);

    if (validationMsg != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(validationMsg)));
      Navigator.pop(context);
    }

    UpiIndia upiIndia = UpiIndia();

    await upiIndia.startTransaction(
      amount: amount,
      app: appMeta,
      receiverName: recieverName,
      receiverUpiId: receiverUpiAddress,
      transactionRefId: transactionRef,
      transactionNote: transactionNote,
    );
    // print(response.status);
    Navigator.pop(context);
  }

  static String generateTransactionRef() {
    return Random.secure().nextInt(1 << 32).toString();
  }

  static String? validateUPIAddress(String value) {
    if (value.isEmpty) {
      return 'UPI VPA is required.';
    }
    if (value.split('@').length != 2) {
      return 'Invalid UPI VPA';
    }
    return null;
  }
}
