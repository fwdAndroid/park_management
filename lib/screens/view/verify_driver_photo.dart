import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:park_management/screens/main_dashboard.dart';
import 'package:park_management/uitls/colors.dart';
import 'package:park_management/uitls/message_utils.dart';
import 'package:park_management/widgets/save_button.dart';
import 'package:photo_view/photo_view.dart';

class VerifyDriverPhoto extends StatefulWidget {
  final driverPhoto;
  final uuid;
  const VerifyDriverPhoto(
      {super.key, required this.driverPhoto, required this.uuid});

  @override
  State<VerifyDriverPhoto> createState() => _VerifyDriverPhotoState();
}

class _VerifyDriverPhotoState extends State<VerifyDriverPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        centerTitle: true,
        title: Text(
          "Driver Photo",
          style: TextStyle(color: black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: PhotoView(
                imageProvider: NetworkImage(widget.driverPhoto),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: 200,
                  height: 88,
                  child: SaveButton(
                      title: "Verify",
                      onTap: () {
                        _showConfirmationDialog(context);
                      })))
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Verification'),
          content: Text('Are you sure you want to verify this car?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("cars")
                    .doc(widget.uuid)
                    .delete();
                Navigator.of(context).pop(); // Close the dialog
                showMessageBar("Car is Verified Successfully", context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (builder) => MainDashboard()));
              },
              child: Text('Verify'),
            ),
          ],
        );
      },
    );
  }
}
