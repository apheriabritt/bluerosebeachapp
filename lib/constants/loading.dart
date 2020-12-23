import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color:Color(0xff1B8DC9),
        child: Card(
          color: Colors.transparent,elevation: 0.0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: CircularProgressIndicator(backgroundColor: Color(0xff98C7E3))
                ),
              ],
            ),
          ),
        )
    );
  }
}