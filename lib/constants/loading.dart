import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://i.postimg.cc/4xHhNkC2/2020-06-25-Kleki.png"),
                fit: BoxFit.cover)),
        child: Card(
          color: Colors.transparent,elevation: 0.0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('loading...'),
                SizedBox(height:25),
                Center(
                    child: CircularProgressIndicator(backgroundColor: Color(0xff98C7E3),)
                ),
              ],
            ),
          ),
        )
    );
  }
}