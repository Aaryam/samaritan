import 'package:flutter/material.dart';
import 'package:samaritan/misc/utilities.dart';
import 'package:samaritan/screens/homescreen.dart';
import 'package:samaritan/screens/registerscreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Image.network(
              'https://cdni.iconscout.com/illustration/premium/thumb/login-page-2578971-2147152.png',
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            const SizedBox(height: 20.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: emailController,
              obscureText: false,
              style: const TextStyle(
                fontFamily: 'Poppins',
              ),
              decoration: InputDecoration(
                hintText: 'Email',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              style: const TextStyle(
                fontFamily: 'Poppins',
              ),
              decoration: InputDecoration(
                hintText: 'Password',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.08,
              child: ElevatedButton(
                onPressed: () async {
                  String email = emailController.text;
                  String password = passwordController.text;
                  // Perform login logic here

                  if (await AuthenticationUtilities.isSignedIn()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(title: ''),
                        ));
                  } else {
                    await AuthenticationUtilities.signInWithEmail(
                        context, email, password);

                    print('signed in');
                  }

                  print(
                      '${await AuthenticationUtilities.isSignedIn()} is signed in');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(146, 143, 221, 1),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ));
              },
              child: const Text(
                "Don't have an account?",
                style: TextStyle(
                  color: Color.fromARGB(255, 97, 154, 201),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
