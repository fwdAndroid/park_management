import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:park_management/screens/view/car_verify.dart';
import 'package:park_management/uitls/colors.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: black),
          centerTitle: true,
          title: Text(
            "View Enter Cars",
            style: TextStyle(color: black),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("cars")
                    .where("uid",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "No Car is Available in this park ",
                        style: TextStyle(color: black),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        final Map<String, dynamic> data =
                            documents[index].data() as Map<String, dynamic>;
                        return Column(
                          children: [
                            Card(
                                child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  data['driverPhoto'],
                                ),
                              ),
                              title: Row(
                                children: [
                                  const Text(
                                    "Driver Name: ",
                                  ),
                                  Text(data['ownerName'])
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  const Text(
                                    "Car Number: ",
                                  ),
                                  Text(data['carNumber'])
                                ],
                              ),
                              trailing: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => CarVerfiy(
                                                uuid: data['uuid'],
                                                address: data['address'],
                                                carCategory:
                                                    data['carCategory'],
                                                carNumber: data['carNumber'],
                                                ownerName: data['ownerName'],
                                                driverPhoto:
                                                    data['driverPhoto'],
                                                phoneNumber:
                                                    data['phoneNumber'],
                                              )));
                                },
                                child: const Text("Verify"),
                              ),
                            )),
                          ],
                        );
                      });
                })));
  }
}
