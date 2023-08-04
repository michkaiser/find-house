
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:findhouse/screens/home_searcher/homescreen.dart';
import 'package:findhouse/screens/home_searcher/profile.dart';
import 'package:findhouse/screens/home_searcher/settings.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  List<Widget> tabPages = [

    HomeScreen(),
   EditProfilePage(),
    SettingsPage(),

  ];
  Widget build(BuildContext context){

          return Scaffold(

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.amber,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Home")
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('My Profile'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  title: Text('Settings'),
                ),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                }
                );
              },
            ),
            body: tabPages[_currentIndex],
          );

  }

}
