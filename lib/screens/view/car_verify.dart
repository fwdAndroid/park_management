import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:park_management/screens/view/verify_driver_photo.dart';
import 'package:park_management/uitls/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CarVerfiy extends StatefulWidget {
  String carNumber;
  String address;
  String carCategory;
  String uuid;
  String ownerName;
  String phoneNumber;
  String driverPhoto;

  CarVerfiy(
      {super.key,
      required this.address,
      required this.carCategory,
      required this.carNumber,
      required this.ownerName,
      required this.phoneNumber,
      required this.driverPhoto,
      required this.uuid});

  @override
  State<CarVerfiy> createState() => _CarVerfiyState();
}

class _CarVerfiyState extends State<CarVerfiy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        centerTitle: true,
        title: Text(
          "Visualize veículos registados",
          style: TextStyle(color: black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Detalhe do driver",
              style: GoogleFonts.poppins(fontSize: 27, color: appColor),
            ),
          ),
          ListTile(
            leading: FittedBox(
              fit: BoxFit.cover,
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.driverPhoto),
                radius: 60,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nome do driver",
                  style: GoogleFonts.poppins(
                      fontSize: 27, color: const Color(0xff27B482)),
                ),
                Text(widget.ownerName),
                Text(
                  "Endereço",
                  style: GoogleFonts.poppins(
                      fontSize: 18, color: const Color(0xffBABABA)),
                ),
                Text(widget.address),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Número de telefone",
                  style: GoogleFonts.poppins(
                      fontSize: 18, color: const Color(0xffBABABA)),
                ),
                Text(widget.phoneNumber),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => VerifyDriverPhoto(
                                    driverPhoto: widget.driverPhoto,
                                    uuid: widget.uuid,
                                  )));
                    },
                    child: const Text("Ver foto do driver para verificar"))),
          ),
        ],
      ),
    );
  }

  Future<void> openDialPad(String phoneNumber) async {
    if (phoneNumber.isNotEmpty) {
      // Trim any unnecessary spaces
      String sanitizedNumber = phoneNumber.trim();

      final Uri phoneUri = Uri(scheme: 'tel', path: sanitizedNumber);

      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $phoneUri';
      }
    } else {
      throw 'Phone number is empty or invalid';
    }
  }
}
