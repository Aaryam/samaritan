import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:samaritan/misc/utilities.dart';
import 'package:samaritan/screens/homescreen.dart';
import 'package:samaritan/screens/loginscreen.dart';
import 'package:samaritan/widgets/autofuturebuilder.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthenticationUtilities.isSignedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bool snapshotBool = snapshot.data as bool;

          if (snapshotBool) {
            print('signed in.');
            return const HomeScreen(title: '');
          } else {
            print('not signed in.');
            return LoginScreen();
          }
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Text(snapshot.error.toString());
        } else {
          return Container();
        }
      },
    );

    /*return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
      if (snapshot.hasData) {
        return FutureBuilder(
          future: AuthenticationUtilities.isSignedIn(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              bool snapshotBool = snapshot.data as bool;

              if (snapshotBool) {
                print('signed in.');
                return const HomeScreen(title: '');
              }
              else {
                print('not signed in.');
                return LoginScreen();
              }
            }
            else if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Text(snapshot.error.toString());
            }
            else {
              return Container();
            }
          },
        );
      }
      else if (snapshot.hasError) {
        return Text(snapshot.error.toString());
      }
      else {
        return Container();
      }
    });*/
  }
}

/*

*/
