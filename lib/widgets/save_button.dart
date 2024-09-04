import 'package:flutter/material.dart';
import 'package:park_management/uitls/colors.dart';

// ignore: must_be_immutable
class SaveButton extends StatelessWidget {
  String title;
  final void Function()? onTap;

  SaveButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(361, 49),
          backgroundColor: mainColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 14,
            fontFamily: "Mulish",
            fontWeight: FontWeight.w500,
            color: white),
      ),
    );
  }
}
