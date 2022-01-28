import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_buff/bloc/get_trending_persons_bloc.dart';
import 'package:movie_buff/model/trending_person.dart';
import 'package:movie_buff/response/trending_person_response.dart';

import 'package:movie_buff/screen/color_theme.dart' as Theme;

class TrendingPersonsList extends StatefulWidget {
  @override
  _TrendingPersonsListListState createState() => _TrendingPersonsListListState();
}

class _TrendingPersonsListListState extends State<TrendingPersonsList> {
  @override
  void initState() {
    super.initState();
    trendingPersonBloc..getTrendingPersonsInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "TRENDING PERSONS ON THIS WEEK",
            style: TextStyle(
                color: Theme.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<TrendingPersonResponse>(
          stream: trendingPersonBloc.subject.stream,
          builder: (context, AsyncSnapshot<TrendingPersonResponse> snapshot) {
            if (snapshot.hasData) {
              print("+++++++++++++++++++++++++++");
              print(snapshot.data!.error);
              if (snapshot.data!.error != null && snapshot.data!.error!="") {
                String? errorVal = snapshot.data?.error;
                print("+++++++++++++++++++++++++++");
                return _buildErrorWidget(errorVal!);
              }
              print("777777777777777777777");
              return _buildHomeWidget(snapshot.data!);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error.toString());
            } else {
              return _buildLoadingWidget();
            }
          },
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
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(TrendingPersonResponse data) {
    List<TrendingPerson> persons = data.tpInfo;
    if (persons.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Persons",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 116.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: persons.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 10.0, right: 8.0),
              width: 100.0,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    persons[index].profileImage == "no-image"
                        ? Hero(
                            tag: persons[index].id,
                            child: Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.Colors.secondColor),
                              child: Icon(
                                FontAwesomeIcons.userAlt,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Hero(
                            tag: persons[index].id,
                            child: Container(
                                width: 70.0,
                                height: 70.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w300/" +
                                              persons[index].profileImage)),
                                )),
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      persons[index].name,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 9.0),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      "Trending for " + persons[index].knownForDepartment,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1.4,
                          color: Theme.Colors.titleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 7.0),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
