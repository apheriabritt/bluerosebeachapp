import 'package:bluerosebeachapp/shop/shop.dart';
import 'package:bluerosebeachapp/story/story.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blue Rose Beach',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff98C7E3),
            bottom: TabBar(
              labelStyle: TextStyle(fontFamily: 'apheriafont',fontSize: 20),
              tabs: [
                Tab(icon: Icon(Icons.shopping_basket_outlined),text: 'shop',),
                Tab(icon: Icon(Icons.favorite_border),text: 'story',),
              ],
            ),
            title: Center(child: Text('Blue Rose Beach',style:TextStyle(fontFamily: 'apheriafont',fontSize: 25))),
          ),
          body: TabBarView(
            children: [
              Shop(),
              Story()
            ],
          ),
        ),
      ),
    );
  }
}
