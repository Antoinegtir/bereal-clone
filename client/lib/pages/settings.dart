import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebeal/helper/utility.dart';
import 'package:rebeal/state/auth.state.dart';
import 'package:rebeal/styles/color.dart';
import 'package:share_plus/share_plus.dart';

import 'edit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
            leading: FadeIn(
                duration: Duration(milliseconds: 1000),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.white))),
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: FadeInRight(
                duration: Duration(milliseconds: 300),
                child: Text(
                  "Settings",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ))),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ListView(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage()));
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            height: 90,
                            width: MediaQuery.of(context).size.width,
                            color: ReBealColor.ReBealDarkGrey,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Container(
                                          height: 65,
                                          width: 65,
                                          child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              height: 100,
                                              imageUrl: state.profileUserModel
                                                      ?.profilePic ??
                                                  "https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg"),
                                        )),
                                    Container(
                                      width: 10,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                '${state.profileUserModel!.displayName}\n',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${state.profileUserModel!.userName}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 30,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: ReBealColor.ReBealLightGrey,
                                  size: 15,
                                )
                              ],
                            )))),
                Container(
                  height: 30,
                ),
                Text(
                  "About",
                  style: TextStyle(color: Color.fromARGB(255, 65, 65, 65)),
                ),
                Container(
                  height: 5,
                ),
                GestureDetector(
                    onTap: () {
                      Share.share(
                        "rebe.al/${state.profileUserModel!.userName!.replaceAll("@", "").toLowerCase()}",
                        subject: "Add me on ReBeal.",
                        sharePositionOrigin: Rect.fromLTWH(0, 0, 10, 10),
                      );
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            color: ReBealColor.ReBealDarkGrey,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 10,
                                ),
                                Icon(CupertinoIcons.share),
                                Text(
                                  "Share ReBeal",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                                Container(
                                  width: 100,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: ReBealColor.ReBealLightGrey,
                                ),
                                Container(
                                  width: 10,
                                ),
                              ],
                            )))),
                Container(
                  height: 30,
                ),
                GestureDetector(
                    onTap: () {
                      state.logoutCallback();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          color: ReBealColor.ReBealDarkGrey,
                          alignment: Alignment.center,
                          child: Text(
                            "Log out",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        ))),
                Container(
                  height: 20,
                ),
                Text(
                  "Version 1.0.0 (1) - Clone Version",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(255, 96, 96, 96),
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                ),
                Container(
                  height: 40,
                ),
                Text(
                  "You join BeReal on a few days ago" +
                      Utility.getdob(
                          state.profileUserModel!.createAt.toString()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                )
              ],
            )));
  }
}
