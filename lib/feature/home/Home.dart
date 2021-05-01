import 'package:Restaurant_social_mobile_app/feature/authentication/AuthScreen.dart';
import 'package:Restaurant_social_mobile_app/feature/friends/FriendsRequestView.dart';
import 'package:Restaurant_social_mobile_app/feature/friends/FriendsView.dart';
import 'package:Restaurant_social_mobile_app/feature/map/MapScreen.dart';
import 'package:Restaurant_social_mobile_app/feature/post/Post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> idsToExclude = new List();
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    PostView(),
    FriendsView("friends"),
    MapScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,

        ),
        actions: [
          FlatButton(onPressed: () => {}, child: Icon(Icons.supervised_user_circle_rounded)),
          FlatButton(
              onPressed: () =>
                  {FirebaseAuth.instance.signOut(), goToLoginScreen()},
              child: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Restaurant',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  goToLoginScreen() {
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(
            title: "Authentication",
          ),
        ));
  }
}
