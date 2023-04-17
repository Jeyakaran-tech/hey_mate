import 'package:flutter/material.dart';
import 'package:hey_mate/pages/user_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AfterSigninScreen extends StatefulWidget {
  const AfterSigninScreen({super.key});

  @override
  _AfterSigninScreenState createState() => _AfterSigninScreenState();

}

class _AfterSigninScreenState extends State<AfterSigninScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    if(user != null) {
      UserInfoScreen userInfoScreen = UserInfoScreen(user: user!);
      _widgetOptions.add(userInfoScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: const Text('BottomNavigationBar Sample'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Some thing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
