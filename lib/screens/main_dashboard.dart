import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_management/screens/pages/home_page.dart';
import 'package:park_management/screens/pages/verify_page.dart';
import 'package:park_management/uitls/colors.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const VerifyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await _showExitDialog(context);
          return shouldPop ?? false;
        },
        child: Scaffold(
          body: _screens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: TextStyle(color: mainColor),
            unselectedLabelStyle: const TextStyle(color: Colors.grey),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _currentIndex == 0 ? mainColor : Colors.grey,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.verified,
                  color: _currentIndex == 1 ? mainColor : Colors.grey,
                ),
                label: 'Vehicles',
              ),
            ],
          ),
        ));
  }

  _showExitDialog(BuildContext context) {
    Future<bool?> showExitDialog(BuildContext context) {
      return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Do you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    }
  }
}
