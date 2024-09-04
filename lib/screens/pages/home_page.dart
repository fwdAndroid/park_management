import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:park_management/screens/add/add_vehicle.dart';
import 'package:park_management/uitls/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownvalue = 'Car';
  var items = [
    'Car',
    'Motor Cycle',
    'Truck',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(child: Text('No data available'));
                    }
                    var snap = snapshot.data;
                    return Text(
                      "Hello, " + snap['fullName'],
                      style: GoogleFonts.poppins(
                          color: appColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Select Vehicle \nType",
                style: GoogleFonts.poppins(fontSize: 27, color: appColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                // Initial Value
                value: dropdownvalue,
                isExpanded: true,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => AddVehicle(
                              carType: dropdownvalue,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/c.png",
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
