import 'package:flutter/material.dart';

class DonationDialog extends StatelessWidget {
  const DonationDialog({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text('Donate', style: TextStyle(
        fontFamily: 'Poppins'
      ),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: 'Enter amount.',
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
          style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(146, 143, 221, 1), elevation: 0, textStyle: const TextStyle(
            fontFamily: 'Poppins',
          )),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Donate'),
        ),
      ],
    );
  }
}