import 'package:findhouse/helpers/screen_navigation.dart';
import 'package:findhouse/notifiers/home_searcher/propertiesNotifier.dart';
import 'package:findhouse/notifiers/property_owner/properties.dart';
import 'package:findhouse/notifiers/user_notifier.dart';
import 'package:findhouse/screens/details.dart';
import 'package:findhouse/screens/homepage.dart';
import 'package:findhouse/screens/login_screen.dart';
import 'package:findhouse/screens/property_owner/add_property.dart';
import 'package:findhouse/screens/property_owner/properties.dart';
import 'package:findhouse/widgets/properties.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {

  const DashboardScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final propertiesProvider = Provider.of<PropertiesProvider>(context);
    final userProvider = Provider.of<UserNotifier>(context);
    final propertyNotifier = Provider.of<PropertyNotifier>(context);

    bool hasImage = false;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.5,
        backgroundColor: Colors.blueAccent,
        title: Text("Property Finder",
          style: TextStyle(color: Colors.white,)
        ),
        actions: <Widget>[],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              accountName:
                Text(userProvider.users?.name ?? "",
              ),
              accountEmail:
              Text(userProvider.users?.email ?? "",
              ),

            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.home),
              title: Text( "Home"),
            ),

            ListTile(
              onTap: () {},
              leading: Icon(Icons.person),
              title: Text( "My Profile"),
            ),

            ListTile(
              onTap: () {
                changeScreen(context, Apartments());
              },
              leading: Icon(Icons.account_balance),
              title: Text("My Properties"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, HomePage());
              },
              leading: Icon(Icons.account_balance),
              title: Text("View other Properties"),
            ),

            ListTile(
              onTap: () {
                userProvider.signOut();
                changeScreenReplacement(context, LoginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title:Text( "Log out"),
            ),
          ],
        ),
      ),
      //backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[

                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(2),
                          bottomRight: Radius.circular(2),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.blueAccent.withOpacity(0.6),
                            Colors.blueAccent.withOpacity(0.6),
                            Colors.blueAccent.withOpacity(0.6),
                            Colors.blueAccent.withOpacity(0.4),
                            Colors.blueAccent.withOpacity(0.1),
                            Colors.blueAccent.withOpacity(0.05),
                            Colors.blueAccent.withOpacity(0.025),
                          ],
                        )),
                  ),
                  Positioned.fill(
                      bottom: 60,
                      left: 10,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Icon(Icons.account_balance, size: 100,color: Colors.blueAccent,))),
                  //Seller name
                  Positioned.fill(
                      bottom: 40,
                      left: 10,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(userProvider?.users?.name ?? "",
                            style: TextStyle(color: Colors.black,fontSize: 28, fontWeight: FontWeight.bold),
                          ))),

                  // average price
                  Positioned.fill(
                      bottom: 10,
                      left: 10,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text("Property Owner",
                            style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.bold),
                          ))),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueAccent,
                              offset: Offset(-2, -1),
                              blurRadius: 5),
                        ]),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    decoration: BoxDecoration(
                        color:Colors.white38,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(-2, -1),
                              blurRadius: 5),
                        ]),
                    child: ListTile(
                        onTap: (){
                          //changeScreen(context, Apartments());
                        },
                        leading: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset("assets/logo1.png"),
                        ),
                        title: Text("Total No of Properties",
                          style: TextStyle(fontSize: 18,
                              color: Colors.black)
                        ),
                        trailing: Text(userProvider.propertiesList.length.toString(),
                          style:TextStyle(fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)
                        )),
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    decoration: BoxDecoration(
                        color:Colors.blueAccent,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(-2, -1),
                              blurRadius: 5),
                        ]),
                    child: ListTile(
                        onTap: (){
                          changeScreen(context, Apartments());
                        },
                        leading: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset("assets/logo1.png"),
                        ),
                        title: Text("View Your Properties",
                            style: TextStyle(fontSize: 18,
                                color: Colors.white)
                        ),
                        ),
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    decoration: BoxDecoration(
                        color:Colors.blueAccent,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(-2, -1),
                              blurRadius: 5),
                        ]),
                    child: ListTile(
                        onTap: (){
                          changeScreen(context, AddProductsScreen());
                        },
                        leading: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset("assets/logo1.png"),
                        ),
                        title: Text("Add your Properties",
                            style: TextStyle(fontSize: 18,
                                color: Colors.white)
                        ),

                  ),
                ),

              ),


              // products
              /*Column(
                children: userProvider.properties
                    .map((item) => GestureDetector(
                  onTap: () {
                   changeScreen(context, Details(properties: item,));
                  },
                  child: PropertiesWidget(
                    properties: item,
                  ),
                ))
                    .toList(),
              )*/)
            ],
          )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        changeScreen(context, AddProductsScreen());
      },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
        tooltip: 'Add Property',),
    );
  }

  /*Widget imageWidget({bool hasImage, String url}) {
    if (hasImage)
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: url,
        height: 160,
        fit: BoxFit.fill,
        width: double.infinity,
      );

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_alt,
                size: 40,
              ),
            ],
          ),
          CustomText(text: "No Photo")
        ],
      ),
      height: 160,
    );
  }*/
}


