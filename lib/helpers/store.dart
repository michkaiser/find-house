import 'package:findhouse/widgets//constants.dart';
import 'package:findhouse/models/properties.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final Firestore _firestore = Firestore.instance;

  addProperty(Properties properties) {
    _firestore.collection(kpropertyCollection).add({
      kpropertyName: properties.name,
      kpropertyDescription: properties.desc,
      kpropertyLocation: properties.location,
      kpropertyCategory: properties.category,
      kpropertyPrice: properties.price,
      kpropertyFeatures: properties.features,
      kpropertyBedRoomNo: properties.bedRoomNo,
      kpropertyDateAdded: properties.dateAdded,
      kpropertyDateUpdated: properties.dateUpdated,
      kpropertyImage: properties.image,
      kpropertyMap: properties.map,
      kpropertyRoomImages: properties.roomImages,
      kpropertyRoomSizes: properties.roomSizes,
      kpropertySellerPhoneNo: properties.sellerPhoneNumber
    });
  }
  Future<List<Properties>> getPropertiesBySeller({String id}) async =>
      _firestore
          .collection("Properties")
          .where("id", isEqualTo: id)
          .getDocuments()
          .then((result) {
        List<Properties> properties = [];
        for (DocumentSnapshot property in result.documents) {
          properties.add(Properties.fromSnapshot(property));
        }
        print("PRODUCTS: ${properties.length}");
        print("PRODUCTS: ${properties.length}");
        print("PRODUCTS: ${properties.length}");
        print("PRODUCTS: ${properties.length}");
        print("PRODUCTS: ${properties.length}");
        print("PRODUCTS: ${properties.length}");
        print("PRODUCTS: ${properties.length}");

        return properties;
      });

  Stream<QuerySnapshot> loadProperties() {
    return _firestore.collection(kpropertyCollection).snapshots();
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _firestore
        .collection(kOrders)
        .document(documentId)
        .collection(kOrderDetails)
        .snapshots();
  }

  deleteproperty(documentId) {
    _firestore.collection(kpropertyCollection).document(documentId).delete();
  }

  editProperty(data, documentId) {
    _firestore
        .collection(kpropertyCollection)
        .document(documentId)
        .updateData(data);
  }

}
