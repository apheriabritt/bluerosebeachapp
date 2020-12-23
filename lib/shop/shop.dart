import 'package:bluerosebeachapp/constants/constants.dart';
import 'package:bluerosebeachapp/main.dart';
import 'package:bluerosebeachapp/shop/editshopimages.dart';
import 'package:bluerosebeachapp/shop/uploadshop.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {

  List<Shops> shopsList = [];


  @override
  void initState() {
    super.initState();
    initial();

  }

  void initial() async{
    DatabaseReference postsRef = FirebaseDatabase.instance.reference().child(
        "shops");
    postsRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      shopsList.clear();

      for (var individualKey in KEYS) {
        Shops shops = new Shops(
          DATA[individualKey]['date'],
          DATA[individualKey]['description'],
          DATA[individualKey]['price'],
          DATA[individualKey]['image1'],
          DATA[individualKey]['image2'],
          DATA[individualKey]['image3'],
          DATA[individualKey]['image4'],
          DATA[individualKey]['image5'],
          DATA[individualKey]['time'],
          DATA[individualKey]['order'],
          DATA[individualKey]['shopid'],

        );
        shopsList.add(shops);
        shopsList.sort((b, a) {
          var adate = a.order;
          var bdate = b.order;
          return adate.compareTo(bdate);
        }

        );
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff1B8DC9),
          child:Icon(Icons.add),onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UploadShop()),
          );
        },
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: shopsList.length,
                  itemBuilder: (_, index) {
                    print('building ui');
                    return ShopUI(
                      shopsList[index].date,
                      shopsList[index].description,
                      shopsList[index].price,
                      shopsList[index].image1,
                      shopsList[index].image2,
                      shopsList[index].image3,
                      shopsList[index].image4,
                      shopsList[index].image5,
                      shopsList[index].time,
                      shopsList[index].order,
                      shopsList[index].shopid,



                    );}),
              SizedBox(height:100)
            ],

          ),
        )

    );
  }
}

Widget ShopUI(String date, description,price,image1,image2,image3,image4,image5,time,int order,shopid) {
  String image = image1;
  return StatefulBuilder(
      builder: (context, setState) {
        void delete(){
          DatabaseReference ref = FirebaseDatabase.instance.reference();
          ref.child("shops").child(shopid.toString()).remove();
        }


        void deletecheck(){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  backgroundColor: Color(0xff1B8DC9).withOpacity(1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  title: new Text("just checking...", style: TextStyle(
                      fontFamily: 'apheriafont',
                      fontSize: 30.0,
                      color:Color(0xff98C7E3)),),
                  content: Container(
                    height:200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        new Text("are you sure you want to delete?",
                          style: TextStyle(fontFamily: 'apheriafont',
                              fontSize: 25.0,
                              color: Color(0xff98C7E3)),),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FlatButton(
                              child: new Text("no...", style: TextStyle(
                                  fontFamily: 'apheriafont',
                                  fontSize: 30.0,
                                  color: Color(0xff98C7E3))),
                              onPressed: () {
                                Navigator.pop(context);
                              },

                            ),
                            FlatButton(
                              child: new Text("yes", style: TextStyle(
                                  fontFamily: 'apheriafont',
                                  fontSize: 30.0,
                                  color: Color(0xff98C7E3)),),
                              onPressed: () {
                                delete();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyHomePage()),
                                );
                              },

                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        }

        print('setting state');
        Widget GalleryWidget;
        if (image2 == '') {
          GalleryWidget = ListTile(title: Card(
            color: Color(0xff98C7E3).withOpacity(0.5),
            elevation: 0.0,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),

            child: Image.network(
                image
            ),
          ),);
        } else {
          GalleryWidget = ListTile(
              trailing: GestureDetector(
                  onTap: () {
                    if (image == image1 && image2 != "") {
                      print('should have worked');
                      setState(() {
                        image = image2;
                      });
                    }
                    else if (image == image1 && image2 == "") {
                      print('null');
                      setState(() {
                        image = image1;
                      });
                    }
                    else if (image == image2 && image3 == "") {
                      print('null');
                      setState(() {
                        image = image1;
                        description = description;
                      });
                    }
                    else if (image == image2 && image3 != "") {
                      print('this should work');
                      setState(() {
                        image = image3;
                      });
                    }
                    else if (image == image3 && image4 == "") {
                      print('null');
                      setState(() {
                        image = image1;
                      });
                    }
                    else if (image == image3 && image4 != "") {
                      setState(() {
                        image = image4;
                      });
                    }
                    else if (image == image4 && image5 == "") {
                      print('null');
                      setState(() {
                        image = image1;
                      });
                    }
                    else if (image == image4 && image5 != "") {
                      setState(() {
                        image = image5;
                      });
                    }
                    else if (image == image5)
                      setState(() {
                        image = image1;
                      });
                    else {
                      print('error');
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios, color: Color(0xff98C7E3))),
              title: Card(
                color: Color(0xff98C7E3).withOpacity(0.5),
                elevation: 0.0,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),

                child: Image.network(
                    image
                ),
              ),
              leading: GestureDetector(
                  onTap: () {
                    if (image == image1) {
                      setState(() {
                        null;
                      });
                    }
                    else if (image == image2) {
                      setState(() {
                        image = image1;
                      });
                    }
                    else if (image == image3) {
                      setState(() {
                        image = image2;
                      });
                    }
                    else if (image == image4) {
                      setState(() {
                        image = image3;
                      });
                    }
                    else if (image == image5) {
                      setState(() {
                        image = image4;
                      });
                    }
                  },
                  child: Icon(Icons.arrow_back_ios, color: Color(0xff98C7E3)))
          );
        }
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Color(0xff98C7E3).withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 0.0,
                child: Column(
                  children: <Widget>[
                    GalleryWidget,
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(description,style:TextStyle(fontFamily: 'apheriafont',fontSize: 25,color: Color(0xff1B8DC9))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(price,style:TextStyle(fontFamily: 'apheriafont',fontSize: 25,color: Color(0xff1B8DC9))),
                    ),

                  ],
                ),
              ),
            ),
            Positioned(
                bottom:0,
                left:0,
                child: Container(height:40,width:40,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: FloatingActionButton(
                          heroTag:shopid,
                          onPressed: (){
                            getShopImagesData storyimagesdata;
                            storyimagesdata=getShopImagesData(shopid,description,price,image1,image2,image3,image4,image5);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditImages(storyimagesdata)),
                            );

                          },
                          backgroundColor: Color(0xff1B8DC9),
                          child:Icon(Icons.edit)),
                    ))),
            Positioned(
                bottom:0,
                right:0,
                child: Container(height:40,width:40,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: FloatingActionButton(
                          heroTag:'${shopid}delete',
                          onPressed:deletecheck,
                          backgroundColor: Color(0xff1B8DC9),
                          child:Icon(Icons.delete)),
                    ))),
          ],
        );
      });
}
