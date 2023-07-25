// ignore_for_file: must_be_immutable
// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rebeal/model/user.module.dart';
import 'package:rebeal/state/auth.state.dart';
import 'package:rebeal/state/search.state.dart';
import 'package:rebeal/widget/list.dart';
import 'package:rebeal/widget/share.dart';
import '../styles/color.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    // ContactsService.getContacts().then((contacts) {
    //   for (var contact in contacts) {
    //     for (var email in contact.emails!) {
    //       contactEmails.add(email.value!);
    //     }
    //   }
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final _textController = TextEditingController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthState>(context, listen: false);
    final state = Provider.of<SearchState>(context);
    final list = state.userlist;
    final Map<int, Widget> children = {
      0: Text('Suggest'),
      1: Text('Friends'),
      2: Text('Ask'),
    };
    List<UserModel>? following;
    List<UserModel>? follower;

    List<String>? followingkey =
        authState.profileUserModel!.followingList?.toList();
    List<String>? followerkey =
        authState.profileUserModel!.followersList?.toList();

    if (followingkey != null) {
      following = state.getuserDetail(followingkey);
    }
    if (followerkey != null) {
      follower = state.getuserDetail(followerkey);
    }
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 50, left: 20, right: 20),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CupertinoSlidingSegmentedControl(
                  backgroundColor: ReBealColor.ReBealDarkGrey,
                  thumbColor: Color.fromARGB(255, 60, 60, 60),
                  padding:
                      EdgeInsets.only(bottom: 10, top: 10, right: 10, left: 10),
                  children: children,
                  groupValue: currentIndex,
                  onValueChanged: (newValue) {
                    HapticFeedback.mediumImpact();
                    setState(() {
                      currentIndex = newValue!;
                      _tabController.animateTo(currentIndex);
                    });
                  },
                ))),
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 100,
          leading: Container(),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 10, bottom: 60),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_forward, color: Colors.white))),
          ],
          titleSpacing: 0,
          flexibleSpace: Padding(
              padding: EdgeInsets.only(top: 105, left: 10, right: 10),
              child: Container(
                  color: Colors.black,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: _textController.text.isNotEmpty
                              ? MediaQuery.of(context).size.width / 1 - 100
                              : MediaQuery.of(context).size.width / 1 - 20,
                          height: 70,
                          child: TextField(
                              cursorColor: Colors.white,
                              keyboardAppearance:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? Brightness.dark
                                      : Brightness.light,
                              onChanged: (value) {
                                state.filterByUsername(value);
                              },
                              style: const TextStyle(color: Colors.white),
                              controller: _textController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.search,
                                  size: 28,
                                  color: ReBealColor.ReBealLightGrey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent, width: 0.7),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent, width: 0.7),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fillColor: ReBealColor.ReBealDarkGrey,
                                filled: true,
                                suffixIcon: !_textController.text.isNotEmpty
                                    ? SizedBox.shrink()
                                    : GestureDetector(
                                        onTap: () {
                                          _textController.clear();
                                        },
                                        child: Icon(
                                          CupertinoIcons.clear_circled_solid,
                                          color: Colors.grey,
                                          size: 18,
                                        )),
                                contentPadding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                alignLabelWithHint: true,
                                hintText: 'Add where search friends',
                                hintStyle: const TextStyle(
                                    fontSize: 17,
                                    color: ReBealColor.ReBealLightGrey,
                                    fontFamily: "arial"),
                              ))),
                      _textController.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                _textController.clear();
                                setState(() {
                                  _textController.clearComposing();
                                });
                              },
                              child: Container(
                                  width: 80,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Cancel\n",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: "arial",
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  )))
                          : SizedBox.shrink()
                    ],
                  ))),
          title: Padding(
              padding: EdgeInsets.only(bottom: 60),
              child: Image.asset(
                "assets/logo/logo.png",
                height: 100,
              )),
          backgroundColor: Colors.black,
        ),
        body: _textController.text.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      addAutomaticKeepAlives: false,
                      itemBuilder: (context, index) {
                        return UserTilePage(
                          user: list![index],
                          isadded: false,
                        );
                      },
                      itemCount: list?.length ?? 0,
                    ),
                  )
                ],
              )
            : TabBarView(
                controller: _tabController,
                children: [
                  Stack(
                    children: [
                      ListView(
                        children: [
                          Container(
                              width: 100,
                              height: MediaQuery.of(context).size.height / 1.2,
                              child: Column(
                                children: [
                                  ShareButton(),
                                  Row(
                                    children: [
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        "ADD YOU'RE CONTACTS",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 10,
                                  ),
                                  // Expanded(
                                  //     child: ListView.builder(
                                  //   physics: NeverScrollableScrollPhysics(),
                                  //   itemCount: 4,
                                  //   itemBuilder: (context, index) {
                                  //     return ListTile(
                                  //         title: Text(contactEmails[index]),
                                  //         leading: Icon(
                                  //           CupertinoIcons.profile_circled,
                                  //           size: 50,
                                  //         ),
                                  //         trailing: Container(
                                  //             width: 120,
                                  //             child: Row(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment.end,
                                  //               children: [
                                  //                 Container(
                                  //                     height: 30,
                                  //                     width: 90,
                                  //                     alignment:
                                  //                         Alignment.center,
                                  //                     decoration: BoxDecoration(
                                  //                         color: Color.fromARGB(
                                  //                             221, 69, 69, 69),
                                  //                         borderRadius:
                                  //                             BorderRadius
                                  //                                 .circular(
                                  //                                     90)),
                                  //                     child: Text(
                                  //                       "ADD",
                                  //                       style: TextStyle(
                                  //                           fontSize: 13,
                                  //                           color: Colors.white,
                                  //                           fontWeight:
                                  //                               FontWeight
                                  //                                   .w800),
                                  //                     )),
                                  //                 Container(
                                  //                   width: 10,
                                  //                 ),
                                  //                 Icon(
                                  //                   Icons.close,
                                  //                   size: 18,
                                  //                   color: ReBealColor
                                  //                       .ReBealLightGrey,
                                  //                 )
                                  //               ],
                                  //             )));
                                  //   },
                                  // )),
                                  Row(
                                    children: [
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        "PERSON THAT YOU MIGHT KNOW",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 203, 203, 203),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      addAutomaticKeepAlives: false,
                                      itemBuilder: (context, index) {
                                        return UserTilePage(
                                          user: list![index],
                                          isadded: false,
                                        );
                                      },
                                      itemCount: list?.length ?? 0,
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                      IgnorePointer(
                          child: Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      end: Alignment.topRight,
                                      colors: [
                                    for (double i = 1; i > 0; i -= 0.01)
                                      Colors.black.withOpacity(i),
                                  ]))))
                    ],
                    alignment: Alignment.bottomCenter,
                  ),
                  Column(
                    children: [
                      ShareButton(),
                      Row(
                        children: [
                          Container(
                            width: 10,
                          ),
                          Text(
                            "MY FRIENDS (${following?.length ?? 0})",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              return UserTilePage(
                                user: following![index],
                                isadded: true,
                              );
                            },
                            itemCount: following?.length ?? 0),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      ShareButton(),
                      Padding(
                          padding: EdgeInsets.only(left: 15, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "FRIENDS REQUEST (${follower?.length ?? 0})",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                              ),
                              Text(
                                "Sends ",
                                style: TextStyle(
                                    color: ReBealColor.ReBealLightGrey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13),
                              ),
                              Icon(
                                color: ReBealColor.ReBealLightGrey,
                                Icons.arrow_forward_ios,
                                size: 13,
                              ),
                            ],
                          )),
                      Container(
                        height: 10,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Ensure to accept only you're true friends on ReBeal.",
                            style: TextStyle(
                                color: ReBealColor.ReBealDarkGrey,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          )),
                      Container(
                        height: 2000,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return UserTilePage(
                                user: follower![index],
                                isadded: true,
                              );
                            },
                            itemCount: follower?.length ?? 0),
                      )
                    ],
                  ),
                ],
              ));
  }
}
