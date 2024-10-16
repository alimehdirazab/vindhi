import 'package:flutter/material.dart';
import 'package:vindhi_app/presentation/pages/auth/select_sign_in_option_screen.dart';
import 'package:vindhi_app/presentation/pages/client_app/home/client_home_screen.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  static const String routeName = "ClientHomePage";

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  int currentIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();
  List<Widget> screens = [
    const ClientHomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.98),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white, // Ending color (Orange)
              Color.fromARGB(127, 125, 195, 252), // Starting color (Green)
            ],
          ),
        ),
        child: PageStorage(
          bucket: _bucket,
          child: SafeArea(child: screens[currentIndex]),
        ),
      ),
      // Entire custom nav bar is now placed here in `floatingActionButton`
      floatingActionButton: _buildCustomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildCustomNavBar() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SelectSignInOptionScreen.routeName);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(left: 90, right: 90, bottom: 10),
        decoration: BoxDecoration(
          //  color: Colors.orange,
          // Applying the gradient to the Scaffold background

          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green, // Starting color (Green)
              Colors.orange, // Ending color (Orange)
            ],
          ),

          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.account_box_outlined, color: Colors.white),
            SizedBox(height: 5),
            Text(
              'My Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildNavItem(IconData icon, String label, int index) {
  //   final bool isSelected = index == currentIndex;
  //   final Color color =
  //       isSelected ? Colors.orange : Colors.black.withOpacity(0.2);

  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         currentIndex = index;
  //       });
  //     },
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Icon(icon, color: color),
  //         const SizedBox(height: 5),
  //         Text(
  //           label,
  //           style: TextStyle(color: color, fontSize: 12),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
