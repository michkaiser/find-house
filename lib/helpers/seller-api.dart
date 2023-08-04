import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhouse/models/properties.dart';
import 'package:findhouse/models/user.dart';
import 'package:findhouse/notifiers/home_searcher/propertiesNotifier.dart';
import 'package:findhouse/notifiers/user_notifier.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

FirebaseUser _user;
FirebaseUser get user => _user;

getProperties(UserNotifier userNotifier) async {

  QuerySnapshot snapshot = await Firestore.instance
      .collection('Properties')
      .where("sellerId",isEqualTo: userNotifier.user.uid)
      .orderBy("dateAdded", descending: true)
      .getDocuments();

  List<Properties> _propertiesList = [];

  snapshot.documents.forEach((document) {
    Properties properties = Properties.fromMap(document.data);
    _propertiesList.add(properties);
  });

  userNotifier.propertiesList = _propertiesList;
}

