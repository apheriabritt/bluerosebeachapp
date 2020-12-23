import 'dart:io';
import 'package:bluerosebeachapp/constants/constants.dart';
import 'package:bluerosebeachapp/constants/loading.dart';
import 'package:bluerosebeachapp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class getStoryImagesData

{
  int storyid;
  String description,oldimage1,oldimage2,oldimage3,oldimage4,oldimage5;
  getStoryImagesData(this.storyid,this.description,this.oldimage1,this.oldimage2,this.oldimage3,this.oldimage4,this.oldimage5);
}

class EditImages extends StatefulWidget {
  EditImages(this.storyimagesdata);

  getStoryImagesData storyimagesdata;
  @override
  _EditImagesState createState() => _EditImagesState(this.storyimagesdata);
}

class _EditImagesState extends State<EditImages> {
  _EditImagesState(this.storyimagesdata);
  getStoryImagesData storyimagesdata;
  final formKey = new GlobalKey<FormState>();
  final newformKey = new GlobalKey<FormState>();

  bool loading;

  File url1;
  File url2;
  File url3;
  File url4;
  File url5;

  String oldimage1;
  String oldimage2;
  String oldimage3;
  String oldimage4;
  String oldimage5;



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
  String description;

  @override
  void initState() {
    super.initState();
    print(description);
    print("old image 1: ${storyimagesdata.oldimage1.toString()}");
    print("old image 2: ${storyimagesdata.oldimage2.toString()}");
    print("old image 3: ${storyimagesdata.oldimage3.toString()}");
    print("old image 4: ${storyimagesdata.oldimage4.toString()}");
    print("old image 5: ${storyimagesdata.oldimage5.toString()}");





    if(storyimagesdata.oldimage1!=null)
    {oldimage1= storyimagesdata.oldimage1;}
    else{
      oldimage1=null;}

    if(storyimagesdata.oldimage2!='')
    {oldimage2= storyimagesdata.oldimage2;}
    else{
      oldimage2=null;}

    if(storyimagesdata.oldimage3!='')
    {oldimage3= storyimagesdata.oldimage3;}
    else{
      oldimage3=null;}

    if(storyimagesdata.oldimage4!='')
    {oldimage4= storyimagesdata.oldimage4;}
    else{
      oldimage4=null;}

    if(storyimagesdata.oldimage5!='')
    {oldimage5= storyimagesdata.oldimage5;}
    else{
      oldimage5=null;}


    print("show image 1: ${oldimage1.toString()}");
    print("show image 2: ${oldimage2.toString()}");
    print("show image 3: ${oldimage3.toString()}");
    print("show image 4: ${oldimage4.toString()}");
    print("show image 5: ${oldimage5.toString()}");



  }


  bool validateAndSave() {
    final form = formKey.currentState;
    final newform = newformKey.currentState;


    if (form.validate()) {
      form.save();
      return true;
    }
    else {
      return false;
    }

  }

  bool newvalidateAndSave() {
    final form = formKey.currentState;
    final newform = newformKey.currentState;


    if (newform.validate()) {
      newform.save();
      return true;
    }
    else {
      return false;
    }

  }

