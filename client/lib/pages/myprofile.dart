import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebeal/state/auth.state.dart';
import 'package:rebeal/pages/settings.dart';
import 'package:rebeal/widget/memories.dart';
import 'package:rebeal/widget/share.dart';
import '../styles/color.dart';
import 'edit.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final previousDays = List<DateTime>.generate(
        14, (index) => today.subtract(Duration(days: index)));
    final reversedDays = previousDays.reversed.toList();
    var state = Provider.of<AuthState>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
            actions: [
              FadeIn(
                  duration: Duration(milliseconds: 1000),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()));
                      },
                      child: Icon(Icons.more_horiz, color: Colors.white)))
            ],
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
                  "Profile",
                  style: TextStyle(color: Colors.white),
                ))),
        body: Center(
            child: FadeInDown(
                child: ListView(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfilePage()));
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 120,
                              width: 120,
                              child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: 100,
                                  imageUrl: state
                                          .profileUserModel?.profilePic ??
                                      "https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg"),
                            ))),
                    Container(height: 10),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfilePage()));
                        },
                        child: Text(
                          state.profileUserModel?.displayName.toString() ?? "",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w700),
                        )),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfilePage()));
                        },
                        child: Text(
                          state.profileUserModel?.userName.toString() ?? "",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        )),
                    Container(height: 10),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfilePage()));
                        },
                        child: Text(
                          "${state.profileUserModel?.bio ?? ""}",
                          style: TextStyle(
                              color: ReBealColor.ReBealLightGrey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        )),
                    Container(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Memories",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.lock,
                              color: ReBealColor.ReBealLightGrey,
                              size: 12,
                            ),
                            Container(
                              width: 5,
                            ),
                            Text(
                              "Only visible for me.",
                              style: TextStyle(
                                  color: ReBealColor.ReBealLightGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          color: ReBealColor.ReBealDarkGrey,
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "14 last days",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Expanded(
                                      child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 7,
                                                  mainAxisSpacing: 0,
                                                  crossAxisSpacing: 0),
                                          itemCount: reversedDays.length,
                                          itemBuilder: (context, index) {
                                            final day = reversedDays[index];
                                            return Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: index == 13
                                                        ? Colors.white
                                                        : Colors.transparent,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Text(
                                                    '${day.day}',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: index == 13
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ));
                                          })),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MemoriesPage()));
                                      },
                                      child: Center(
                                          child: Container(
                                        height: 40,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              color: Colors.white, width: 0.4),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Voir tous mes Memories",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )))
                                ],
                              ))),
                    ),
                    Container(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () {
                          shareText(
                              "ReBe.al/${state.profileUserModel?.userName!.replaceAll("@", "").toLowerCase() ?? ""}");
                        },
                        child: Text(
                          "🔗 ReBe.al/${state.profileUserModel?.userName!.replaceAll("@", "").toLowerCase() ?? ""}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        )),
                  ],
                ))
          ],
        ))));
  }
}
