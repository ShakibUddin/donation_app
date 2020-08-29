
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:donation_app/data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {

  @override
  Widget build(BuildContext context) {
    Future<void> _makePhoneCall(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not call $url';
      }
    }
    Future<void> _sendEmail(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not call $url';
      }
    }
    Future<void> getCurrentLocation() async {
      final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        setState(() {
          latitude = position.latitude;
          longitude = position.longitude;
        });
      }).catchError((e) {
        print(e);
      });
    }
    void showCallDialogue(BuildContext context, Post post) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Call user?"),
            content: Text(
              "${post.mobile}",
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  _makePhoneCall("tel:${post.mobile}").then((value) =>
                      Navigator.of(context).pop());
                },
              ),
              FlatButton(
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void showEmailDialogue(BuildContext context, Post post) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Email user?"),
            content: Text(
              "${post.email}",
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  _sendEmail("mailto:${post.email}").then((value) =>
                      Navigator.of(context).pop());
                },
              ),
              FlatButton(
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void showLocationDialogue(BuildContext context, Post post) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("See location?"),
            content: Text(
              "${post.address}",
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  getCurrentLocation().whenComplete(() {
                    print("lat $latitude, long $longitude");
                    Navigator.of(context).pushNamed('/mappage');
                  });
                },
              ),
              FlatButton(
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Widget postCard(Post post) {
      return Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(4, 4),
          )
        ]),
        margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "${post.userName}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${post.address}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black26),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${post.description}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black38),
            ),
            SizedBox(
              height: 10,
            ),
            post.imagePath == null
                ? Image.asset(
              'images/food_bowl.jpg',
              fit: BoxFit.cover,
            )
                : Image.file(
              File(post.imagePath),
              fit: BoxFit.contain,
              height: 300,
              width: 300,
            ),
            Divider(color: Colors.grey, height: 20, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.phone, size: 30, color: Colors.green),
                  onPressed: () {
                    showCallDialogue(context, post);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.email,
                    size: 30,
                    color: Colors.deepOrange,
                  ),
                  onPressed: () {
                    showEmailDialogue(context, post);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.location_on,
                    size: 30,
                    color: Colors.indigo,
                  ),
                  onPressed: () {
                    showLocationDialogue(context, post);
                  },
                ),
              ],
            )
          ],
        ),
      );
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Lets Share"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/upload').then((value) {
                  setState(() {});
                });
              },
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return postCard(posts[index]);
            },
          ),
        ),
      ),
    );
  }
}
