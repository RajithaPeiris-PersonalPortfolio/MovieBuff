import 'package:flutter/material.dart';

import 'package:movie_buff/widgets/login_widget.dart';

class UserInquiry extends StatefulWidget {
  final String username;
  UserInquiry({Key? key, required this.username}) : super(key: key);

  @override
  _UserInquiryState createState() => _UserInquiryState(username);
}

class _UserInquiryState extends State<UserInquiry> {
  final String username;
  _UserInquiryState(this.username);
  @override
  Widget build(BuildContext context) {
    print("username: "+ username);
    return Stack(
        children: <Widget>[
          LoginWidget(),
        ]
      /*
      body: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              LoginWidget(),
            ],
          ),
        ),
        //body: LoginWidget(),
      ),*/
    );
  }
}
