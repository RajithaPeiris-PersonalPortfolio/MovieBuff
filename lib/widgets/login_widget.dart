import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_buff/model/movie_main.dart';
import 'package:movie_buff/model/user.dart';
import 'package:movie_buff/response/movie_main_response.dart';

import 'package:movie_buff/screen/color_theme.dart' as Theme;
import 'package:movie_buff/screen/movie_inquiry.dart';
import 'package:movie_buff/widgets/sign_up_widget.dart';

class LoginWidget extends StatefulWidget {

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late DatabaseReference _dbref;
  String databasejson = "";
  String idgenVal = "";
  int i = 0;
  bool error = false;
  late DataSnapshot _dataSnapshotUser;
  late DataSnapshot _dataSnapshotPw;

  late String password = "";
  late String username = "";
  late User user;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbref = FirebaseDatabase.instance.reference();
  }

  _readdb_user(){
    if(username=="" && emailController.text.trim()!="") {
      print(emailController.text.trim());
      _dbref.child('user').orderByChild('username').equalTo(emailController.text.trim())
          .onChildAdded.listen((event) {
        print("validate username=> "+event.snapshot.value.toString());
        print("validate username key=> "+event.snapshot.key.toString());
        if (i==0 && event.snapshot.value!=null) {
          //_showAlertDialog("Username already exists.");
          setState(() {
            username = event.snapshot.value["username"].toString();
            password = event.snapshot.value["password"].toString();
            _dataSnapshotUser = event.snapshot;
            user = User(event.snapshot.key.toString(),
                event.snapshot.value["username"],
                event.snapshot.value["name"],
                event.snapshot.value["mobileNo"]);
          });
          //emailController.text = "";
        } else {
          setState(() {
            username = "";
            _dataSnapshotUser;
          });
        }
      }).onError(_setErrorState());
    }
  }

  _setErrorState() {
    setState(() {
      error = false;
    });
  }

  _loginSystem() {
    if(username!="" && password!="" && passwordController.text.trim()!="") {
      if (password==passwordController.text.trim()) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MovieInquiry(user: user,),
          ),
        );
      } else {
        _showAlertDialog("Invalid login details..");
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
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
          body: Column(
            children: [
              Flexible(
                child: Center(
                  child: Text(
                    'MOVIE BUFF',
                    style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                          controller: emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(EvaIcons.person,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                            hintText: "Username",
                          ),
                          obscureText: false,
                          keyboardType: TextInputType.text,
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
                          //validator: _readdb_user(),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {},
                    child: Text(
                      'Forgot Password',
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
                        _loginSystem();
                      },
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(fontSize: 22, color: Colors.white,
                            height: 1.5).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpWidget(),
                  ),
                ),
                child: Container(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(fontSize: 22, color: Colors.white,
                        height: 1.5).copyWith(fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(width: 1, color: Colors.white))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No search data found: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(MovieMainResponse data) {
    List<MovieMain> movies = data.movieMainInfo;
    if (movies.isEmpty) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No Search Results..",
                  style: TextStyle(color: Colors.white),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 270.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: movies[index].id,
                      child: Container(
                          width: 120.0,
                          height: 180.0,
                          decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w200/" +
                                        movies[index].frontImage),
                          ))),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        movies[index].movieTitle,
                        maxLines: 2,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          movies[index].trendingStatus.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        RatingBar(
                          ratingWidget: RatingWidget(
                            empty: Icon(
                              EvaIcons.star,
                              color: Theme.Colors.secondColor,
                            ),
                            full: Icon(
                              EvaIcons.star,
                              color: Theme.Colors.secondColor,
                            ),
                            half: Icon(
                              EvaIcons.star,
                              color: Theme.Colors.secondColor,
                            ),
                          ),
                          itemSize: 8.0,
                          initialRating: movies[index].trendingStatus / 2,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
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
