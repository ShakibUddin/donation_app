import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'data.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {

  String _imagePath;
  String _address;
  String _mobileNumber;
  String _email;
  String _description;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    Future openCamera() async {
      final image = await ImagePicker().getImage(source: ImageSource.camera);
      setState(() {
        _imagePath = image.path;
      });
    }

    Future openGallery() async {
      final image = await ImagePicker().getImage(source: ImageSource.gallery);
      setState(() {
        _imagePath = image.path;
      });
    }

    void showSuccessDialogue(BuildContext context) {
      showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(10.0)),
            content: Container(
              padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.thumb_up,size: 80,color: Colors.green,),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Post uploaded successfully.',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  ],
                )),
          );
        },
      );
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Upload Page'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.done,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  posts.add(new Post(currentUser.name, _description, _imagePath,
                      _mobileNumber, _address, _email));
                  showSuccessDialogue(context);
                }
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Builder(
            builder: (BuildContext context) {
              return Container(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _imagePath == null
                            ? Image.asset(
                                'images/food_bowl.jpg',
                                fit: BoxFit.contain,
                                width: 300,
                                height: 300,
                              )
                            : Image.file(
                                File(_imagePath),
                                fit: BoxFit.contain,
                                height: 300,
                                width: 300,
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                size: 30,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                 openCamera();
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.image,
                                size: 30,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                openGallery();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.location_on,
                              color: Colors.blue,
                              size: 30,
                            ),
                            labelText: 'Address',
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                          ),
                          onSaved: (value) {
                            _address = value;
                          },
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Enter address.';
                            } else if (value.length < 5 || value.length > 30) {
                              return 'Address must be within 03-30 characters.Current(${value.length})';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue: currentUser.email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Colors.blue,
                              size: 30,
                            ),
                            labelText: 'Email',
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                          ),
                          onSaved: (value) {
                            _email = value;
                          },
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Enter email.';
                            } else if (!EmailValidator.validate(value)) {
                              return 'Invalid email address.';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue: currentUser.mobile,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.blue,
                              size: 30,
                            ),
                            labelText: 'Mobile Number',
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                          ),
                          onSaved: (value) {
                            _mobileNumber = value;
                          },
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Enter mobile number.';
                            } else if (value.length < 11 || value.length > 11) {
                              return 'Mobile number must be 11 characters long.Current(${value.length})';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.description,
                              color: Colors.blue,
                              size: 30,
                            ),
                            labelText: 'Description',
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                          ),
                          onSaved: (value) {
                            _description = value;
                          },
                          onChanged: (value) {
                            _description = value;
                          },
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Enter description.';
                            } else if (value.length < 4 || value.length > 50) {
                              return 'Description must be within 05-50 characters.Current(${value.length})';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
