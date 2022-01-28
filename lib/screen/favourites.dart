import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_buff/bloc/get_movie_videos_bloc.dart';
import 'package:movie_buff/model/Favourites.dart';
import 'package:movie_buff/model/movie_main.dart';
import 'package:movie_buff/model/user.dart';
import 'package:movie_buff/model/video.dart';
import 'package:movie_buff/response/video_response.dart';

import 'package:movie_buff/screen/color_theme.dart' as Theme;
import 'package:movie_buff/widgets/movie_info.dart';
import 'package:movie_buff/widgets/owners.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'movie_detail_inquiry_screen.dart';
import 'movie_inquiry.dart';

class Favourites extends StatefulWidget {
  final User user;
  Favourites({Key? key, required this.user}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState(user);
}

class _FavouritesState extends State<Favourites> {
  final User user;
  _FavouritesState(this.user);

  String databasejson = "";
  bool error = false;

  late Query _ref;
  DatabaseReference _dbref =
  FirebaseDatabase.instance.reference().child('favourites');

  @override
  void initState() {
    super.initState();
    _dbref = FirebaseDatabase.instance.reference();
    _ref = _dbref.child('favourites').orderByChild('username').equalTo(user.email);

  }

  @override
  Widget build(BuildContext context) {
    return _buildHomeWidget();
  }

  _delete_fovo_item(String key){
    _dbref.child("favourites").child(key).remove();
  }

  Widget _buildLoadingWidget() {
    print("loading video");
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ));
  }

  Widget _buildErrorWidget(String error) {
    print("playing error video");
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occured: $error"),
          ],
        ));
  }

  Widget _buildHomeWidget() {

    return Scaffold(
      backgroundColor: Theme.Colors.mainColor,
        appBar: AppBar(
          backgroundColor: Theme.Colors.mainColor,
          centerTitle: true,
          actions: [IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MovieInquiry(user: user,),
                  ),
                );
              },
              icon: Icon(EvaIcons.home, color: Colors.white,)
          ),],
          title: Text(
            "MY FAVOURITES",
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: StreamBuilder(stream: _ref.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData && !snapshot.hasError) {
                var event = snapshot.data as Event;

                if( event.snapshot.value == null ){
                  return const Center(child: Text('No Favorites Added Yet'),);
                }

                print ("event.snapshot.value");print(event.snapshot.value);
                print("snapshot.data" + snapshot.data.toString());
                var favo = <FavouritesModel>[];
                Map<String, dynamic> map = Map<String, dynamic>.from(event.snapshot.value);
                for( var favoMap in map.values){
                  print("favoirtes map : ");
                  print(favoMap);
                  FavouritesModel favouritesModel =FavouritesModel(favoMap["key_val"],
                      favoMap["name"],
                      favoMap["username"],
                      favoMap["date"],
                      favoMap["movie_name"],
                      favoMap["movie_id"],
                      favoMap["trending_status"],
                      favoMap["coverImage"],
                      favoMap["front_image"],
                      favoMap["vote_coverage"]);

                  favo.add(favouritesModel);
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: favo.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      FavouritesModel favourites = favo[index];
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.indigoAccent, width: 2),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            /*Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) =>
                            MovieDetailInquiryScreen(movie: movies[index], user: user,),
                            ),
                            );*/
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Hero(
                                      tag: favourites.movie_id,
                                      child: Container(
                                          width: 120.0,
                                          height: 100.0,
                                          decoration: new BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(2.0)),
                                            shape: BoxShape.rectangle,
                                            image: new DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://image.tmdb.org/t/p/w200/" +
                                                        favourites.front_image)),
                                          )),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100,
                                          child: Text(
                                            favourites.movie_name,
                                            maxLines: 2,
                                            style: TextStyle(
                                                height: 1.4,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              favourites.trending_status.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
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
                                              itemSize: 10.0,
                                              initialRating: favourites.trending_status / favourites.vote_coverage,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(icon: const Icon(Icons.delete, color: Colors.blue,),
                                            onPressed: (){
                                              _showDeleteConfirmDialog('Are you sure you want to remove '
                                                  +favourites.movie_name+ ' from favourites? ', favourites.key.toString());
                                            }),
                                      ],
                                    )
                                  ]
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                );
              } else {
                return _buildErrorWidget("Do data to show");
              }
            }
        ),
    );
  }

  Future<void> _showDeleteConfirmDialog(String msg, String key) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove From Favourites',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decorationStyle: TextDecorationStyle.solid,
            ),),
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg, style: TextStyle(
                  fontWeight: FontWeight.w400,
                  decorationStyle: TextDecorationStyle.solid,
                ),),
              ],
            ),
          ),
          actions: <Widget>[

            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('Cancel'),
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: Colors.blue
              ),),
              onPressed: () {
                print("key " +key);
                print(key);
                _delete_fovo_item(key);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
