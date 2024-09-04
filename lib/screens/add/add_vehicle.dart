import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:park_management/screens/main_dashboard.dart';
import 'package:park_management/services/database_methods.dart';
import 'package:park_management/uitls/colors.dart';
import 'package:park_management/uitls/image_utils.dart';
import 'package:park_management/uitls/message_utils.dart';
import 'package:park_management/widgets/save_button.dart';

class AddVehicle extends StatefulWidget {
  final String carType;
  const AddVehicle({super.key, required this.carType});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _carNumberController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool isChecked = false;

  // Image
  Uint8List? driverImage;

  // Loader
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Driver Photo',
                  style: GoogleFonts.plusJakartaSans(
                      color: black, fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => selectImageDriver(),
              child: Stack(
                children: [
                  driverImage != null
                      ? CircleAvatar(
                          radius: 59,
                          backgroundImage: MemoryImage(driverImage!))
                      : GestureDetector(
                          onTap: () => selectImageDriver(),
                          child: const CircleAvatar(
                            radius: 59,
                            backgroundImage: AssetImage('assets/person.png'),
                          ),
                        ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Driver Name',
                      style: GoogleFonts.plusJakartaSans(
                          color: black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _nameController,
                    style: GoogleFonts.plusJakartaSans(color: black),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        hintText: "Enter Full Name",
                        hintStyle: GoogleFonts.plusJakartaSans(
                            color: black, fontSize: 12)),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 16),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Car Number',
                      style: GoogleFonts.plusJakartaSans(
                          color: black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _carNumberController,
                    style: GoogleFonts.plusJakartaSans(color: black),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        hintText: "Car Number",
                        hintStyle: GoogleFonts.plusJakartaSans(
                            color: black, fontSize: 12)),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Contact Number',
                      style: GoogleFonts.plusJakartaSans(
                          color: black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _contactController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.plusJakartaSans(color: black),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        hintText: "Contact Number ",
                        hintStyle: GoogleFonts.plusJakartaSans(
                            color: black, fontSize: 12)),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Address',
                      style: GoogleFonts.plusJakartaSans(
                          color: black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _addressController,
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.plusJakartaSans(color: black),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor)),
                        hintText: "Address",
                        hintStyle: GoogleFonts.plusJakartaSans(
                            color: black, fontSize: 12)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    )
                  : SaveButton(
                      title: "Add Car",
                      onTap: () async {
                        if (driverImage == null) {
                          showMessageBar("Driver Photo is required", context);
                        } else if (_nameController.text.isEmpty) {
                          showMessageBar(
                              "Name of the user is required", context);
                        } else if (_carNumberController.text.isEmpty) {
                          showMessageBar("Car Number is required ", context);
                        } else if (_contactController.text.isEmpty) {
                          showMessageBar(
                              "Contact Number is required ", context);
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          await DatabaseMethods().addCar(
                            driverPhoto: driverImage!,
                            carNumber: _carNumberController.text.trim(),
                            ownerName: _nameController.text.trim(),
                            phoneNumber: _contactController.text,
                            address: _addressController.text.trim(),
                            carCategory: widget.carType,
                          );

                          // Save the image to gallery

                          setState(() {
                            isLoading = false;
                          });
                          showMessageBar("Car Added Successfully", context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => MainDashboard()));
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  selectImageDriver() async {
    Uint8List ui = await pickImage(ImageSource.camera);
    setState(() {
      driverImage = ui;
    });
  }
}
