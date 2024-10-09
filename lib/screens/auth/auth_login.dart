import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:park_management/screens/auth/forgot_password.dart';
import 'package:park_management/screens/auth/signup_screen.dart';
import 'package:park_management/screens/main_dashboard.dart';
import 'package:park_management/services/auth_methods.dart';
import 'package:park_management/uitls/colors.dart';
import 'package:park_management/uitls/message_utils.dart';
import 'package:park_management/widgets/save_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Image.asset(
            "assets/newlogo.png",
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
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
            margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => ChangePassword()));
                    },
                    child: const Text("Esqueceu-se da palavra-passe"))
              ],
            ),
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
                    title: "Login",
                    onTap: () async {
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        showMessageBar(
                            "E-mail e senha são necessários", context);
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        await AuthMethods().loginUpUser(
                          email: _emailController.text.trim(),
                          pass: _emailController.text.trim(),
                        );

                        setState(() {
                          isLoading = false;
                        });
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => const SignupScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                  TextSpan(text: 'Não tem uma conta? ', children: <InlineSpan>[
                TextSpan(
                  text: 'Registar-me',
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
