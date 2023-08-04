import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhouse/models/properties.dart';

class PropertyServices {
  String collection = "Properties";
  Firestore _firestore = Firestore.instance;

  Future createProperty({Map data})async{
    _firestore.collection(collection).document(data['id']).setData({
      "id": data['id'],
      "name": data['name'],
      "image": data['image'],
      "category": data['category'],
      "desc": data['desc'],
      "price": data['price'],
      "bedRoomNo": data['bedRoomNo'],
      "sellerPhoneNumber": data['sellerPhoneNumber'],
      "roomImages": data['roomImages'],
      "featured": data['featured'],
      "map": data['map'],
      "location": data['location'],
      "sellerId": data[''],
      "features": data['features'],
    });
  }

  Future<List<Properties>> getProperty() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<Properties> properties = [];
        for (DocumentSnapshot property in result.documents) {
          properties.add(Properties.fromSnapshot(property));
        }
        return properties;
      });

  void likeOrDislikeProduct({String id, List<String> userLikes}){
    _firestore.collection(collection).document(id).updateData({
      "userLikes": userLikes
    });
  }

  Future<List<Properties>> getPropertiesBySeller({String id}) async =>
      _firestore
          .collection(collection)
          .where("sellerId", isEqualTo: id)
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

  Future<List<Properties>> getPropertiesByCategory({String category}) async =>
      _firestore
          .collection(collection)
          .where("category", isEqualTo: category)
          .getDocuments()
          .then((result) {
        List<Properties> properties = [];
        for (DocumentSnapshot property in result.documents) {
          properties.add(Properties.fromSnapshot(property));
        }
        return properties;
      });

  Future<List<Properties>> searchProducts({String productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .getDocuments()
        .then((result) {
      List<Properties> properties = [];
      for (DocumentSnapshot property in result.documents) {
        properties.add(Properties.fromSnapshot(property));
      }
      return properties;
    });
  }
}
