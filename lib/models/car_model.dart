import 'package:cloud_firestore/cloud_firestore.dart';

class CarModel {
  String carNumber;
  String ownerName;
  String address;
  String uid;
  String carCategory;
  String phoneNumber;
  String uuid;
  String driverPhoto;

  CarModel({
    required this.carNumber,
    required this.ownerName,
    required this.carCategory,
    required this.phoneNumber,
    required this.uuid,
    required this.driverPhoto,
    required this.uid,
    required this.address,
  });

  ///Converting Object into Json Object
  Map<String, dynamic> toJson() => {
        'carCategory': carCategory,
        'carNumber': carNumber,
        'ownerName': ownerName,
        'driverPhoto': driverPhoto,
        'uuid': uuid,
        'address': address,
        'phoneNumber': phoneNumber,
        'uid': uid,
      };

  ///
  static CarModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return CarModel(
        carCategory: snapshot['carCategory'],
        phoneNumber: snapshot['phoneNumber'],
        uid: snapshot['uid'],
        carNumber: snapshot['carNumber'],
        uuid: snapshot['uuid'],
        ownerName: snapshot['ownerName'],
        address: snapshot['address'],
        driverPhoto: snapshot['driverPhoto']);
  }
}
