import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhouse/helpers/seller-api.dart';
//import 'package:findhouse/notifiers/home_searcher/propertiesNotifier.dart';
import 'package:findhouse/notifiers/property_owner/properties.dart';
import 'package:findhouse/notifiers/user_notifier.dart';
import 'package:findhouse/screens/home_searcher/detailsscreen.dart';
import 'package:findhouse/screens/property_owner/add_property.dart';
import 'package:findhouse/widgets/custom_menu.dart';
import 'package:flutter/material.dart';
import 'package:findhouse/models/properties.dart';

import 'package:provider/provider.dart';

class Apartments extends StatefulWidget{
  @override
  _ApartmentsState createState() => _ApartmentsState();

}
class _ApartmentsState extends State<Apartments>{

  //var data = getProperties(propertyNotifier);
  //var data = Properties.list;
  //final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;


  void initState() {
    UserNotifier userNotifier= Provider.of<UserNotifier>(context, listen: false);
    getProperties(userNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //PropertyNotifier propertyNotifier = Provider.of<PropertyNotifier>(context);
    final userNotifier = Provider.of<UserNotifier>(context);

    Future<void> _propertiesList() async {
      getProperties(userNotifier);
    }
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.15;
    final double categoryWidth = size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Property Finder",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black38,
              ),
              onPressed: () {
                showSearch(
                );
              },
            ),


            IconButton(
              icon: Icon(
                Icons.filter_list,
                color: Colors.black38,
              ),
              onPressed: () {},
            ),
          ]

      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text(
              "My Properties",
              style: TextStyle(color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 12,
              ),
            ),
            /* Text(
              "50 results in your area",
              style: TextStyle(
                color: Colors.black38),
              ),*/
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: userNotifier.propertiesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTapUp: (details) async {
                        double dx = details.globalPosition.dx;
                        double dy = details.globalPosition.dy;
                        double dx2 = MediaQuery.of(context).size.width - dx;
                        double dy2 = MediaQuery.of(context).size.width - dy;
                        await showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                        items: [
                        MyPopupMenuItem(
                        onClick: () {
                        Navigator.pushNamed(context, AddProductsScreen.id,
                        arguments: userNotifier.propertiesList[index]);
                        },
                        child: Text('Edit'),
                        ),
                        MyPopupMenuItem(
                        onClick: () {
                        userNotifier.deleteproperty(userNotifier.propertiesList[index].id);
                        Navigator.pop(context);
                        },
                        child: Text('Delete'),
                        ),
                        ]);
                      },
                      child: _buildItem(context, index));
                },
              ),
            )
          ],
        ),
      ),
    );

  }

  Widget _buildItem(BuildContext, int index){
    //PropertyNotifier propertyNotifier = Provider.of<PropertyNotifier>(context);
    UserNotifier userNotifier= Provider.of<UserNotifier>(context, listen: false);

    Future<void> _refreshList() async {
      getProperties(userNotifier);
    }
    return Container(
      padding: EdgeInsets.all(6),
      height: 250,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      userNotifier.propertiesList[index].image != null ? userNotifier.propertiesList[index].image : "https://firebasestorage.googleapis.com/v0/b/drinkapp-16c27.appspot.com/o/house.jpg?alt=media&token=bf4da456-5a6f-41ee-988b-a57c0baf17e3",
                    ),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 1,
                      color: Colors.black12,
                    )
                  ]),
              child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        gradient:LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black87,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20,
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: 12,
                            left: 40,
                            right: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width*.2,
                                child:Text(
                                  "${userNotifier.propertiesList[index].name}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(6),
                                child: Icon(
                                  Icons.directions,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    )
                                ),
                              )
                            ],
                          ),
                        )
                    )
                  ]
              ),
            ),
          ),
          _buildDescription(context, index)
        ],
      ),
    );
  }
  Align _buildDescription(BuildContext context, int index) {
    //PropertyNotifier propertyNotifier = Provider.of<PropertyNotifier>(context);

    UserNotifier userNotifier= Provider.of<UserNotifier>(context, listen: false);

    Future<void> _refreshList() async {
      getProperties(userNotifier);
    }
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width * .45,
            height: 200,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 1,
                    color: Colors.black12,
                  )
                ]),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Available ${userNotifier.propertiesList[index].bedRoomNo} bedroom in ${userNotifier.propertiesList[index].location} for rent",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                      children: <Widget>[
                        Text(
                            userNotifier.propertiesList[index].location,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            )
                        )
                      ]),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                          'Ksh ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          )
                      ),
                      Text(
                          userNotifier.propertiesList[index].price,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                              color: Colors.black
                          )
                      ),
                      Text(
                          "/month",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                              color: Colors.black
                          )
                      )

                    ],
                  ),

                  /*Row(
                    children: <Widget>[
                      RatingBar(
                        onRatingUpdate: (v) {},
                        initialRating: data[index].review,
                        itemSize: 12,
                        itemBuilder: (context, index) =>
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                      ),
                      Text(
                        "${data[index].reviewCount.toInt()} reviews",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),*/

                  Row(
                    children: <Widget>[
                      /*...data[index].personImages.map(
                                    (img) {
                                  return Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: ExactAssetImage(

                                                "Assets/$img.jpg"),
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          )
                                      )
                                  );
                                },
                              ),*/
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "new",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white),

                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:<Widget>[
                          Text(userNotifier.propertiesList[index].bedRoomNo, style: TextStyle(color: Colors.blueAccent, fontSize:20 ),),
                          Icon(
                            Icons.airline_seat_flat, size:25, color: Colors.amber,),

                        ],
                      )
                    ],
                  ),

                  Text("______room______", style: TextStyle(color: Colors.blueAccent, fontSize:15 ),),
                  Wrap(
                      children: <Widget>[
                        /*...propertyNotifier.propertiesList[index].features.map(
                                (feature) {
                              return Container(
                                padding: EdgeInsets.all(6),
                                margin: EdgeInsets.only(
                                    bottom: 6,
                                    right: 6
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  color: AppColors.stylecolor,
                                ),
                                child: Text(
                                  feature,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white),
                                ),
                              );
                            }

                        )*/
                      ]
                  )
                ]
            )
        )
    );
  }
}
