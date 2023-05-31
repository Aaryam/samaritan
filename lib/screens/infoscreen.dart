import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key, required this.title});

  final String title;

  @override
  State<InfoScreen> createState() => InfoScreenState();
}

class InfoScreenState extends State<InfoScreen> {
  var _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 92, 91, 140),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 92, 91, 140),
        title: const Text(
          'Details',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ), //const Color.fromRGBO(146, 143, 221, 1),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(146, 143, 221, 1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                'https://www.everypixel.com/covers/free/vector/nature/sky/cover.jpg',
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0),
            ),
            const Text(
              'People for Animals',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
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
                inactiveColor: const Color.fromRGBO(106, 103, 155, 1),
                activeColor: const Color.fromRGBO(146, 143, 221, 1),
                value: 0.8,
                onChanged: (val) {
                  _value = val;
                  setState(() {});
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            Row(
              children: const <Widget>[
                Text(
                  'Target: \$10,505',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Text(
                  'Raised: \$10,505',
                  style: TextStyle(
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
            Text('As soon as you complete our donation, we will start its journey. First your moneyw ill be turned into food, and then sent to one of the over 120 countries where people are most vulberable.', style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
            ),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        elevation: 0,
        backgroundColor: const Color.fromRGBO(146, 143, 221, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
