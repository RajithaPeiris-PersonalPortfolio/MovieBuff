import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_buff/model/user.dart';

import 'package:movie_buff/screen/color_theme.dart' as Theme;
import 'package:movie_buff/screen/user_management_screen.dart';
import 'package:movie_buff/widgets/best_movies.dart';
import 'package:movie_buff/widgets/category.dart';
import 'package:movie_buff/widgets/now_playing.dart';
import 'package:movie_buff/widgets/trending_persons.dart';

import 'movie_search_inquiry.dart';

class MovieInquiry extends StatefulWidget {
  final User user;
  MovieInquiry({Key? key, required this.user}) : super(key: key);

  @override
  _MovieInquiryState createState() => _MovieInquiryState(this.user);
}

class _MovieInquiryState extends State<MovieInquiry> {

  /*ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);//the listener for up and down.
    super.initState();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
  }*/

  final User user;
  _MovieInquiryState(this.user);

  @override
  Widget build(BuildContext context) {
    late String username="default";
    return Scaffold(
      backgroundColor: Theme.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Theme.Colors.mainColor,
        centerTitle: true,
        leading: Icon(EvaIcons.menu2Outline, color: Colors.white,),
        title: Text("MOVIE BUFF"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UserInquiry(username: username),
                  ),
                );
              },
              icon: Icon(EvaIcons.people, color: Colors.white,)
          )
        ],
      ),
      body: ListView(
        //controller: _controller,
        children: <Widget>[
          Column(
            children: [
              Container(
                width: 280.0,
                child: TextField(
                  onSubmitted: (String input) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieSearchInquiry(name: input, user: user,),
                      ),
                    );

                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter movie name here..',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    prefixIcon: Icon(
                      EvaIcons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Text(
                "",
                //errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 18.0),
              ),
            ],
          ),
          NowPlaying(user: user),
          CategoryScreen(user: user,),
          TrendingPersonsList(),
          BestMovies(user: user,),
        ],
      ),
    );
  }
}
