import 'package:bluerosebeachapp/constants/constants.dart';
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
          child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: shopsList.length,
              itemBuilder: (_, index) {
                print('building ui');
                return ShopUI(
                  shopsList[index].date,
                  shopsList[index].description,
                  shopsList[index].image1,
                  shopsList[index].image2,
                  shopsList[index].image3,
                  shopsList[index].image4,
                  shopsList[index].image5,
                  shopsList[index].time,
                  shopsList[index].order,
                  shopsList[index].shopid,



                );}),
        )

    );
  }
}

Widget ShopUI(String date, description,image1,image2,image3,image4,image5,time,int order,shopid) {
  String image = image1;
  return StatefulBuilder(
      builder: (context, setState) {
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
        return Card(
          color: Color(0xff98C7E3).withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 0.0,
          child: Column(
            children: <Widget>[
              GalleryWidget,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(description,style:TextStyle(fontFamily: 'apheriafont',fontSize: 25,color: Color(0xff1B8DC9))),
              ),

            ],
          ),
        );
      });
}
