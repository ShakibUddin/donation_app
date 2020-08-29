import 'package:donation_app/timeline.dart';
import 'package:donation_app/login.dart';
import 'package:donation_app/profile.dart';
import 'package:donation_app/signup.dart';
import 'package:donation_app/upload.dart';
import 'package:flutter/material.dart';

import 'mappage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/' : (context) => Login(),
      '/login' : (context) => Login(),
      '/signup' : (context) => Signup(),
      '/timeline' : (context) => TimeLine(),
      '/profile' : (context) => Profile(),
      '/upload' : (context) => Upload(),
      '/mappage' : (context) => MapPage(),
    },
  ));
}

class Main extends StatefulWidget {

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

