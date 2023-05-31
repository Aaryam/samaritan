import 'package:flutter/material.dart';
import 'package:samaritan/screens/infoscreen.dart';

class PostCard extends StatelessWidget {
  final String destination;
  final String distance;

  const PostCard({Key? key, required this.destination, required this.distance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: destination,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        child: GestureDetector(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.8,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(106, 103, 155, 1),
              borderRadius: BorderRadius.circular(20),
              // image: const DecorationImage(image: NetworkImage('https://www.everypixel.com/covers/free/vector/nature/sky/cover.jpg'), fit: BoxFit.cover),
              // https://www.everypixel.com/covers/free/vector/nature/sky/cover.jpg
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(destination,
                          style: const TextStyle(
                              fontSize: 22,
                              fontFamily: 'Poppins',
                              color: Colors.white,
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
                    children: const <Widget>[
                      Text('\$23,470',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Poppins',
                            color: Colors.white,
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
                  builder: (context) => const InfoScreen(title: '')),
            );
          },
        ),
      ),
    );
  }
}
