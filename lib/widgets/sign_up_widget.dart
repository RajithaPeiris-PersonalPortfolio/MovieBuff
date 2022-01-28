import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_buff/service/authentication.dart';
import 'package:movie_buff/widgets/login_widget.dart';
import 'package:rating_dialog/rating_dialog.dart';

class SignUpWidget extends StatefulWidget {

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  late DatabaseReference _dbref;
  String databasejson = "";
  String idgenVal = "";
  int i = 0;
  bool error = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbref = FirebaseDatabase.instance.reference();
  }

  _getIdGenValue(){
    if (emailController.text.trim()!="") {
      setState(() {
        i = 1;
      });
      _dbref.child('id_generator').child("key_val").child("sequence").once().then((DataSnapshot dataSnapshot){
        print(" read once - "+ dataSnapshot.value.toString() );
        setState(() {
          idgenVal = dataSnapshot.value.toString();
        });

        createUserRegistration(nameController.text.trim(),
            emailController.text.trim(), mobileNoController.text.trim(),
            emailController.text.trim(), passwordController.text.trim());
      });
    } else {
      _showAlertDialog("User name required");
      setState(() {
        i = 0;
      });
    }
  }

  _readdb_user(){
    print(emailController.text.trim());

    _dbref.child('user').orderByChild('email').equalTo(emailController.text.trim())
        .onChildAdded.listen((event) {
      print("validate user=> "+event.snapshot.value.toString());
      if (i==0 && event.snapshot.value!=null) {
        _showAlertDialog("Username already exists.");
        setState(() {
          error = true;
        });
        emailController.text = "";
      } else {
        setState(() {
          error = false;
        });
      }
    });

  }

  _setErrorState() {
    setState(() {
      error = false;
    });
  }

  createUserRegistration(String name, String email, String mobileNo,
      String username, String password) {
    try {
      if (idgenVal!="") {
        idgenVal = (int.parse(idgenVal)+1).toString();
        AuthenticationService.authUtil.updateIdGenerator(int.parse(idgenVal), int.parse(idgenVal));
      } else {
        AuthenticationService.authUtil.createIdGenerator();
        idgenVal = "1";
      }

      var userTbl = _dbref.child("user");
      userTbl.child(idgenVal).set(
          {
            'name': name,
            'email': email,
            'mobileNo': mobileNo,
            'username': username,
            'password': password
          }
      );
      userTbl.push();
    } catch (error, stacktrace) {
      print("Unhandled exception occurred during firebase invoke : error => $error stackTrace => $stacktrace");
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LoginWidget(),
      ),
    );
  }

  late String name;
 // late String email;
  //late String mobileNo;
  //late String password;
  //late String username;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) => LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [Colors.black, Colors.transparent],).createShader(rect),
          blendMode: BlendMode.darken,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background_img1.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.14,
                            backgroundColor: Colors.grey[400]?.withOpacity(
                              0.4,
                            ),
                            child: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.08,
                      left: MediaQuery.of(context).size.width * 0.56,
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.1,
                        width: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          FontAwesomeIcons.arrowUp,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]?.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Icon(EvaIcons.personAdd,
                                  size: 28,
                                  color: Colors.white,
                                ),
                              ),
                              hintText: "Name",
                            ),
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.none,
                            onChanged: (value) {
                              setState(() {
                                name = value.toString();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]?.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Icon(EvaIcons.email,
                                  size: 28,
                                  color: Colors.white,
                                ),
                              ),
                              hintText: "Email",
                            ),
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            validator: _readdb_user(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]?.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: mobileNoController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Icon(EvaIcons.phone,
                                  size: 28,
                                  color: Colors.white,
                                ),
                              ),
                              hintText: "Mobile Number",
                            ),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]?.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Icon(EvaIcons.unlock,
                                  size: 28,
                                  color: Colors.white,
                                ),
                              ),
                              hintText: "Password",
                            ),
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xff00bcd4),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          _getIdGenValue();
                        },
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(fontSize: 22, color: Colors.white,
                              height: 1.5).copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 22, color: Colors.white,
                              height: 1.5),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LoginWidget(),
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 22,
                                height: 1.5).copyWith(
                                color: Colors.indigoAccent, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> _showAlertDialog(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
