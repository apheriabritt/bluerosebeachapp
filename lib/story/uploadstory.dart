import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bluerosebeachapp/constants/constants.dart';
import 'package:bluerosebeachapp/constants/loading.dart';
import 'package:bluerosebeachapp/main.dart';
import 'package:bluerosebeachapp/story/story.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UploadStory extends StatefulWidget {

  UploadStory({Key key}) : super(key: key);
  @override
  _UploadStoryState createState() => new _UploadStoryState();
}

class _UploadStoryState extends State<UploadStory> {
  bool loading = false;

  final formKey = new GlobalKey<FormState>();


  File url1;
  File url2;
  File url3;
  File url4;
  File url5;

  String _fileName;
  String _path;
  String _path2;
  String _path3;
  String _path4;
  String _path5;

  Map<String, String> _paths;
  Map<String, String> _paths2;
  Map<String, String> _paths3;
  Map<String, String> _paths4;
  Map<String, String> _paths5;


  bool showContainer2 = false;
  bool showContainer3 = false;
  bool showContainer4 = false;
  bool showContainer5 = false;

  File myimage;
  File myimage2;
  File myimage3;
  File myimage4;
  File myimage5;
  File sampleImage;
  Widget AddMoreImages = Container();
  Widget UploadButton =Container();

  String finalimage1;
  String finalimage2;
  String finalimage3;
  String finalimage4;
  String finalimage5;

  String oldimage='';
  String oldimage2='';
  String oldimage3='';
  String oldimage4='';
  String oldimage5='';


  String description='';


