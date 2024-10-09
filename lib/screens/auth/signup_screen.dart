import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:park_management/screens/auth/auth_login.dart';
import 'package:park_management/screens/main_dashboard.dart';
import 'package:park_management/services/auth_methods.dart';
import 'package:park_management/uitls/colors.dart';
import 'package:park_management/uitls/message_utils.dart';
import 'package:park_management/widgets/save_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool isChecked = false;
  bool passwordVisible = false;
  bool isLoading = false;
  bool isGoogle = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo.png",
            height: 104,
            width: 104,
            fit: BoxFit.cover,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              controller: _nameController,
              style: GoogleFonts.plusJakartaSans(color: mainColor),
              decoration: InputDecoration(
                  fillColor: borderColor,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: borderColor)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: borderColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: borderColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: borderColor)),
                  hintText: "Insira o nome",
                  hintStyle: GoogleFonts.plusJakartaSans(
                      color: textColors, fontSize: 12)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: TextFormField(
              controller: _emailController,
              style: GoogleFonts.plusJakartaSans(color: mainColor),
              decoration: InputDecoration(
                  fillColor: borderColor,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: borderColor)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: borderColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: borderColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: borderColor)),
                  hintText: "Digite o endereço de e-mail",
                  hintStyle: GoogleFonts.plusJakartaSans(
                      color: textColors, fontSize: 12)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: TextFormField(
              obscureText: passwordVisible,
              controller: _passwordController,
              style: GoogleFonts.plusJakartaSans(color: mainColor),
              decoration: InputDecoration(
                  fillColor: borderColor,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          passwordVisible = !passwordVisible;
                        },
                      );
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: borderColor)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: borderColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: borderColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: borderColor)),
                  hintText: "Introduza a palavra-passe",
                  hintStyle: GoogleFonts.plusJakartaSans(
                      color: textColors, fontSize: 12)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SaveButton(
                    title: "Sign Up",
                    onTap: () async {
                      if (_nameController.text.isEmpty) {
                        showMessageBar(
                            "O nome do usuário é obrigatório", context);
                      } else if (_emailController.text.isEmpty) {
                        showMessageBar("O e-mail é obrigatório", context);
                      } else if (_passwordController.text.isEmpty) {
                        showMessageBar("A palavra-passe é necessária", context);
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        await AuthMethods().signUpUser(
                          email: _emailController.text.trim(),
                          pass: _passwordController.text.trim(),
                          username: _nameController.text.trim(),
                        );
                        setState(() {
                          isLoading = false;
                        });
                        showMessageBar("Inscrições Concluídas", context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => MainDashboard()));
                      }
                    },
                  ),
                ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => const LoginScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(TextSpan(
                  text: 'Already have an account? ',
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: mainColor),
                    )
                  ])),
            ),
          ),
        ],
      ),
    );
  }
}
