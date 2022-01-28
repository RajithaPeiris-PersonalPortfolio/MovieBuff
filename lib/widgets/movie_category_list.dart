import 'package:flutter/material.dart';
import 'package:movie_buff/bloc/get_movies_by_category_bloc.dart';
import 'package:movie_buff/model/movie_category.dart';
import 'package:movie_buff/model/user.dart';
import 'package:movie_buff/screen/color_theme.dart' as Theme;

import 'movies_by_category.dart';

class CategoryList extends StatefulWidget {
  final List<MovieCategory> genres;
  final User user;
  CategoryList({required this.genres, required this.user}) : super();

  @override
  _GenresListState createState() => _GenresListState(genres, user);
}

class _GenresListState extends State<CategoryList> with SingleTickerProviderStateMixin {
  final List<MovieCategory> genres;
  final User user;
  _GenresListState(this.genres, this.user);
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: genres.length);
    _tabController.addListener(() {
        if (_tabController.indexIsChanging) {
          moviesByMovieCtegoryBloc..drainStream();
        }
      });
  }

  @override
 void dispose() {
   _tabController.dispose();
   super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 307.0,
              child: DefaultTabController(
          length: genres.length,
          child: Scaffold(
            backgroundColor: Theme.Colors.mainColor,
            appBar: PreferredSize(
                          preferredSize: Size.fromHeight(50.0),
                          child: AppBar(
                            backgroundColor: Theme.Colors.mainColor,
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Theme.Colors.secondColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3.0,
                  unselectedLabelColor: Theme.Colors.titleColor,
                  labelColor: Colors.white,
                  isScrollable: true,
                  tabs: genres.map((MovieCategory genre) {
                return Container(
            padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
            child: new Text(genre.name.toUpperCase(), style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            )));
              }).toList(),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: genres.map((MovieCategory genre) {
              return MovieByCategory(genreId: genre.id, user: user,);
            }).toList(),
          ),
        ),
    ));
  }
}