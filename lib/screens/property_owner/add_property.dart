import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhouse/helpers/properties_api.dart';
import 'package:findhouse/models/properties.dart';
import 'package:findhouse/models/user.dart';
import 'package:findhouse/notifiers/app.dart';
import 'package:findhouse/notifiers/home_searcher/propertiesNotifier.dart';
import 'package:findhouse/notifiers/user_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';


class AddProductsScreen extends StatefulWidget{
  static String id = 'AddProduct';
  final bool isUpdating;

  AddProductsScreen({@required this.isUpdating});
  @override
  _SellerFormState createState() => _SellerFormState();

}
class _SellerFormState extends State<AddProductsScreen>{
  final _key = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List _features = [];
  List _roomImagesUrl = [];
  Properties _currentProperty;
  String _imageUrl;
  FirebaseUser _user;
  FirebaseUser get user => _user;
  File _imageFile;
  TextEditingController featuresController = new TextEditingController();
  var selectedCurrency, selectedType;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  List<String> _categoryType = <String>[
    'Apartments',
    'Flats',
    'Bungalows',
    'Air BnB',
    'Maissonettes',
    'Offices'
  ];

  void initState(){
    super.initState();
    PropertyNotifier propertyNotifier = Provider.of<PropertyNotifier>(context, listen: false);
    if(propertyNotifier.currentProperty != null){
      _currentProperty=propertyNotifier.currentProperty;
    }else {
      _currentProperty = Properties();
    }

    //_features.addAll(_currentProperty.features);
    _imageUrl=_currentProperty.image;
    //_roomImagesUrl.addAll(_currentProperty.roomImages);
  }


