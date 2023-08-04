import 'dart:async';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhouse/notifiers/home_searcher/propertiesNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  Completer<GoogleMapController> _controller = Completer();

  //GeoPoint geoPoint = document.getGeoPoint("position");
  @override
  Widget build(BuildContext context) {
    PropertyNotifier propertyNotifier = Provider.of<PropertyNotifier>(context);
    Set<Marker> _markers = {
      Marker(
        markerId: MarkerId("${propertyNotifier.currentProperty.name}"),
        position: LatLng(propertyNotifier.currentProperty.map.latitude,
            propertyNotifier.currentProperty.map.longitude),
        infoWindow: InfoWindow(
            title: "${propertyNotifier.currentProperty.name}",
            snippet: "${propertyNotifier.currentProperty.location}"),
      ),
    };
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .6,
          child: PageView.builder(
            itemCount: propertyNotifier.currentProperty.roomImages.length,
            itemBuilder: (context, index) {
              return Image.network(
                propertyNotifier.currentProperty.roomImages[index] != null
                    ? propertyNotifier.currentProperty.roomImages[index]
                    : "https://firebasestorage.googleapis.com/v0/b/drinkapp-16c27.appspot.com/o/propertiesf%2Fimages%2F4614aa24-54a2-41d5-a308-2f6f995a60ce.jpg?alt=media&token=bb8d0a13-ba12-4780-8e73-70f860a2c53e",
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: .5,
          minChildSize: .5,
          maxChildSize: .8,
          builder: (context, controller) {
            return SingleChildScrollView(
              controller: controller,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Icon(
                              Icons.drag_handle,
                              color: Colors.black38,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(24),
                            child: Text(
                              propertyNotifier.currentProperty.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[])),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                /* _buildWidgetSize(
                                       "Living Room",
                                       widget.data.sizeLivingRoom,
                                     ),
                                     Container(
                                       width: 1,
                                       height: 50,
                                       color: Colors.black38,
                                     ),
                                     _buildWidgetSize(
                                       "Bed Room",
                                       widget.data.sizeBedRoom,
                                     ),
                                     Container(
                                       width: 1,
                                       height: 50,
                                       color: Colors.black38,
                                     ),
                                     _buildWidgetSize(
                                       "BathRoom",
                                       widget.data.sizeBathRoom,
                                     ),
                                     Container(
                                       width: 1,
                                       height: 50,
                                       color: Colors.black38,
                                     ),*/
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    .97, // or use fixed size like 200
                                height:
                                    MediaQuery.of(context).size.height * .20,
                                child: GoogleMap(
                                  padding: EdgeInsets.all(25),
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          propertyNotifier
                                              .currentProperty.map.latitude,
                                          propertyNotifier
                                              .currentProperty.map.longitude),
                                      zoom: 14),
                                  markers: _markers,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              propertyNotifier.currentProperty.desc,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                height: 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 150, top: 10, right: 0, bottom: 0),
                            child: Text(
                              "Features",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Wrap(children: <Widget>[
                              ...propertyNotifier.currentProperty.features
                                  .map((feature) {
                                return Container(
                                  padding: EdgeInsets.all(6),
                                  margin: EdgeInsets.only(bottom: 6, right: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    color: Colors.blueAccent,
                                  ),
                                  child: Text(
                                    feature,
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                );
                              })
                            ]),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text("Read More",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                  height: 1.5,
                                )),
                          ),
                          /*Container(
                        child: _buildLocation(
                          widget.data.positions,
                        ),
                      ),*/
                        ]),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .45),
            child: SliderIndicator(
              length: propertyNotifier.currentProperty.roomImages.length,
              activeIndex: 0,
              indicator: Icon(
                Icons.radio_button_checked,
                color: Colors.white,
                size: 10,
              ),
              activeIndicator: Icon(
                Icons.fiber_manual_record,
                color: Colors.white,
                size: 12,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(right: 24, top: 45),
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(
              left: 24,
              top: 50,
            ),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.fiber_manual_record,
                  size: 16,
                  color: Colors.white,
                ),
                Text(
                  "Ksh",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  "${propertyNotifier.currentProperty.price}/",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "month",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ))
      ]),
      bottomNavigationBar: Container(
        child: RaisedButton(
          onPressed: () {
            customLaunch(
                'tel:${propertyNotifier.currentProperty.sellerPhoneNumber}');
          },
          textColor: Colors.white,
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: const Text('Contact Property Owner'),
          ),
        ),
      ),
    );
  }
}
