import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:park_management/screens/auth/auth_login.dart';
import 'package:park_management/uitls/colors.dart';
import 'package:park_management/uitls/message_utils.dart';
import 'package:park_management/widgets/save_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController providerPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Forgot password,",
              style: GoogleFonts.workSans(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Please type your email below and we will give you a OTP code,",
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
              ),
            ),
          ),
          Flexible(child: Container()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: providerPassController,
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
                  hintStyle:
                      GoogleFonts.plusJakartaSans(color: black, fontSize: 12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SaveButton(
                title: "Send",
                onTap: () async {
                  if (providerPassController.text.isEmpty) {
                    showMessageBar("Email is Required", context);
                  } else {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(
                            email: providerPassController.text.trim())
                        .then((value) => {
                              FirebaseAuth.instance.signOut(),
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          const LoginScreen()))
                            });
                    showMessageBar("Email verification link is sent", context);
                  }
                }),
          ),
          Flexible(child: Container()),
        ],
      ),
    );
  }
}