  _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Text("");
    } else if (_imageFile != null) {
      print('showing image from local file');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _imageFile,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    } else if (_imageUrl != null) {
      print('showing image from url');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            _imageUrl,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    }
  }


  _getLocalImage() async {
    File imageFile =
    await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 400);

    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }
  Widget _buildNameField(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name of Property'),
      initialValue: _currentProperty.name,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),

      onSaved: (String value){
        _currentProperty.name=value;
      },
    );
  }
  Widget _buildbedRoomNoField(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'No of bedrooms'),
      initialValue: _currentProperty.bedRoomNo,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),

      onSaved: (String value){
        _currentProperty.bedRoomNo=value;
      },
    );
  }

  Widget _buildPriceField(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Price'),
      initialValue: _currentProperty.price,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      /*validator: (String value){
        if(value.isEmpty){
          return 'Price is Required';
        }
        if(value.length <3 || value.length>20){
          return 'Price must be more than 3 and less than 20';
        }

        return null;
      },*/
      onSaved: (String value){
        _currentProperty.price=value;
      },
    );
  }
  Widget _buildDescriptionField(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Description'),
      initialValue: _currentProperty.desc,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      onSaved: (String value){
        _currentProperty.desc=value;
      },
    );
  }
  Widget _buildLocationField(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Location'),
      initialValue: _currentProperty.location,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      onSaved: (String value){
        _currentProperty.location=value;
      },
    );
  }
  _buildFeaturesField() {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: featuresController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(labelText: 'Features'),
        style: TextStyle(fontSize: 20),
      ),
    );
  }
  Widget _buildCategoryField(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(FontAwesomeIcons.monument,
          size: 25.0,
          color: Color(0xff11b719),
        ),
        SizedBox(width: 50.0),
        DropdownButton(
          items: _categoryType
              .map((value) => DropdownMenuItem(
            child: Text(
              value,
              style: TextStyle(color: Color(0xff11b719)),
            ),
            value: value,
          ))
              .toList(),
          onChanged: (selectedAccountType) {
            print('$selectedAccountType');
            setState(() {
              selectedType = selectedAccountType;
            });
          },
          value: selectedType,
          isExpanded: false,
          hint: Text(
            'Choose Category Type',
            style: TextStyle(color: Color(0xff11b719)),
          ),
        )
      ],
    );

  }

  Widget _buildPhoneNumberField(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone Number'),
      initialValue: _currentProperty.sellerPhoneNumber,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      onSaved: (String value){
        _currentProperty.sellerPhoneNumber=value;
      },
    );
  }
  Widget _buildSellerId(){
    final userProvider = Provider.of<UserNotifier>(context);
    return TextFormField(
      decoration: InputDecoration(labelText: 'Seller Id'),
      initialValue: _currentProperty.sellerId = userProvider.user.uid,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      onSaved: (String value){
        _currentProperty.sellerId= userProvider.user.uid;
      },
    );
  }
  _onPropertyUploaded(Properties properties){
    PropertyNotifier propertyNotifier = Provider.of<PropertyNotifier>(context, listen: false);
    propertyNotifier.addProperty(properties);
    Navigator.pop(context);
  }

  _addFeatures(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _features.add(text);
      });
      featuresController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserNotifier>(context, listen: false);
    final appProvider = Provider.of<AppNotifier>(context, listen: false);

    return Scaffold(

      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(children: <Widget>[
            _showImage(),
            SizedBox(height: 16,),
            Text(
              "Add Property",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 16),
            _imageFile == null && _imageUrl == null
                ? ButtonTheme(
              child: RaisedButton(
                onPressed: () => _getLocalImage(),
                child: Text(
                  'Add Image',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
                : SizedBox(height: 0),
            _buildNameField(),
            _buildCategoryField(),
            _buildbedRoomNoField(),
            _buildSellerId(),
            _buildDescriptionField(),
            _buildLocationField(),
            _buildPriceField(),
            _buildPhoneNumberField(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildFeaturesField(),
                ButtonTheme(
                  child: RaisedButton(
                    child: Text('Add', style: TextStyle(color: Colors.white)),
                    onPressed: () => _addFeatures(featuresController.text),
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(8),
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              children: _features
                  .map(
                    (ingredient) => Card(
                  color: Colors.black54,
                  child: Center(
                    child: Text(
                      ingredient,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              )
                  .toList(),
            ),

            Material(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.blueAccent,
                child:MaterialButton(
                  padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                  child: Text(
                    "Save Property",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                      print('saveProperty Called');
                      if (!_formKey.currentState.validate()) {
                        return;
                      }

                      _formKey.currentState.save();

                      print('form saved');
                      _currentProperty.features = _features;

                      if(!await uploadPropertyAndImage(_currentProperty, widget.isUpdating, _imageFile, _onPropertyUploaded))
                      {

                        key: _key;
                        _key.currentState.showSnackBar(SnackBar(
                          content: Text("Upload Failed"),
                          duration: const Duration(seconds: 10),
                        ));
                        appProvider.changeLoading();
                        return;
                      }

                      userProvider.loadProperties(sellerId: userProvider.users.id);
                      await userProvider.reload();
                      appProvider.changeLoading();
                      print("name: ${_currentProperty.name}");
                      print("Your name: ${_currentProperty.sellerId}");
                      print("category: ${_currentProperty.category}");
                      print("desc: ${_currentProperty.desc}");
                      print("price: ${_currentProperty.price}");
                      print("location: ${_currentProperty.location}");
                      print("sellerPhoneNumber: ${_currentProperty.sellerPhoneNumber}");
                      print("bedRoomNo: ${_currentProperty.bedRoomNo}");
                      print("features: ${_currentProperty.features.toString()}");
                      print("_imageFile ${_imageFile.toString()}");
                      print("_imageUrl $_imageUrl");
                    //Navigator.of(context).pushNamed(Feed());
                  },
                )
            ),

          ],
          ),
        ),

      ),

      /* floatingActionButton: FloatingActionButton(
    onPressed: () {
    FocusScope.of(context).requestFocus(new FocusNode());
    _saveProperty();
    },
    child: Icon(Icons.save),
    foregroundColor: Colors.white,
      ),*/
    );
  }
}

class Adds extends StatefulWidget {
  @override
  _AddsState createState() => _AddsState();
}

class _AddsState extends State<Adds> {
  String gender;
  String groupValue = "Apartment";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Row(
                children:<Widget>[
                  Expanded(child: Radio(value: "Apartment", groupValue: groupValue, onChanged: (e) => valueChanged(e))),
                  Expanded(child: Radio(value: "Flats", groupValue: groupValue, onChanged: (e) => valueChanged(e)))

                ])
          ],
        )
    );
  }
  valueChanged(e) {
    if(e== "Apartment"){
      groupValue = e;
    }else if(e == "flats"){
      groupValue = e;
    }
  }
}
