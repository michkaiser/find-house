import 'package:findhouse/models/properties.dart';
import 'package:findhouse/notifiers/home_searcher/propertiesNotifier.dart';
import 'package:findhouse/notifiers/property_owner/properties.dart';
import 'package:findhouse/notifiers/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PropertiesWidget extends StatelessWidget {
  final Properties properties;

  const PropertiesWidget({Key key, this.properties}) : super(key: key);

  @override
  Widget build(BuildContext context) {
final user = Provider.of<UserNotifier>(context);
 final productProvider = Provider.of<PropertyNotifier>(context);


    return  Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 10),
      child: Container(
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
                        properties.image != null
                            ? properties.image
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
                              width: MediaQuery.of(context).size.width * .2,
                              child: Text(
                                "${properties.name}",
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
        Align(
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
                        "Available ${properties.bedRoomNo} bedroom in ${properties.location} for rent",
                        style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold,),
                      ),
                      Row(children: <Widget>[
                        Text(properties.location, style: TextStyle(fontSize: 11, color: Colors.black38, fontWeight: FontWeight.bold,
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
                          Text(properties.price.toString(),
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
                                properties.bedRoomNo,
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
                    ])))
          ],
        ),
      )
    );
  }
}
