import 'package:findhouse/models/user.dart';
import 'package:findhouse/notifiers/user_notifier.dart';
import 'package:findhouse/screens/homepage.dart';
import 'package:findhouse/screens/property_owner/seller_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpeningView extends StatefulWidget {

  @override
  OpeningViewState createState() => OpeningViewState();
}

class OpeningViewState extends State<OpeningView> {
  UserModel user;
  OpeningViewState();
  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    //final userProvider = Provider.of<UserNotifier>(context);
    final mq = MediaQuery.of(context);
    final userProvider = Provider.of<UserNotifier>(context);
    final logo = Image.asset(
      "assets/propertyfinderlogo.png",
      height: mq.size.height / 8,
    );
    final logo1 = Image.asset(
      "assets/propertyfinderlogo2.png",
      height: mq.size.height / 8,
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,

      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Find your Dream Home",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomePage())
          );
          //Navigator.of(context).pushNamed(AppRoutes.authLogin);
        },
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Sell/ Rent a dream Home",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
          //Navigator.of(context).pushNamed(AppRoutes.authRegister);
        },
      ),
    );

    final buttons = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton,
        Padding(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 70),
          child: registerButton,
        ),
      ],
    );

    display() {
      if (userProvider.users?.name != null)

        return Row(
          children: [
            Text("Welcome to Property finder ",
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 20,)),
            Text(
              userProvider.users?.name ?? "",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 22,
              ),
            ),
          ],
        );
      else
        return Text(
          "Welcome to House Shop!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        );
    }

    return Scaffold(
     // backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(top: 50),
              child: logo,
            ),
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: logo1,
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 20),
              child: display(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 50),
              child: buttons,
            )
          ],
        ),
      ),
    );
  }
}
