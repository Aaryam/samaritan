import 'package:flutter/material.dart';
import 'package:samaritan/widgets/postcard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: const <Widget>[
              PostCard(organization: 'People For Animals', imageLink: 'https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*', postDescription: 'As soon as you complete our donation, we will start its journey. First your moneyw ill be turned into food, and then sent to one of the over 120 countries where people are most vulberable.', raisedAmount: 10000, targetAmount: 100000,),
              PostCard(organization: 'Red Cross', imageLink: 'https://media.istockphoto.com/id/535555239/photo/happy-indian-school-children.jpg?s=612x612&w=0&k=20&c=fcpTUHiHJuaeRS-xHJy4oOflwKpBooiPecyewzohvhk=', postDescription: 'As soon as you complete our donation, we will start its journey. First your moneyw ill be turned into food, and then sent to one of the over 120 countries where people are most vulberable.', raisedAmount: 2, targetAmount: 50,),
              PostCard(organization: 'Feeding America', imageLink: 'https://media.istockphoto.com/id/1177156986/photo/free-food-for-the-homeless-and-the-hungry-food-donation-concepts.jpg?s=612x612&w=0&k=20&c=J_vrsDpsERIsyej_f0ApIwqOnDEWt1uqfj67LvxloGk=', postDescription: 'As soon as you complete our donation, we will start its journey. First your moneyw ill be turned into food, and then sent to one of the over 120 countries where people are most vulberable.', raisedAmount: 100, targetAmount: 700,),
              PostCard(organization: 'Gates Foundation', imageLink: 'https://d13kjxnqnhcmn2.cloudfront.net/AcuCustom/Sitename/DAM/015/ai-for-good-3.jpg', postDescription: 'As soon as you complete our donation, we will start its journey. First your moneyw ill be turned into food, and then sent to one of the over 120 countries where people are most vulberable.', raisedAmount: 100, targetAmount: 105,),
              PostCard(organization: 'The Ramblers', imageLink: 'https://whyy.org/wp-content/uploads/2019/06/wewalk-2-768x512.jpg', postDescription: 'As soon as you complete our donation, we will start its journey. First your moneyw ill be turned into food, and then sent to one of the over 120 countries where people are most vulberable.', raisedAmount: 200, targetAmount: 300,),
            ],
          ),
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
