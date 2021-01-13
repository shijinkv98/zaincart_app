import 'package:flutter/material.dart';
import 'package:zaincart_app/screens/favourite_screen.dart';
import 'package:zaincart_app/screens/home_screen.dart';
import 'package:zaincart_app/screens/my_cart_screen.dart';
import 'package:zaincart_app/screens/settings_screen.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class HomeController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeControllerState();
  }
}

class _HomeControllerState extends State<HomeController> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    SettingsScreen(),
    FavouriteScreen(),
    MyCartScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _children[_currentIndex],
    
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home, color: Constants.zc_orange,),
            label: "", 
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.settings,color: Constants.zc_orange,),
            label: "", 
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.favorite,color: Constants.zc_orange,),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,color: Constants.zc_orange,),
            label: ""
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
