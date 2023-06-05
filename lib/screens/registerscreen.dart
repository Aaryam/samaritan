import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:samaritan/misc/utilities.dart';
import 'package:samaritan/screens/homescreen.dart';
import 'package:samaritan/screens/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController upiIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Image.network(
              'https://i.pinimg.com/originals/a4/0d/ff/a40dff179144e07fc168e6e6dabcf746.jpg',
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            const SizedBox(height: 20.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Register',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: nameController,
              obscureText: false,
              style: const TextStyle(
                fontFamily: 'Poppins',
              ),
              decoration: InputDecoration(
                hintText: 'Name',
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
            TextField(
              controller: upiIDController,
              obscureText: true,
              style: const TextStyle(
                fontFamily: 'Poppins',
              ),
              decoration: InputDecoration(
                hintText: 'UPI ID',
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

                  if (await AuthenticationUtilities.isSignedIn()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(title: ''),
                        ));
                  } else {
                    await AuthenticationUtilities.registerWithEmail(
                        context, email, password);

                    await UserUtilities.createUser(
                        email,
                        nameController.text,
                        upiIDController.text);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(title: ''),
                        ));
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
                  'Register',
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
                      builder: (context) => LoginScreen(),
                    ));
              },
              child: const Text(
                "Already have an account?",
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
