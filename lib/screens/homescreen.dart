import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:samaritan/misc/utilities.dart';
import 'package:samaritan/widgets/postcard.dart';
import 'package:samaritan/widgets/postdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController targetAmountController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    print('here');

    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return const Text('Error recieving posts.');
                }

                if (!snapshot.hasData) {
                  return Container(color: Colors.blue,);
                }

                final posts =
                    snapshot.data!.docs.map((doc) => doc.data()).toList();

                final postIDs = snapshot.data!.docs.map((doc) => doc.id).toList();

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index] as Map;
                    return PostCard(
                      tag: index,
                      postDocID: postIDs[index],
                        displayName: post['organization'],
                        organizationEmail: post['email'],
                        imageLink: post['imageURL'],
                        postDescription: post['description'],
                        raisedAmount: post['raisedAmount'],
                        targetAmount: post['targetAmount'],
                    );
                  },
                );
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          showDialog(
              context: context,
              builder: (context) {
                return PostDialog(
                  descriptionController: descriptionController,
                  targetAmountController: targetAmountController,
                  imageUrlController: imageUrlController,
                );
              });
        },
        tooltip: 'Increment',
        elevation: 0,
        backgroundColor: const Color.fromRGBO(146, 143, 221, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
