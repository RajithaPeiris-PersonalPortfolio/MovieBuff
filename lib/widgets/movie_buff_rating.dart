import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_buff/model/user.dart';

import 'package:movie_buff/screen/color_theme.dart' as Theme;

class MovieBuffRating extends StatefulWidget {
  final int id;
  final User user;
  MovieBuffRating({required this.id, required this.user}) : super();
  @override
  _MovieBuffRatingState createState() => _MovieBuffRatingState(id, user);
}

class _MovieBuffRatingState extends State<MovieBuffRating> {
  final int id;
  final User user;
  _MovieBuffRatingState(this.id, this.user);

  late Query _ref;
  DatabaseReference _dbref =
  FirebaseDatabase.instance.reference().child('movie_rating');

  @override
  void initState() {
    super.initState();
    _dbref = FirebaseDatabase.instance.reference();
    _ref = _dbref.child('movie_rating').orderByChild('movie_id').equalTo(id);

  }

  _readdb_user(){
    print("movie_id : " + this.id.toString());
    /*_dbref.child('movie_rating').orderByChild('movie_id').equalTo(id)
        .onChildAdded.listen((event) {
      print("get movie_rating=> "+event.snapshot.value.toString());
      print("get movie_rating key=> "+event.snapshot.key.toString());
      if (i==0 && event.snapshot.value!=null) {
        //_showAlertDialog("Username already exists.");
        setState(() {
          //username = event.snapshot.value["username"].toString();
         // password = event.snapshot.value["password"].toString();
          //_dataSnapshotUser = event.snapshot;
          *//*user = User(event.snapshot.key.toString(),
              event.snapshot.value["username"],
              event.snapshot.value["name"],
              event.snapshot.value["mobileNo"]);*//*
        });
        //emailController.text = "";
      } else {
        setState(() {
          //username = "";
          //_dataSnapshotUser;
        });
      }
    });*/

    _dbref.child('movie_rating').orderByChild('movie_id').equalTo(id)
        .once().then((DataSnapshot dataSnapshot){
      print(" read once - "+ dataSnapshot.value.toString() );
      setState(() {
        //data = dataSnapshot.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "MOVIE BUFF RATINGS AND REVIEWS",
            style: TextStyle(
                color: Theme.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
         _buildHomeWidget(),
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

  Widget _buildErrorWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No Data to fetch " ,
          style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0),
        ),
      ],
    ));
  }

  Widget _buildHomeWidget() {

     return Container(
        height: 300.0,
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
        child: FirebaseAnimatedList(
          query: _ref,
          defaultChild: _buildLoadingWidget(),
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            return Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 15.0, right: 15.0, left: 5.0),
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0.0, bottom: 10.0, left:5.0, right: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 250,
                                child: Text(
                                  snapshot.value["name"] + " ("
                                      + snapshot.value["date"] + ")",
                                  maxLines: 2,
                                  style: TextStyle(
                                      height: 1.4,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    snapshot.value["rating"].toString() + " - ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  RatingBar(
                                    ratingWidget: RatingWidget(
                                      empty: Icon(
                                        EvaIcons.star,
                                        color: Colors.white,
                                      ),
                                      full: Icon(
                                        EvaIcons.star,
                                        color: Colors.orange,
                                      ),
                                      half: Icon(
                                        EvaIcons.star,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                    itemSize: 14.0,
                                    initialRating: double.parse(snapshot.value["rating"].toString()),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    ignoreGestures: true,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                    onRatingUpdate: (rating) {
                                      //print(movies[index].trendingStatus);
                                    },
                                    updateOnDrag: false,
                                    unratedColor: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: 325,
                                child: Text(
                                  snapshot.value["review"],
                                  maxLines: 3,
                                  style: TextStyle(
                                      height: 1.4,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 5.0, color: Colors.grey, thickness: 1.0,),
                  ],
                ),
              ),
            );
           // Map contact = snapshot.value;
            //contact['key'] = snapshot.key;
            //return _buildContactItem(contact: contact);
          },
        ),
        /*child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 0,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 15.0, right: 15.0, left: 5.0),
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 10.0, left:5.0, right: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                              width: 250,
                              child: Text(
                                "",//movies[index].movieTitle,
                                maxLines: 2,
                                style: TextStyle(
                                    height: 1.4,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "movies[index].trendingStatus.toString()",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                RatingBar(
                                  ratingWidget: RatingWidget(
                                    empty: Icon(
                                      EvaIcons.star,
                                      color: Colors.white,
                                    ),
                                    full: Icon(
                                      EvaIcons.star,
                                      color: Colors.orange,
                                    ),
                                    half: Icon(
                                      EvaIcons.star,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  itemSize: 14.0,
                                  initialRating: 4,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  ignoreGestures: true,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                  onRatingUpdate: (rating) {
                                    //print(movies[index].trendingStatus);
                                  },
                                  updateOnDrag: false,
                                  unratedColor: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              width: 325,
                              child: Text(
                                "dsjkkjhkfdjkfhdsjfhjdhfjdkhfjkdsfjkdjdkfjhjkfhsdjhfkjdshjdhjdkfhjdfdjdjdksjhfkdjfs",
                                maxLines: 3,
                                style: TextStyle(
                                    height: 1.4,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ],
                    ),
                    Divider(height: 5.0, color: Colors.grey, thickness: 1.0,),
                  ],
                ),
              ),
            );
          },
        ),*/
      );
  }

}
