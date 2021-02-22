import 'package:Restaurant_social_mobile_app/feature/authentication/AuthScreen.dart';
import 'package:Restaurant_social_mobile_app/feature/error/SomethingWentWrong.dart';
import 'package:Restaurant_social_mobile_app/feature/home/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'data/remote/FirebaseManager.dart';
import 'feature/loader/Loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      print(e.toString());
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: getView(),
    );
  }

  getView() {
    if (_error) {
      return SomeThingWentWrong();
    }
    if (!_initialized) {
      return Loading();
    }

    if (FirebaseManger.instance.getCurrentUser() != null) {
      return HomeScreen();
    }

    return AuthScreen(
      title: "Authentication",
    );
  }
}
