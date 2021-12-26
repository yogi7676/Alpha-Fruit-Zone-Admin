import 'package:cloud_firestore/cloud_firestore.dart';

class Vendor {
  static const FIRSTNAME = "firstName";
  static const LASTNAME = "lastName";
  static const BUSINESSNAME = "businessName";
  static const ADDRESS = "address";
  static const CITY = "city";
  static const PINCODE = "pincode";
  static const PHONENUMBER = "phoneNumber";
  static const LANDMARK = "landmark";
  static const STATE = "state";
  static const IMAGEURLS = "imageurls";
  static const EMAIL = "email";
  static const PASSWORD = "password";
  static const SELLINGPRODUCTS = 'sellingProducts';

  String? firstName;
  String? lastName;
  String? businessName;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? landmark;
  String? email;
  String? password;
  String? docID;
  String? imageUrl;

  Vendor({
    this.firstName,
    this.businessName,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.landmark,
    this.email,
    this.imageUrl,
    this.lastName,
  });

  Vendor.fromFirestore(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    docID = documentSnapshot.id;
    firstName = data[FIRSTNAME];
    imageUrl = data[IMAGEURLS];
    city = data[CITY];
    lastName = data[LASTNAME];
    businessName = data[BUSINESSNAME];
    phoneNumber = data[PHONENUMBER];
    address = data[ADDRESS];
    state = data[STATE];
    pincode = data[PINCODE];
    landmark = data[LANDMARK];
    email = data[EMAIL];
  }

  String getAddress() {
    return '${address!},${city!},${state!} - ${pincode!}';
  }

  String getFullName() {
    return '${firstName!} ${lastName!}';
  }
}
