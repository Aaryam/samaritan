import 'package:flutter/material.dart';

class AutoFutureBuilder extends StatelessWidget {

  final Future future;
  final Widget widget;

  const AutoFutureBuilder({super.key, required this.future, required this.widget});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
      if (snapshot.hasData) {
        return widget;
      }
      else if (snapshot.hasError) {
        return Text(snapshot.error.toString());
      }
      else {
        return Container();
      }
    });
  }
}