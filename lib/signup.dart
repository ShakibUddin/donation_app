import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

import 'data.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _name;
  String _password;
  String _confirmPassword;
  String _mobileNumber;
  String _email;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.blue,
                              size: 30,
                            ),
                            labelText: 'Name',
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
                            _name = value;
                          },
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Enter name.';
                            } else if (value.length < 3 || value.length > 25) {
                              return 'Name must be within 03-25 characters.';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
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
                              return 'Mobile number must be 11 characters long.';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock_open,
                              color: Colors.blue,
                              size: 30,
                            ),
                            labelText: 'Password',
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
                            _password = value;
                          },
                          onChanged: (value) {
                            _password = value;
                          },
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Enter password.';
                            } else if (value.length < 4 || value.length > 20) {
                              return 'Password must be within 04-20 characters.';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: Colors.blue,
                              size: 30,
                            ),
                            labelText: 'Confirm Password',
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
                            _confirmPassword = value;
                          },
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Confirm password.';
                            } else if (value != _password) {
                              return 'Passwords do not match.';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: <Widget>[
                            RaisedButton(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              color: Colors.blue,
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  UserCredentials.id = UserCredentials.id + 1;
                                  userCredentials.add(new UserCredentials(
                                      _name, _email, _mobileNumber, _password));
                                  Navigator.of(context).pop();
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Invalid data'),
                                  ));
                                }
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                FlatButton(
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 15),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }
}
