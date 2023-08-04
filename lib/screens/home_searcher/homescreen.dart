import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhouse/helpers/properties_api.dart';
import 'package:findhouse/helpers/screen_navigation.dart';
import 'package:findhouse/notifiers/app.dart';
import 'package:findhouse/notifiers/home_searcher/propertiesNotifier.dart';
import 'package:findhouse/notifiers/property_owner/category.dart';
import 'package:findhouse/notifiers/property_owner/properties.dart';
import 'package:findhouse/notifiers/user_notifier.dart';
import 'package:findhouse/screens/home_searcher/category.dart';
import 'package:findhouse/screens/home_searcher/detailsscreen.dart';
import 'package:findhouse/screens/home_searcher/maps.dart';
import 'package:findhouse/screens/login_screen.dart';
import 'package:findhouse/widgets/categories.dart';
import 'package:findhouse/widgets/custom_menu.dart';
import 'package:findhouse/widgets/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:findhouse/models/properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //var data = getProperties(propertyNotifier);
  //var data = ApartmentModel.list;
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  void initState() {
    PropertyNotifier propertyNotifier =
        Provider.of<PropertyNotifier>(context, listen: false);
    getProperties(propertyNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PropertyNotifier propertyNotifier = Provider.of<PropertyNotifier>(context);

    Future<void> _propertiesList() async {
      getProperties(propertyNotifier);
    }

    final app = Provider.of<AppNotifier>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final user = Provider.of<UserNotifier>(context);
    final productProvider = Provider.of<PropertiesProvider>(context);
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.15;
    final double categoryWidth = size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Property Finder Estate",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(),
                );
              },
            ),
          ]),

      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Container(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryProvider.categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                              app.changeLoading();
                        await productProvider.loadPropertiesByCategory(
                            categoryName:
                            categoryProvider.categories[index].name);

                        changeScreen(
                            context,
                            CategoryScreen(
                              categoryModel:
                              categoryProvider.categories[index],
                            ));

//                              app.changeLoading();

                      },
                      child: CategoryWidget(
                        category: categoryProvider.categories[index],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Our Properties",
              style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              textAlign: TextAlign.center,
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
                itemCount: propertyNotifier.propertiesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        propertyNotifier.currentProperty =
                            propertyNotifier.propertiesList[index];
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return DetailsScreen();
                        }));
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

  Widget _buildItem(BuildContext, int index) {
    PropertyNotifier propertyNotifier = Provider.of<PropertyNotifier>(context);

    Future<void> _refreshList() async {
      getProperties(propertyNotifier);
    }

    return Container(
      padding: EdgeInsets.all(6),
      height: 250,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      propertyNotifier.propertiesList[index].image != null
                          ? propertyNotifier.propertiesList[index].image
                          : "https://firebasestorage.googleapis.com/v0/b/drinkapp-16c27.appspot.com/o/house.jpg?alt=media&token=bf4da456-5a6f-41ee-988b-a57c0baf17e3",
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
              child: Stack(fit: StackFit.expand, children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black87,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        20,
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        //bottom: 12,
                        left: 20,
                        right: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          MaterialButton(
                            onPressed:() async{
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context)=>Maps()));
                    },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              child: Text(
                                "View on map",
                                style:TextStyle(color: Colors.white)
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  )),
                            ),
                          )
                        ],
                      ),
                    )),
                Align(
                    alignment: Alignment.bottomCenter,
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
                            width: MediaQuery.of(context).size.width * .2,
                            child: Text(
                              "${propertyNotifier.propertiesList[index].name}",
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
                                )),
                          )
                        ],
                      ),
                    ))
              ]),
            ),
          ),
          _buildDescription(context, index)
        ],
      ),
    );
  }

  Align _buildDescription(BuildContext context, int index) {
    PropertyNotifier propertyNotifier = Provider.of<PropertyNotifier>(context);

    Future<void> _refreshList() async {
      getProperties(propertyNotifier);
    }

    return Align(
        alignment: Alignment.centerRight,
        child: Container(
            width: MediaQuery.of(context).size.width * .45,
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
                    "Available ${propertyNotifier.propertiesList[index].bedRoomNo} bedroom in ${propertyNotifier.propertiesList[index].location} for rent",
                    style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold,),
                  ),
                  Row(children: <Widget>[
                    Text(propertyNotifier.propertiesList[index].location, style: TextStyle(fontSize: 11, color: Colors.black38, fontWeight: FontWeight.bold,
                        ))
                  ]),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('Ksh ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      Text(propertyNotifier.propertiesList[index].price.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      Text("/month",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ))
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
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            propertyNotifier.propertiesList[index].bedRoomNo,
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 20),
                          ),
                          Icon(
                            Icons.airline_seat_flat,
                            size: 25,
                            color: Colors.amber,
                          ),
                        ],
                      )
                    ],
                  ),
                  Text(
                    "______room______",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                  ),
                  Wrap(children: <Widget>[
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
                  ])
                ])));
  }
}

class DataSearch extends SearchDelegate<String> {

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {

            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
          color: Colors.blueAccent,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    PropertyNotifier propertyNotifier = Provider.of<PropertyNotifier>(context);

    Future<void> _refreshList() async {
      getProperties(propertyNotifier);
    }

    return DetailsScreen();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    PropertyNotifier propertyNotifier = Provider.of<PropertyNotifier>(context);

    Future<void> _refreshList() async {
      getProperties(propertyNotifier);
    }

    final myList = query.isEmpty
        ? propertyNotifier.propertiesList
        : propertyNotifier.propertiesList
            .where((p) => p.name.toLowerCase().contains(query.toLowerCase()) || p.location.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return myList.isEmpty
        ? Text(
            'No results found...',
            style: TextStyle(fontSize: 20, ),
          )
        : ListView.builder(
            itemCount: myList.length,
            itemBuilder: (context, index) {
              final Properties listitem = myList[index];
              return ListTile(
                onTap: () {
                  propertyNotifier.currentProperty =
                      propertyNotifier.propertiesList[index];
                  showResults(context);
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listitem.name,
                      style: TextStyle(fontSize: 20),
                    ),
                    //Text(listitem.propertyTypeDetails),
                    Text(listitem.location),
                    Text("Ksh ${listitem.price}"),
                    Divider()
                  ],
                ),
              );
            },
          );
  }
}
