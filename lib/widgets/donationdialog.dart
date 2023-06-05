import 'package:flutter/material.dart';
import 'package:samaritan/misc/utilities.dart';
import 'package:samaritan/screens/upiselectionscreen.dart';

class DonationDialog extends StatelessWidget {
  const DonationDialog({super.key, required this.textEditingController, required this.organizationName, required this.organizationEmail, required this.postDocID});

  final TextEditingController textEditingController;
  final String organizationName;
  final String organizationEmail;
  final String postDocID;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text(
        'Donate',
        style: TextStyle(fontFamily: 'Poppins'),
      ),
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
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(146, 143, 221, 1),
              elevation: 0,
              textStyle: const TextStyle(
                fontFamily: 'Poppins',
              )),
          onPressed: () async {

            String upi = await UserUtilities.getUPIFromEmail(organizationEmail);

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UPISelectionScreen(
                    amount: double.parse(textEditingController.text),
                    recieverName: organizationName,
                    transactionNote: 'Test.',
                    receiverUpiAddress: upi,
                    recieverEmail: organizationEmail,
                    docID: postDocID,
                  ),
                ));
            //Navigator.pop(context);
          },
          child: const Text('Donate'),
        ),
      ],
    );
  }
}