  void postimages () async {
    this.setState(() {
      loading = true;
    });
    if(description==null){
      print('description is null');
      description=storyimagesdata.description;}


    final StorageReference postImageRef = FirebaseStorage.instance.ref()
        .child('story images');

    var timeKey = new DateTime.now();

    if (myimage != null) {
      url1 = myimage;
    }
    if (myimage2 != null) {
      url2 = myimage2;
    }
    if (myimage3 != null) {
      url3 = myimage3;
    }
    if (myimage4 != null) {
      url4 = myimage4;
    }
    if (myimage5 != null) {
      url5 = myimage5;
    }


    if (url1 != null) {
      StorageUploadTask uploadTask =

      postImageRef.child(
          timeKey.toString() + ".jpg").putFile(url1);

      var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      finalimage1 = ImageUrl.toString();
    }
    ///upload image 2 if it's there, set it as '' if not
    if (url2 != null) {
      final StorageReference postImageRef2 = FirebaseStorage.instance.ref()
          .child('story images');

      var timeKey2 = new DateTime.now();

      StorageUploadTask uploadTask2 =

      postImageRef2.child(
          timeKey2.toString() + ".jpg").putFile(url2);

      var ImageUrl2 = await (await uploadTask2.onComplete).ref
          .getDownloadURL();

      finalimage2 = ImageUrl2.toString();
    }

    ///upload image 3 if it's there, set it as '' if not
    if (url3 != null) {
      final StorageReference postImageRef3 = FirebaseStorage.instance.ref()
          .child('story images');

      var timeKey3 = new DateTime.now();

      StorageUploadTask uploadTask3 =

      postImageRef3.child(
          timeKey3.toString() + ".jpg").putFile(url3);

      var ImageUrl3 = await (await uploadTask3.onComplete).ref
          .getDownloadURL();

      finalimage3 = ImageUrl3.toString();
    }

    ///upload image 4 if it's there, set it as '' if not
    if (url4 != null) {
      final StorageReference postImageRef4 = FirebaseStorage.instance.ref()
          .child('story images');

      var timeKey4 = new DateTime.now();

      StorageUploadTask uploadTask4 =

      postImageRef4.child(
          timeKey4.toString() + ".jpg").putFile(url4);

      var ImageUrl4 = await (await uploadTask4.onComplete).ref
          .getDownloadURL();

      finalimage4 = ImageUrl4.toString();
    }

    ///upload image 5 if it's there, set it as '' if not
    if (url5 != null) {
      final StorageReference postImageRef5 = FirebaseStorage.instance.ref()
          .child('story images');

      var timeKey5 = new DateTime.now();

      StorageUploadTask uploadTask5 =

      postImageRef5.child(
          timeKey5.toString() + ".jpg").putFile(url5);

      var ImageUrl5 = await (await uploadTask5.onComplete).ref
          .getDownloadURL();

      finalimage5 = ImageUrl5.toString();
    }


    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('hh:mm aaa');


    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    int storyid = DateTime
        .now()
        .millisecondsSinceEpoch;

    if (finalimage1==null){finalimage1=storyimagesdata.oldimage1.toString();}
    if (finalimage2==null){finalimage2=storyimagesdata.oldimage2.toString();}
    if (finalimage3==null){finalimage3=storyimagesdata.oldimage3.toString();}
    if (finalimage4==null){finalimage4=storyimagesdata.oldimage4.toString();}
    if (finalimage5==null){finalimage5=storyimagesdata.oldimage5.toString();}

    DatabaseReference ref = FirebaseDatabase.instance.reference();
print('uploading...');
    print(description);

    var data =
    {

      "description": description,
      "image1": finalimage1,
      "image2": finalimage2,
      "image3": finalimage3,
      "image4": finalimage4,
      "image5": finalimage5,


    };
    print(storyid);
    ref.child("storys")
        .child(storyimagesdata.storyid.toString())
        .update(data);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }


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
                            key:newformKey,
                            child: ListView(
                              children: <Widget>[
                                Text('add a description:',style: TextStyle(
                                    fontFamily: 'apheriafont',
                                    fontSize: 25.0,
                                    color: Colors.white),),
                                TextFormField(
                                  maxLines: 5,
                                  initialValue: storyimagesdata.description,
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
                                    print('saved');print(description);
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
                            if (newvalidateAndSave()) {
                              Navigator.of(context).pop();
                              postimages();
                              //myhomepage
                            }},

                        )
                      ]);
                });
          }
      );

    }
    ); }

  @override
  Widget build(BuildContext context) {
    return loading==true?Loading():Scaffold(
        backgroundColor:Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xff98C7E3),
        ),
        extendBodyBehindAppBar: true,
        floatingActionButton:FloatingActionButton.extended(
            backgroundColor: Color(0xff1B8DC9),
            onPressed: () {
          if (validateAndSave()) {
            next();
          }
        }, label: Text('update',style: TextStyle(
            fontFamily: 'apheriafont',
            fontSize: 30.0,
            color: Color(0xff98C7E3)))),
        body:
        Container(
            child: Card(
              color:Colors.white.withOpacity(0.9),
              child: Form(
                key: formKey,
                child: ListView(children: <Widget>[
                  (myimage != null||oldimage1!=null) ?
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
                        child: (myimage==null)?
                        Image.network(oldimage1,cacheWidth: 750,):
                        Image.file(myimage,cacheWidth: 750,),
                      ),
                      trailing: IconButton(icon: Icon(Icons.edit,color:Color(0xff98C7E3),size: 50,), onPressed: getImage),
                    ),
                  )
                      :
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                          child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      height: 200,
                                      width: 200, child:
                                  (myimage==null)?
                                  Image.network(oldimage1):
                                  Image.file(myimage)
                                  ),
                                ),
                                Container(
                                  height: 150,
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: getImage,
                                        child: Container(
                                            decoration: gradientBox,
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .all(8.0),
                                              child: Text(
                                                  'replace image',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors
                                                          .white)),
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              ]))),
                  (myimage2 != null||oldimage2!=null) ?
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
                        child: (myimage2==null)?
                        Image.network(oldimage2,cacheWidth: 750,):
                        Image.file(myimage2,cacheWidth: 750,),
                      ),
                      trailing: IconButton(icon: Icon(Icons.edit,color:Color(0xff98C7E3),size: 50,), onPressed: getImage2),
                    ),
                  )
                      :
                  ((oldimage1!= null&&oldimage2==null)||(myimage!=null)) ?

                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                          height: 266,
                          child: Card(
                              color: Colors.transparent, elevation: 0.0,
                              child: new Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center,
                                  children: <Widget>[
                                    new Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: getImage2,
                                        child:
                                        Container(
                                            decoration: gradientBox,
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .all(8.0),
                                              child: Text(
                                                  "upload a 2nd image",
                                                  style: TextStyle(
                                                    fontFamily: 'apheriafont',
                                                      fontSize: 25,
                                                      color: Colors
                                                          .white)),
                                            )),
                                      ),
                                    )
                                  ]))))
                      :

                  Container(),
                  (myimage3 != null||oldimage3!=null) ?
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
                        child: (myimage3==null)?
                        Image.network(oldimage3,cacheWidth: 750,):
                        Image.file(myimage3,cacheWidth: 750,),
                      ),
                      trailing: IconButton(icon: Icon(Icons.edit,color:Color(0xff98C7E3),size: 50,), onPressed: getImage3),
                    ),
                  ):
                  ((oldimage2 != null&&oldimage3==null)||(myimage2!=null)) ?

                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                          height: 266,
                          child: Card(
                              color: Colors.transparent, elevation: 0.0,
                              child: new Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center,
                                  children: <Widget>[
                                    new Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: getImage3,
                                        child:
                                        Container(
                                            decoration: gradientBox,
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .all(8.0),
                                              child: Text(
                                                  "upload a 3rd image",
                                                  style: TextStyle(
                                                      fontFamily: 'apheriafont',
                                                      fontSize: 25,
                                                      color: Colors
                                                          .white)),
                                            )),
                                      ),
                                    )
                                  ]))))
                      :

                  Container(),
                  (myimage4 != null||oldimage4!=null) ?
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
                        child: (myimage4==null)?
                        Image.network(oldimage4,cacheWidth: 750,):
                        Image.file(myimage4,cacheWidth: 750,),
                      ),
                      trailing: IconButton(icon: Icon(Icons.edit,color:Color(0xff98C7E3),size: 50,), onPressed: getImage4),
                    ),
                  )
                      :
                  ((oldimage3 != null&&oldimage4==null)||(myimage3!=null)) ?

                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                          height: 266,
                          child: Card(
                              color: Colors.transparent, elevation: 0.0,
                              child: new Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center,
                                  children: <Widget>[
                                    new Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: getImage4,
                                        child:
                                        Container(
                                            decoration: gradientBox,
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .all(8.0),
                                              child: Text(
                                                  "upload a 4th image",

                                                  style: TextStyle(
                                                      fontFamily: 'apheriafont',
                                                      fontSize: 25,
                                                      color: Colors
                                                          .white)),
                                            )),
                                      ),
                                    )
                                  ]))))
                      :

                  Container(),
                  (myimage5 != null||oldimage5!=null) ?
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
                        child: (myimage5==null)?
                        Image.network(oldimage5,cacheWidth: 750,):
                        Image.file(myimage5,cacheWidth: 750,),
                      ),
                      trailing: IconButton(icon: Icon(Icons.edit,color:Color(0xff98C7E3),size: 50,), onPressed: getImage5),
                    ),
                  )
                      :
                  ((oldimage4 != null&&oldimage5==null)||(myimage4!=null)) ?

                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                          height: 266,
                          child: Card(
                              color: Colors.transparent, elevation: 0.0,
                              child: new Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center,
                                  children: <Widget>[
                                    new Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: getImage5,
                                        child:
                                        Container(
                                            decoration: gradientBox,
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .all(8.0),
                                              child: Text(
                                                  "upload a 5th image",
                                                  style: TextStyle(
                                                      fontFamily: 'apheriafont',
                                                      fontSize: 25,
                                                      color: Colors
                                                          .white)),
                                            )),
                                      ),
                                    )
                                  ]))))
                      :

                  Container(),

                ]),
              ),
            )
        )
    );
  }
}