import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samaritan/misc/utilities.dart';

class PostDialog extends StatelessWidget {
  const PostDialog(
      {super.key,
      required this.descriptionController,
      required this.targetAmountController,
      required this.imageUrlController});

  final TextEditingController descriptionController;
  final TextEditingController targetAmountController;
  final TextEditingController imageUrlController;

  @override
  Widget build(BuildContext context) {
    XFile? postImage = null;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text(
        'Create Post',
        style: TextStyle(fontFamily: 'Poppins'),
      ),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              maxLines: 8,
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
            /*TextField(
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
          ),*/
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(146, 143, 221, 1),
            elevation: 0,
            textStyle: const TextStyle(fontFamily: 'Poppins'),
          ),
          onPressed: () async {
            ImagePicker picker = ImagePicker();
            XFile? imageFile =
                await picker.pickImage(source: ImageSource.gallery);

            if (imageFile != null) {
              postImage = imageFile;
            }
          },
          child: const Text('Add Image'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(146, 143, 221, 1),
            elevation: 0,
            textStyle: const TextStyle(fontFamily: 'Poppins'),
          ),
          onPressed: () async {
            String displayName = await UserUtilities.getNameFromEmail(
                FirebaseAuth.instance.currentUser!.email as String);
            String description = descriptionController.text;
            double targetAmount = double.parse(targetAmountController.text);
            String imageUrl = imageUrlController.text;

            await UserUtilities.createPost(
                displayName,
                FirebaseAuth.instance.currentUser!.email as String,
                description,
                targetAmount,
                0.0,
                postImage);

            Navigator.pop(context);
          },
          child: const Text('Post'),
        ),
      ],
    );
  }
}
