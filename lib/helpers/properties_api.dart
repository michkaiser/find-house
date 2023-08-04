import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhouse/models/properties.dart';
import 'package:findhouse/models/user.dart';
import 'package:findhouse/notifiers/home_searcher/propertiesNotifier.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';


getProperties(PropertyNotifier propertyNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Properties')
      .orderBy("dateAdded", descending: true)
      .getDocuments();

  List<Properties> _propertiesList = [];

  snapshot.documents.forEach((document) {
    Properties properties = Properties.fromMap(document.data);
    _propertiesList.add(properties);
  });

  propertyNotifier.propertiesList = _propertiesList;
}

uploadPropertyAndImage(Properties properties, bool isUpdating, File localFile, Function propertyUploaded) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('propertiesf/images/$uuid$fileExtension');

    await firebaseStorageRef.putFile(localFile).onComplete.catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _uploadProperties(properties, isUpdating, propertyUploaded, imageUrl: url);
  } else {
    print('...skipping image upload');
    _uploadProperties(properties, isUpdating, propertyUploaded);
  }
}

_uploadProperties(Properties properties, bool isUpdating, Function propertiesUploaded, {String imageUrl}) async {
  CollectionReference propRef = Firestore.instance.collection('Properties'); Firestore.instance.collection('SellerUser') ;

  if (imageUrl != null) {
    properties.image = imageUrl;
  }

  if (isUpdating != null) {
    properties.dateUpdated = Timestamp.now();

    await propRef.document(properties.id).updateData(properties.toMap());

    propertiesUploaded(properties);
    print('updated properties with id: ${properties.id}');
  } else {
    properties.dateAdded = Timestamp.now();

    DocumentReference documentRef = await propRef.add(properties.toMap());
    properties.id = documentRef.documentID;

    print('uploaded properties successfully: ${properties.toString()}');

    await documentRef.setData(properties.toMap(), merge: true);

    propertiesUploaded(properties);
  }
}

deleteProperty(Properties properties, Function propertiesDeleted) async {
  if (properties.image != null) {
    StorageReference storageReference =
    await FirebaseStorage.instance.getReferenceFromUrl(properties.image);

    print(storageReference.path);

    await storageReference.delete();

    print('image deleted');
  }

  await Firestore.instance.collection('Properties').document(properties.id).delete();
  propertiesDeleted(properties);
}