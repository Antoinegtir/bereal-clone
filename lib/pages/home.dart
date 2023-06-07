import 'package:animate_do/animate_do.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rebeal/camera/camera.dart';
import 'package:rebeal/state/authState.dart';
import 'package:rebeal/styles/color.dart';
import 'package:rebeal/pages/profile.dart';
import 'package:rebeal/widget/feedpost.dart';
import 'package:rebeal/widget/gridpost.dart';
import '../widget/custom/rippleButton.dart';
import 'feed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController _discoverTabController;
  ScrollController _scrollController = ScrollController();
  bool _isScrolledDown = false;
  bool _isGrid = false;
  bool _isDiscover = false;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    _tabController = TabController(length: 2, vsync: this);
    _discoverTabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _discoverTabController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        _isScrolledDown = true;
      });
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _isScrolledDown = false;
      });
    }
  }

  Future _bodyView() async {
    if (_isGrid) {
      setState(() {
        _isGrid = false;
      });
    } else {
      setState(() {
        _isGrid = true;
      });
    }
  }

  int tab = 0;
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: AnimatedOpacity(
            opacity: tab == 1 ? 0 : 1,
            duration: Duration(milliseconds: 301),
            child: Container(
                height: 150,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CameraPage()));
                        },
                        child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 6),
                              shape: BoxShape.circle,
                            ))),
                    Container(
                      height: 40,
                    ),
                  ],
                ))),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FeedPage()));
            },
            child: Transform(
                transform: Matrix4.identity()..scale(-1.0, 1.0, -1.0),
                alignment: Alignment.center,
                child: Icon(
                  Icons.people,
                  size: 30,
                )),
          ),
          toolbarHeight: 50,
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10, top: 68),
                child: GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()));
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                            height: 35,
                            width: 35,
                            child: CachedNetworkImage(
                                imageUrl: state.profileUserModel!.profilePic
                                        .toString())))),
              )
            ],
          ),
          bottom: _isScrolledDown && tab != 1
              ? null
              : TabBar(
                  onTap: (index) {
                    setState(() {
                      tab = index;
                    });
                    print(tab);
                    HapticFeedback.mediumImpact();
                  },
                  controller: _tabController,
                  isScrollable: false,
                  labelColor: Colors.white,
                  unselectedLabelColor: ReBealColor.ReBealLightGrey,
                  indicatorColor: Colors.transparent,
                  indicatorWeight: 1,
                  tabs: [
                    FadeInUp(
                        child: Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Tab(
                              child: Text(
                                'Mes Amis',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ))),
                    FadeInUp(
                        child: Padding(
                      padding: EdgeInsets.only(right: 50),
                      child: Tab(
                          child: Text(
                        'Discovery',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    )),
                  ],
                ),
          elevation: 0,
          title: Image.asset(
            "assets/logo/logo.png",
            height: 100,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: FadeIn(
            child: AnimatedOpacity(
                opacity: 1,
                duration: Duration(milliseconds: 500),
                child: _isGrid
                    ? TabBarView(controller: _tabController, children: [
                        RefreshIndicator(
                            color: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            onRefresh: () {
                              HapticFeedback.mediumImpact();
                              return _bodyView();
                            },
                            child: AnimatedOpacity(
                                opacity: _isGrid ? 1 : 0,
                                duration: Duration(milliseconds: 1000),
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 0.8,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10),
                                    controller: _scrollController,
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return GridPostWidget();
                                    }))),
                        Container()
                      ])
                    : TabBarView(controller: _tabController, children: [
                        RefreshIndicator(
                            color: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            onRefresh: () {
                              HapticFeedback.mediumImpact();

                              return _bodyView();
                            },
                            child: AnimatedOpacity(
                                opacity: !_isGrid ? 1 : 0,
                                duration: Duration(milliseconds: 300),
                                child: ListView.builder(
                                    controller: _scrollController,
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return FeedPostWidget();
                                    }))),
                        Column(
                          children: [
                            Container(
                              height: 170,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isDiscover = false;
                                      });
                                      _discoverTabController.animateTo(0);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                          color: _isDiscover
                                              ? ReBealColor.ReBealDarkGrey
                                              : Colors.white,
                                          height: 38,
                                          alignment: Alignment.center,
                                          width: 130,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.people_alt_outlined,
                                                size: 18,
                                                color: _isDiscover
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              Container(
                                                width: 5,
                                              ),
                                              Text(
                                                "Amis d'Amis",
                                                style: TextStyle(
                                                    color: _isDiscover
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          )),
                                    )),
                                Container(
                                  width: 15,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isDiscover = true;
                                      });
                                      _discoverTabController.animateTo(1);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                          color: !_isDiscover
                                              ? ReBealColor.ReBealDarkGrey
                                              : Colors.white,
                                          height: 38,
                                          alignment: Alignment.center,
                                          width: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.globeAmericas,
                                                size: 18,
                                                color: !_isDiscover
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              Container(
                                                width: 5,
                                              ),
                                              Text(
                                                "Global",
                                                style: TextStyle(
                                                    color: !_isDiscover
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          )),
                                    )),
                              ],
                            ),
                            Expanded(
                                child: TabBarView(
                                    controller: _discoverTabController,
                                    children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 15,
                                      ),
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                              color: ReBealColor.ReBealDarkGrey,
                                              height: 370,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.05,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 20, left: 10),
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: Container(
                                                            height: 25,
                                                            width: 40,
                                                            color: Colors.white,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "NEW",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                          ))),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10, left: 10),
                                                      child: Text(
                                                        "DÉCOUVRE TES\nAMIS D'AMIS",
                                                        style: TextStyle(
                                                            fontSize: 28,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )),
                                                  Container(
                                                    height: 170,
                                                  ),
                                                  // Expanded(
                                                  //     child: Column(
                                                  //   children: [
                                                  //     Container(
                                                  //       height: 10,
                                                  //     ),
                                                  //     Row(
                                                  //       children: [
                                                  //         Container(
                                                  //           width: 10,
                                                  //         ),
                                                  //         ClipRRect(
                                                  //             borderRadius:
                                                  //                 BorderRadius
                                                  //                     .circular(
                                                  //                         50),
                                                  //             child: Container(
                                                  //                 height: 50,
                                                  //                 width: 50,
                                                  //                 child:
                                                  //                     CachedNetworkImage(
                                                  //                   imageUrl:
                                                  //                       "https://media.licdn.com/dms/image/C5603AQFJaweFQUPOXQ/profile-displayphoto-shrink_800_800/0/1562268806964?e=2147483647&v=beta&t=gmhmjbx0KPgtoEBg_bKGyTtGQqa_qjPpw7UEPh4P6Ow",
                                                  //                 ))),
                                                  //         Container(
                                                  //           width: 10,
                                                  //         ),
                                                  //         Text.rich(
                                                  //           TextSpan(
                                                  //             children: [
                                                  //               TextSpan(
                                                  //                 text:
                                                  //                     'Antoine\n',
                                                  //                 style:
                                                  //                     TextStyle(
                                                  //                   fontSize:
                                                  //                       16,
                                                  //                   color: Colors
                                                  //                       .white,
                                                  //                   fontWeight:
                                                  //                       FontWeight
                                                  //                           .w700,
                                                  //                 ),
                                                  //               ),
                                                  //               TextSpan(
                                                  //                 text:
                                                  //                     '4 amis en commun',
                                                  //                 style:
                                                  //                     TextStyle(
                                                  //                   color: Colors
                                                  //                       .grey,
                                                  //                   fontWeight:
                                                  //                       FontWeight
                                                  //                           .w500,
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       ],
                                                  //     ),
                                                  //     Container(
                                                  //       height: 20,
                                                  //     ),
                                                  //     Row(
                                                  //       children: [
                                                  //         Container(
                                                  //           width: 10,
                                                  //         ),
                                                  //         ClipRRect(
                                                  //             borderRadius:
                                                  //                 BorderRadius
                                                  //                     .circular(
                                                  //                         50),
                                                  //             child: Container(
                                                  //                 height: 50,
                                                  //                 width: 50,
                                                  //                 child:
                                                  //                     CachedNetworkImage(
                                                  //                   imageUrl:
                                                  //                       "https://media.licdn.com/dms/image/C5603AQFJaweFQUPOXQ/profile-displayphoto-shrink_800_800/0/1562268806964?e=2147483647&v=beta&t=gmhmjbx0KPgtoEBg_bKGyTtGQqa_qjPpw7UEPh4P6Ow",
                                                  //                 ))),
                                                  //         Container(
                                                  //           width: 10,
                                                  //         ),
                                                  //         Text.rich(
                                                  //           TextSpan(
                                                  //             children: [
                                                  //               TextSpan(
                                                  //                 text:
                                                  //                     'Antoine\n',
                                                  //                 style:
                                                  //                     TextStyle(
                                                  //                   fontSize:
                                                  //                       16,
                                                  //                   color: Colors
                                                  //                       .white,
                                                  //                   fontWeight:
                                                  //                       FontWeight
                                                  //                           .w700,
                                                  //                 ),
                                                  //               ),
                                                  //               TextSpan(
                                                  //                 text:
                                                  //                     '2 amis en commun',
                                                  //                 style:
                                                  //                     TextStyle(
                                                  //                   color: Colors
                                                  //                       .grey,
                                                  //                   fontWeight:
                                                  //                       FontWeight
                                                  //                           .w500,
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       ],
                                                  //     )
                                                  //   ],
                                                  // )),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 15,
                                                          bottom: 20,
                                                          right: 15),
                                                      child: RippleButton(
                                                          splashColor: Colors
                                                              .transparent,
                                                          child: Container(
                                                              height: 55,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                              child: Center(
                                                                  child: Text(
                                                                "Partager ton ReBeal pour découvrir",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "icons.ttf",
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ))),
                                                          onPressed: () {})),
                                                ],
                                              ))),
                                      Container(
                                        height: 10,
                                      ),
                                      Text(
                                        "Ton ReBeal sera visible par tes Amis d'Amis.\nLes réglages de partage peuvent être changé à\ntout moment.",
                                        style: TextStyle(
                                            fontFamily: "icons.ttf",
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                  ListView.builder(
                                      controller: _scrollController,
                                      itemCount: 10,
                                      itemBuilder: (context, index) {
                                        return FeedPostWidget();
                                      })
                                ]))
                          ],
                        )
                      ]))));
  }
}
