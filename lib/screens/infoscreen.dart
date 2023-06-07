import 'package:flutter/material.dart';
import 'package:samaritan/widgets/donationdialog.dart';
import 'package:intl/intl.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen(
      {super.key,
      required this.organization,
      required this.imageLink,
      required this.postDescription, required this.targetAmount, required this.raisedAmount, required this.email, required this.postDocID});

  final String organization;
  final String imageLink;
  final String postDescription;
  final String email;
  final double targetAmount;
  final double raisedAmount;
  final String postDocID;

  @override
  State<InfoScreen> createState() => InfoScreenState();
}

class InfoScreenState extends State<InfoScreen> {
  var numberFormat = NumberFormat("###,###.0#", "en_US");

  TextEditingController donationTextbox = TextEditingController();

  @override
  Widget build(BuildContext context) {

    String targetString = 'Target: \$${numberFormat.format(widget.targetAmount)}';
    String raisedString = 'Raised: \$${numberFormat.format(widget.raisedAmount)}';

    return Scaffold(
      body: GestureDetector(
        onDoubleTap: () {
          Navigator.pop(context);
        },
        child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Hero(
          tag: '',
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  widget.imageLink == '' ? 'https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*' : widget.imageLink,
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 18.0),
              ),
              Text(
                widget.organization,
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
              ),
              SliderTheme(
                data: SliderThemeData(
                    trackHeight: 6,
                    thumbShape: SliderComponentShape.noThumb,
                    overlayShape: SliderComponentShape.noOverlay),
                child: Slider(
                  divisions: widget.targetAmount.round(),
                  inactiveColor: const Color.fromRGBO(106, 103, 155, 1),
                  activeColor: const Color.fromRGBO(146, 143, 221, 1),
                  value: (widget.raisedAmount / widget.targetAmount),
                  onChanged: (val) {
                    setState(() {});
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
              ),
              Row(
                children: <Widget>[
                  Text(
                    targetString,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 68, 68, 68),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                    raisedString,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(146, 143, 221, 1),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
              ),
              Text(
                widget.postDescription,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              )
            ],
          ),
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pop(context);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DonationDialog(textEditingController: donationTextbox, organizationName: widget.organization, organizationEmail: widget.email, postDocID: widget.postDocID,);
            },
          );
        },
        tooltip: 'Increment',
        elevation: 0,
        backgroundColor: const Color.fromRGBO(146, 143, 221, 1),
        child: const Icon(Icons.favorite),
      ),
    );
  }
}
