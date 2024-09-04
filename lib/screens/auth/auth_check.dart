import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:park_management/screens/auth/auth_login.dart';
import 'package:park_management/screens/main_dashboard.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          // If user is logged in, navigate to MainDashboard
          return MainDashboard();
        } else {
          // If not logged in, navigate to LoginScreen
          return const LoginScreen();
        }
      },
    );
  }
}
