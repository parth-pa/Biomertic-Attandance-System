import 'package:attandance_system/Screens/give_attandance.dart';
import 'package:attandance_system/Screens/employe_details_screen.dart';
import 'package:flutter/material.dart';

class bottomnavbar extends StatefulWidget {
  const bottomnavbar({Key? key}) : super(key: key);

  @override
  State<bottomnavbar> createState() => _bottomnavbarState();
}

class _bottomnavbarState extends State<bottomnavbar> {
  int _curruntindex = 0;
  void ontap(int index) {
    setState(() {
      _curruntindex = index;
    });
  }

  List pages = [
    GiveAttandance(),
    const Employedata(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_curruntindex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue[400],
        unselectedItemColor: Colors.black54,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 20,
        currentIndex: _curruntindex,
        onTap: ontap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 27,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 27,
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
