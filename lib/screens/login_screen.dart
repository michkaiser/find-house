import 'package:findhouse/notifiers/user_notifier.dart';
import 'package:findhouse/screens/register_screen.dart';
import 'package:findhouse/screens/property_owner/seller_homescreen.dart';
import 'package:findhouse/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'openingscreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  bool hidepass = true;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserNotifier>(context);
    return Scaffold(
      key: _key,
      body: authProvider.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
               /* Image.asset(
                  "assets/bg1.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),*/
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.amber,
                        //Colors.transparent,
                        //Colors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 120.0, top: 30.0),
                  child: Image.asset(
                    "assets/propertyfinderlogo.png",
                    width: 200,
                    height: 200,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 120.0, top: 90.0),
                  child: Image.asset(
                    "assets/propertyfinderlogo2.png",
                    width: 200,
                    height: 200,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 200.0),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.amber.withOpacity(0.8),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, bottom: 2.0, top: 2.0),
                                child: TextFormField(
                                  controller: authProvider.email,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.white),
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                  ),
                                  //keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      Pattern pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value))
                                        return 'Please make sure your email address is valid';
                                    } else
                                      return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.amber.withOpacity(0.8),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, bottom: 2.0, top: 2.0),
                                child: ListTile(
                                  title: TextFormField(
                                    controller: authProvider.password,
                                    obscureText: hidepass,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.white),
                                      icon: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Password field cannot be empty";
                                      } else if (value.length < 6) {
                                        return "the password has to be atleast 6 characters long";
                                      } else {
                                        return "password is incorrect";
                                      }
                                      return null;
                                    },
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.remove_red_eye),
                                    onPressed: () {
                                      setState(() {
                                        hidepass = false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.blueAccent,
                              elevation: 0.0,
                              child: MaterialButton(
                                onPressed: () async {
                                  if (!await authProvider.signIn()) {
                                    _key.currentState.showSnackBar(SnackBar(
                                      content: Text(
                                        "Login failed!,username or password in incorrect or null",
                                        style: TextStyle(fontSize: 18,color: Colors.red),
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: Colors.white,
                                      duration: Duration(seconds: 5),
                                      behavior: SnackBarBehavior.floating,
                                    ));
                                    return;
                                  }
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => OpeningView()));
                                },
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                                minWidth: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                          // Expanded(child: Container()),
                          Divider(),
                          Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          Divider(),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 80.0),
                                child: Text("Do not have an account?",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()));
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
