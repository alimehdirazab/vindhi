import 'package:flutter/material.dart';
import 'package:vindhi_app/core/ui.dart';
import 'package:vindhi_app/presentation/pages/auth/sign_in_screen.dart';
import 'package:vindhi_app/presentation/pages/client_app/home/client_home_page.dart';
import 'package:vindhi_app/presentation/pages/home/dashboard_screen.dart';
import 'package:vindhi_app/presentation/pages/home/profile_screen.dart';
import 'package:vindhi_app/presentation/pages/others/lead_form_screen.dart';
import 'package:vindhi_app/presentation/pages/others/notification_screen.dart';
import 'package:vindhi_app/presentation/widgets/drawer_tile.dart';
import 'package:vindhi_app/presentation/widgets/gap_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = "homePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();
  List<Widget> screens = [
    const DashboardScreen(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.98),
      appBar: AppBar(
        title: Image.asset('assets/app_logo.png', height: 30),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, NotificationScreen.routeName);
              },
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: Colors.grey,
              )),
          IconButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushNamed(context, ClientHomePage.routeName);
            },
            icon: const Icon(
              Icons.power_settings_new_outlined,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: PageStorage(
        bucket: _bucket,
        child: SafeArea(child: screens[currentIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
            ),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              size: 35,
            ),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              size: 35,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_florist_outlined,
              size: 35,
            ),
            label: "Services",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_3_outlined,
              size: 35,
            ),
            label: "Profile",
          ),
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: AppColors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 20, 133, 24),
                          Colors.orange
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        const GapWidget(size: 10),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white.withOpacity(0.8),
                          child: const Icon(
                            Icons.person_3_outlined,
                            size: 40,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const GapWidget(size: -10),
                        Text('Vf557214',
                            style:
                                TextStyles.body2.copyWith(color: Colors.white)),
                        Text('Employee ID',
                            style:
                                TextStyles.body2.copyWith(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const GapWidget(),
                DrawerTile(
                  icon: Icons.home_outlined,
                  title: 'Home',
                  onTap: () {
                    Navigator.pushReplacementNamed(context, HomePage.routeName);
                  },
                ),
                DrawerTile(
                  icon: Icons.person_2_outlined,
                  title: 'Profile',
                  onTap: () {
                    Navigator.pushNamed(context, ProfileScreen.routeName);
                  },
                ),
                DrawerTile(
                  icon: Icons.notifications_none_outlined,
                  title: 'Notifications',
                  onTap: () {
                    Navigator.pushNamed(context, NotificationScreen.routeName);
                  },
                ),
                DrawerTile(
                  icon: Icons.calendar_today_outlined,
                  title: 'Attendance',
                  onTap: () {
                    // Implement navigation for Attendance
                  },
                ),
                DrawerTile(
                  icon: Icons.assignment_turned_in_outlined,
                  title: 'Lead Customer Form',
                  onTap: () {
                    Navigator.pushNamed(context, LeadFormScreen.routeName);
                  },
                ),
                DrawerTile(
                  icon: Icons.check_circle_outline,
                  title: 'Approve/Disapprove',
                  onTap: () {
                    // Implement navigation for Approve/Disapprove
                  },
                ),
                DrawerTile(
                  icon: Icons.money_off_outlined,
                  title: 'Salary Slip',
                  onTap: () {
                    // Implement navigation for Salary Slip
                  },
                ),
                DrawerTile(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {
                    // Implement navigation for Help & Support
                  },
                ),
                DrawerTile(
                  icon: Icons.star_border_outlined,
                  title: 'Rating',
                  onTap: () {
                    // Implement navigation for Rating
                  },
                ),
                DrawerTile(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    // Navigator.popUntil(context, (route) => route.isFirst);
                    // Navigator.pushNamed(context, SignInScreen.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
