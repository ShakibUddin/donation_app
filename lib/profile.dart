import 'package:donation_app/data.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${currentUser.name}'),
        ),
        body: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
