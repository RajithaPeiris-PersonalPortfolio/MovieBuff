import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_buff/model/user.dart';

import 'package:movie_buff/screen/color_theme.dart' as Theme;
import 'package:movie_buff/widgets/best_movies.dart';
import 'package:movie_buff/widgets/category.dart';
import 'package:movie_buff/widgets/movie_info.dart';
import 'package:movie_buff/widgets/now_playing.dart';
import 'package:movie_buff/widgets/owners.dart';
import 'package:movie_buff/widgets/search_movies.dart';
import 'package:movie_buff/widgets/similar_movies.dart';
import 'package:movie_buff/widgets/trending_persons.dart';

import 'movie_inquiry.dart';

class MovieSearchInquiry extends StatefulWidget {
  final String name;
  final User user;
  MovieSearchInquiry({Key? key, required this.name, required this.user,}) : super(key: key);

  @override
  _MovieSearchInquiryState createState() => _MovieSearchInquiryState(name, user);
}

class _MovieSearchInquiryState extends State<MovieSearchInquiry> {
  final String name;
  final User user;
  _MovieSearchInquiryState(this.name, this.user);
  @override
  Widget build(BuildContext context) {
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
                        MovieInquiry(user: user,),
                  ),
                );
              },
              icon: Icon(EvaIcons.arrowBack, color: Colors.white,)
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          NowPlaying(user: user),
          SearchMoviesDetails(name: name, user: user,),
        ],
      ),
    );
  }
}
