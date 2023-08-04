import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhouse/helpers/seller-api.dart';
import 'package:findhouse/models/properties.dart';
import 'package:findhouse/notifiers/home_searcher/propertiesNotifier.dart';
import 'package:findhouse/notifiers/user_notifier.dart';
import '../models/user.dart';

class UserServices {
  String collection = "User";
  Firestore _firestore = Firestore.instance;

  Future<List<UserModel>> getUsers() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<UserModel> users = [];
        for(DocumentSnapshot user in result.documents){
          users.add(UserModel.fromSnapshot(user));
        }
        return users;
      });

  Future<UserModel> getUserById({String id}) => _firestore.collection(collection).document(id.toString()).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });

  Future<List<UserModel>> searchUser({String name}) {
    String searchKey = name[0].toUpperCase() + name.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .getDocuments()
        .then((result) {
      List<UserModel> users = [];
      for (DocumentSnapshot property in result.documents) {
        users.add(UserModel.fromSnapshot(property));
      }
      return users;
    });
  }

}