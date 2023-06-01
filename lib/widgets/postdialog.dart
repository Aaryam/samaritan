import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:samaritan/misc/utilities.dart';

class PostDialog extends StatelessWidget {
  const PostDialog({super.key, required this.descriptionController, required this.targetAmountController, required this.imageUrlController});

  final TextEditingController descriptionController;
  final TextEditingController targetAmountController;
  final TextEditingController imageUrlController;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text(
        'Create Post',
        style: TextStyle(fontFamily: 'Poppins'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: 'Enter post description.',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: targetAmountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter target amount.',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: imageUrlController,
            decoration: InputDecoration(
              hintText: 'Enter image URL.',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(146, 143, 221, 1),
            elevation: 0,
            textStyle: const TextStyle(fontFamily: 'Poppins'),
          ),
          onPressed: () {
            String description = descriptionController.text;
            double targetAmount = double.parse(targetAmountController.text);
            String imageUrl = imageUrlController.text;

            UserUtilities.createPost(FirebaseAuth.instance.currentUser!.email as String, description, targetAmount, 0.0, imageUrl);

            Navigator.pop(context);
          },
          child: const Text('Post'),
        ),
      ],
    );
  }
}
