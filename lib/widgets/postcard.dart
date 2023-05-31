import 'package:flutter/material.dart';
import 'package:samaritan/screens/infoscreen.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final String organization;
  final String imageLink;
  final String postDescription;
  final double raisedAmount;
  final double targetAmount;

  const PostCard({Key? key, required this.organization, required this.imageLink, required this.postDescription, required this.raisedAmount, required this.targetAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    var numberFormat = NumberFormat("###,###.0#", "en_US");
    String targetString = '\$${numberFormat.format(targetAmount)}';

    return Hero(
      tag: organization,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        child: GestureDetector(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.8,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(organization,
                          style: const TextStyle(
                              fontSize: 22,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.w400
                              // fontWeight: FontWeight.bold,
                              )),
                    ],
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Widget>[
                      Text('Target',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Color.fromRGBO(146, 143, 221, 1),
                            // fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(targetString,
                          style: const TextStyle(
                            fontSize: 22,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            // fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InfoScreen(organization: organization, imageLink: imageLink, postDescription: postDescription, raisedAmount: raisedAmount, targetAmount: targetAmount,)),
            );
          },
        ),
      ),
    );
  }
}
