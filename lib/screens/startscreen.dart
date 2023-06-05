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
            return AutoFutureBuilder(future: UserUtilities.initializeUserDetails(), widget: const HomeScreen(title: ''));
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
  }
}