import 'package:flutter/material.dart';
import 'package:samaritan/misc/utilities.dart';
import 'package:upi_india/upi_india.dart';

class UPISelectionScreen extends StatelessWidget {

  final double amount;
  final String recieverName;
  final String receiverUpiAddress;
  final String transactionNote;
  final String recieverEmail;
  final String docID;

  const UPISelectionScreen({super.key, required this.amount, required this.recieverName, required this.receiverUpiAddress, required this.transactionNote, required this.recieverEmail, required this.docID});

  @override
  Widget build(BuildContext context) {

    UpiIndia upiIndia = UpiIndia();

    return Material(child: FutureBuilder<List<UpiApp>>(
        future: upiIndia.getAllUpiApps(),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.hasData) {
            List<UpiApp> apps =
                futureSnapshot.data as List<UpiApp>;

            return ListView.builder(
                itemCount: apps.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () async {
                      await UPIUtilities.doUpiTransation(apps[i], amount, recieverName, receiverUpiAddress, UPIUtilities.generateTransactionRef(), transactionNote, context);
                      await UserUtilities.updatePayment(docID, recieverEmail, amount);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.memory(apps[i].icon,),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          alignment: Alignment.center,
                          child: Text(
                            apps[i].packageName,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                });
          } else if (futureSnapshot.hasError) {
            print(futureSnapshot.error.toString());
            return Text(futureSnapshot.error.toString());
          } else {
            return Container();
          }
        }),);
  }
}
