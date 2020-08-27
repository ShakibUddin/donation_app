import 'package:donation_app/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;
  bool validCredentials = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Builder(
          builder: (BuildContext context){
            return Container(
              child: Stack(
                overflow: Overflow.visible,
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  Colors.black38, BlendMode.darken),
                              child: Image(
                                image: AssetImage('images/food_share.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                      Expanded(
                        flex: 1,
                        child: Container(color: Colors.grey.shade200),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 200,
                    child: Container(
                      child: Text(
                        'Sharing is Caring',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Pacifico',
                            fontSize: 40),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.all(20),
                        child: Wrap(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                  Border.all(color: Colors.white, width: 0)),
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  icon: Icon(Icons.email),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                onSaved: (value) {
                                  _email = value;
                                },
                                validator: (value) {
                                  if (value.length == 0) {
                                    return 'Enter email';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Divider(
                              color: Colors.grey.withOpacity(0.3),
                              thickness: 1,
                              height: 5,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                  Border.all(color: Colors.white, width: 0)),
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  icon: Icon(Icons.lock),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                onSaved: (value) {
                                  _password = value;
                                },
                                validator: (value) {
                                  if (value.length == 0) {
                                    return 'Enter password';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                          padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                          color: Colors.blue,
                          child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 20),),
                          onPressed: (){
                            if(_formKey.currentState.validate()){
                              _formKey.currentState.save();
                              for(UserCredentials user in userCredentials){
                                if(user.email == _email && user.password == _password){
                                  currentUser = user;
                                  validCredentials = true;
                                  break;
                                }
                              }
                              if(validCredentials){
                                _formKey.currentState.reset();
                                Navigator.pushNamedAndRemoveUntil(context, "/timeline", (r) => false);
                              }
                              else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Invalid username/password'),
                                ));
                              }
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('New User?',style: TextStyle(color: Colors.black,fontSize: 15),),
                            FlatButton(
                              child: Text('Sign Up',style: TextStyle(color: Colors.blue,fontSize: 15),),
                              onPressed: (){
                                Navigator.of(context).pushNamed('/signup');
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
