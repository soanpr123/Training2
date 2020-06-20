import 'package:flutter/material.dart';
import 'package:my_travel/src/model/base_model/login.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/ui/navigation/flights_screen.dart';
import 'package:my_travel/src/ui/navigation/hotels_screen.dart';
import 'package:my_travel/src/ui/navigation/profile_screen.dart';
import 'package:my_travel/src/ui/navigation/travel_screen.dart';

class Navigation extends StatefulWidget {
  DatumLogin datumLogin = DatumLogin();

  Navigation({this.datumLogin});

  State createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: [
          new TravelScreen(),
          new FlightsScreen(),
          new HotelsScreen(),
          new ProfileScreen(
            datumLogin: widget.datumLogin,
          ),
        ].elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/icon/icon_travel.png',
              width: 20,
            ),
            title: Text(
              'Travel',
              style: TextStyle(fontSize: 14),
            ),
            activeIcon: Container(
              child: Image.asset(
                'assets/icon/icon_travel2.png',
                width: 20,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/icon/icon_fly.png',
              width: 20,
            ),
            activeIcon: Container(
              child: Image.asset(
                'assets/icon/icon_fly2.png',
                width: 20,
              ),
            ),
            title: Text('Flights', style: TextStyle(fontSize: 14)),
          ),
          BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/icon/icon_hotels.png',
              width: 20,
            ),
            activeIcon: Container(
              child: Image.asset(
                'assets/icon/icon_hotels2.png',
                width: 20,
              ),
            ),
            title: Text('Hotels', style: TextStyle(fontSize: 14)),
          ),
          BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/icon/icon_profile.png',
              width: 20,
            ),
            activeIcon: Container(
              child: Image.asset(
                'assets/icon/icon_profile2.png',
                width: 20,
              ),
            ),
            title: Container(child: Text('Profile', style: TextStyle(fontSize: 14))),
          ),
        ],
        unselectedFontSize: 8,
        selectedFontSize: 8,
        currentIndex: selectedIndex,
        fixedColor: Palette.COLOR_ICON_NAVIGATION,
        onTap: onItemTapped,
      ),
    );
  }

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: new Image.asset(
        'assets/icon/icon_travel.png',
        width: 20,
      ),
      title: Text(
        'Travel',
        style: TextStyle(fontSize: 14),
      ),
      activeIcon: Container(
        child: Image.asset(
          'assets/icon/icon_travelclick.png',
          width: 30,
        ),
      ),
    ),
    BottomNavigationBarItem(
      icon: new Image.asset(
        'assets/icon/icon_fly.png',
        width: 30,
      ),
      activeIcon: Container(
        child: Image.asset(
          'assets/icon/icon_fly.png',
          width: 30,
        ),
      ),
      title: Text('Flights', style: TextStyle(fontSize: 14)),
    ),
    BottomNavigationBarItem(
      icon: new Image.asset(
        'assets/icon/icon_hotels.png',
        width: 30,
      ),
      activeIcon: Container(
        child: Image.asset(
          'assets/icon/icon_hotels.png',
          width: 30,
        ),
      ),
      title: Text('Hotels', style: TextStyle(fontSize: 14)),
    ),
    BottomNavigationBarItem(
      icon: new Image.asset(
        'assets/icon/icon_profile.png',
        width: 30,
      ),
      activeIcon: Container(
        child: Image.asset(
          'assets/icon/icon_profile.png',
          width: 30,
        ),
      ),
      title: Text('Profile', style: TextStyle(fontSize: 14)),
    ),
  ];
}
