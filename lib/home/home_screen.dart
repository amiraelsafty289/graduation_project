import 'package:flutter/material.dart';
import 'package:flutter_blood_bank_app/home/about_us.dart';
import 'package:flutter_blood_bank_app/home/home_tab.dart';
import 'package:flutter_blood_bank_app/home/doctor_tab.dart';
import 'package:flutter_blood_bank_app/home/third_tab.dart';

class HomeScreen extends StatefulWidget {
  static String ROUTE_NAME = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/background.png',
              )),
        ),
        child: Scaffold(
          // appBar: AppBar(
          //   title: const Text(
          //     '',
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 24),
          //   ),
          // ),
          bottomNavigationBar: Theme(
            data: ThemeData(canvasColor: Colors.blue),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                currentIndex = index;
                setState(() {});
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.dock_outlined), label: 'Doctors'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.rate_review_outlined), label: 'About Us'),
              ],
            ),
          ),
          body: tabs[currentIndex]
        ),
      ),
    );
  }
  List<Widget> tabs = [HomeTab(),DoctorTab(),ThirdTab(),AboutUs()];
}
