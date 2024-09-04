import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:park_management/models/car_model.dart';
import 'package:park_management/services/storage_methods.dart';
import 'package:uuid/uuid.dart';

class DatabaseMethods {
  // Add Service
  Future<String> addCar({
    required String carNumber,
    required String ownerName,
    required String address,
    required String carCategory,
    required String phoneNumber,
    required Uint8List driverPhoto,
  }) async {
    String res = 'Wrong carNumber or car';
    try {
      String driverPhotos =
          await StorageMethods().uploadImageToStorage("Drivers", driverPhoto);

      var uuid = const Uuid().v4();
      //Add User to the database with modal
      CarModel userModel = CarModel(
        driverPhoto: driverPhotos,
        ownerName: ownerName,
        uid: FirebaseAuth.instance.currentUser!.uid,
        carCategory: carCategory,
        carNumber: carNumber,
        address: address,
        phoneNumber: phoneNumber,
        uuid: uuid,
      );
      await FirebaseFirestore.instance
          .collection('cars')
          .doc(uuid)
          .set(userModel.toJson());
      res = 'sucess';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