  TextEditingController _controller = new TextEditingController();
  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    else {
      return false;
    }
  }
  @override
  void initState() {
    super.initState();
    //set data as passed data


  }

  void post () async {
    this.setState(() {
      loading = true;
    });

    final StorageReference postImageRef = FirebaseStorage.instance.ref()
        .child('story images');

    var timeKey = new DateTime.now();

    //set non cropped images as cropped

    if (url1==null){url1=myimage;}
    if (url2==null){url2=myimage2;}
    if (url3==null){url3=myimage3;}
    if (url4==null){url4=myimage4;}
    if (url5==null){url5=myimage5;}


    ///upload image 1
    StorageUploadTask uploadTask =

    postImageRef.child(
        timeKey.toString() + ".jpg").putFile(url1);

    var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

 finalimage1 = ImageUrl.toString();

    ///upload image 2 if it's there, set it as '' if not
    if (url2==null)
    {finalimage2='';}
    else{
      final StorageReference postImageRef2 = FirebaseStorage.instance.ref()
          .child('story images');

      var timeKey2 = new DateTime.now();

      StorageUploadTask uploadTask2 =

      postImageRef2.child(
          timeKey2.toString() + ".jpg").putFile(url2);

      var ImageUrl2 = await (await uploadTask2.onComplete).ref.getDownloadURL();

      finalimage2 = ImageUrl2.toString();}

    ///upload image 3 if it's there, set it as '' if not
    if (url3==null)
    {finalimage3='';}
    else{
      final StorageReference postImageRef3 = FirebaseStorage.instance.ref()
          .child('story images');

      var timeKey3 = new DateTime.now();

      StorageUploadTask uploadTask3 =

      postImageRef3.child(
          timeKey3.toString() + ".jpg").putFile(url3);

      var ImageUrl3 = await (await uploadTask3.onComplete).ref.getDownloadURL();

      finalimage3 = ImageUrl3.toString();}

    ///upload image 4 if it's there, set it as '' if not
    if (url4==null)
    {finalimage4='';}
    else{
      final StorageReference postImageRef4 = FirebaseStorage.instance.ref()
          .child('story images');

      var timeKey4 = new DateTime.now();

      StorageUploadTask uploadTask4 =

      postImageRef4.child(
          timeKey4.toString() + ".jpg").putFile(url4);

      var ImageUrl4 = await (await uploadTask4.onComplete).ref.getDownloadURL();

      finalimage4 = ImageUrl4.toString();}
    ///upload image 5 if it's there, set it as '' if not
    if (url5==null)
    {finalimage5='';}
    else{
      final StorageReference postImageRef5 = FirebaseStorage.instance.ref()
          .child('story images');

      var timeKey5 = new DateTime.now();

      StorageUploadTask uploadTask5 =

      postImageRef5.child(
          timeKey5.toString() + ".jpg").putFile(url5);

      var ImageUrl5 = await (await uploadTask5.onComplete).ref.getDownloadURL();

      finalimage5 = ImageUrl5.toString();}

    if (finalimage1==null){finalimage1=oldimage;}
    if (finalimage2==null){finalimage2=oldimage2.toString();}
    if (finalimage3==null){finalimage3=oldimage3.toString();}
    if (finalimage4==null){finalimage4=oldimage4.toString();}
    if (finalimage5==null){finalimage5=oldimage5.toString();}


    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);
    int storyid=DateTime.now().millisecondsSinceEpoch;

    DatabaseReference ref = FirebaseDatabase.instance.reference();


    var data =
    {

      "date": date,
      "description": description,
      "image1": finalimage1,
      "image2": finalimage2,
      "image3": finalimage3,
      "image4": finalimage4,
      "image5": finalimage5,
      "time": time,
      "order" : ServerValue.timestamp,
      "storyid" : storyid,


    };
    print(storyid);
    ref.child("storys").child(storyid.toString()).set(data);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );

  }
  final myController = TextEditingController();



  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  void next () {
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (context, setState) {
                  // return object of type Dialog
                  return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      backgroundColor: Color(0xff1B8DC9).withOpacity(1),
                      title: new Text("last steps...", style: TextStyle(
                          fontFamily: 'apheriafont',
                          fontSize: 30.0,
                          color: Color(0xff98C7E3)),),
                      content: Container(
                          width: 150, height: 400,
                          child: Form(
                            key:formKey,
                            child: ListView(
                              children: <Widget>[
                                Text('add a description:',style: TextStyle(
                                    fontFamily: 'apheriafont',
                                    fontSize: 25.0,
                                    color: Colors.white),),
                                TextFormField(
                                  maxLines: 5,
                                  style: TextStyle(
                                      fontFamily: 'apheriafont',
                                      fontSize: 25.0,
                                      color: Color(0xff98C7E3)),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'write something!';
                                    }
                                    return null;
                                  },
                                  onSaved: (value)
                                  {
                                    return description = value;
                                  },
                                ),

                              ],
                            ),
                          )
                      ),

                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("close", style: TextStyle(
                              fontFamily: 'apheriafont',
                              fontSize: 30.0,
                              color: Color(0xff98C7E3)),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },

                        ),
                        FlatButton(
                          child: new Text("post", style: TextStyle(
                              fontFamily: 'apheriafont',
                              fontSize: 30.0,
                              color: Color(0xff98C7E3)),),
                          onPressed: () {
                            if (validateAndSave()) {
                              Navigator.of(context).pop();
                              post();
                            }},

                        )
                      ]);
                });
          }
      );

    }
    ); }

  void error(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
              title: new Text("oops!", style: TextStyle(
                  fontFamily: 'apheriafont',
                  fontSize: 30.0,
                  color: Color(0xff98C7E3)),),
              content: new Text("you must upload at least 1 image",
                style: TextStyle(fontFamily: 'apheriafont',
                    fontSize: 25.0,
                    color: Colors.black),),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("close", style: TextStyle(
                      fontFamily: 'apheriafont',
                      fontSize: 30.0,
                      color: Color(0xff98C7E3)),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },

                )
              ]);
        }
    );}

  Future getImage() async
  {
    var tempImage = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);

    setState(() {
      myimage = tempImage;
    });
  }

  Future getImage2() async
  {
    var tempImage2 = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);

    setState(() {
      myimage2 = tempImage2;
    });
  }

  Future getImage3() async
  {
    var tempImage3 = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);

    setState(() {
      myimage3 = tempImage3;
    });
  }

  Future getImage4() async
  {
    var tempImage4 = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);

    setState(() {
      myimage4 = tempImage4;
    });
  }

  Future getImage5() async
  {
    var tempImage5 = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);

    setState(() {
      myimage5 = tempImage5;
    });
  }


  @override

  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
        appBar: AppBar(backgroundColor: Color(0xff98C7E3),),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Color(0xff98C7E3),
            label: Text('next',
                style: TextStyle(fontFamily: "apheriafont", fontSize: 30,color: Color(0xff1B8DC9))),
            icon: Icon(Icons.send, color: Color(0xff1B8DC9).withOpacity(0.5)),
            onPressed: () {
              print(myimage.toString());
              if (myimage != null) {
                next();
              }
              else {
                error();
              }
            }),
        extendBodyBehindAppBar: true,
        body: Container(
         color:Colors.white,
          child: ListView(children: <Widget>[
            (myimage == null) ?
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                    height: 266,
                    child: Card(
                        color: Colors.transparent,elevation:0.0,
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: getImage,
                                  child:
                                  Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("upload image",
                                            style: TextStyle(fontSize: 25,fontFamily: 'apheriafont',
                                                color: Color(0xff1B8DC9).withOpacity(0.5))),
                                      )),
                                ),
                              )
                            ]))))
                :
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: ListTile(
                title:Card(
                  color:Colors.transparent,elevation: 0.0,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: (url1 != null) ?
                  Image.file(url1,cacheWidth: 750,)
                      :
                  Image.file(myimage,cacheWidth: 750,),

                ),
                trailing: IconButton(icon: Icon(Icons.edit,color:Color(0xff98C7E3).withOpacity(0.5),size: 50,), onPressed: getImage),
              ),
            ),
            (myimage2 != null) ?
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: ListTile(
                title:Card(
                  color:Colors.transparent,elevation: 0.0,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: (url2 != null) ?
                  Image.file(url2,cacheWidth: 750,)
                      :
                  Image.file(myimage2,cacheWidth: 750,),
                ),
                trailing: IconButton(icon: Icon(Icons.edit,color:Color(0xff98C7E3).withOpacity(0.5),size: 50,), onPressed: getImage2),
              ),
            )
                :
            (myimage!=null) ?

            Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                    height: 266,
                    child: Card(
                        color: Colors.transparent,elevation:0.0,
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: getImage2,
                                  child:
                                  Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("upload a 2nd image",
                                            style: TextStyle(fontSize: 25,fontFamily: 'apheriafont',
                                                color: Color(0xff1B8DC9).withOpacity(0.5))),
                                      )),
                                ),
                              )
                            ]))))
                :

            Container(),
            (myimage3 != null) ?
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: ListTile(
                title:Card(
                  color:Colors.transparent,elevation: 0.0,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: (url3 != null) ?
                  Image.file(url3,cacheWidth: 750,)
                      :
                  Image.file(myimage3,cacheWidth: 750,),
                ),
                trailing: IconButton(icon: Icon(Icons.edit,color:Color(0xff98C7E3).withOpacity(0.5),size: 50,), onPressed: getImage3),
              ),
            )
                :
            (myimage2!=null) ?

            Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                    height: 266,
                    child: Card(
                        color: Colors.transparent,elevation:0.0,
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: getImage3,
                                  child:
                                  Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("upload a 3rd image",
                                            style: TextStyle(fontSize: 25,fontFamily: 'apheriafont',
                                                color: Color(0xff1B8DC9).withOpacity(0.5))),
                                      )),
                                ),
                              )
                            ]))))
                :

            Container(),
            (myimage4 != null) ?
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: ListTile(
                title:Card(
                  color:Colors.transparent,elevation: 0.0,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: (url4 != null) ?
                  Image.file(url4,cacheWidth: 750,)
                      :
                  Image.file(myimage4,cacheWidth: 750,),
                ),
                trailing: IconButton(icon: Icon(Icons.edit,color:Color(0xff98C7E3).withOpacity(0.5),size: 50,), onPressed: getImage4),
              ),
            )
                :
            (myimage3!=null) ?

            Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                    height: 266,
                    child: Card(
                        color: Colors.transparent,elevation:0.0,
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: getImage4,
                                  child:
                                  Container(
child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("upload a 4th image",
                                            style: TextStyle(fontSize: 25,fontFamily: 'apheriafont',
                                                color: Color(0xff1B8DC9).withOpacity(0.5))),
                                      )),
                                ),
                              )
                            ]))))
                :

            Container(),
            (myimage5 != null) ?
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: ListTile(
                title:Card(
                  color:Colors.transparent,elevation: 0.0,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: (url5 != null) ?
                  Image.file(url5,cacheWidth: 750,)
                  :
                  Image.file(myimage5,cacheWidth: 750,),
                ),
                trailing: IconButton(icon: Icon(Icons.edit,color:Color(0xff98C7E3).withOpacity(0.5),size: 50,), onPressed: getImage5),
              ),
            ):
            (myimage4!=null) ?

            Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                    height: 266,
                    child: Card(
                        color: Colors.transparent,elevation:0.0,
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: getImage5,
                                  child:
                                  Container(
child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("upload a 5th image",
                                            style: TextStyle(fontSize: 25,fontFamily: 'apheriafont',
                                                color: Color(0xff1B8DC9).withOpacity(0.5))),
                                      )),
                                ),
                              )
                            ]))))
                :

            Container(),
          ]),
        ));

  }

}