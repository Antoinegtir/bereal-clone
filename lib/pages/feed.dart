// ignore_for_file: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rebeal/state/authState.dart';
import 'package:share_plus/share_plus.dart';
import '../styles/color.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> with TickerProviderStateMixin {
  late TabController _tabController;
  List<String> contactEmails = [];
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
    final Map<int, Widget> children = {
      0: Text('Suggestions'),
      1: Text('Amis'),
      2: Text('Demandes'),
    };
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 50, left: 20, right: 20),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CupertinoSlidingSegmentedControl(
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
                  child: TextField(
                      cursorColor: Colors.white,
                      keyboardAppearance:
                          MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? Brightness.dark
                              : Brightness.light,
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
                        contentPadding: const EdgeInsets.only(left: 15, top: 5),
                        alignLabelWithHint: true,
                        hintText: 'Ajouter ou recherecher des amis',
                        hintStyle: const TextStyle(
                            fontSize: 17,
                            color: ReBealColor.ReBealLightGrey,
                            fontFamily: "arial"),
                      )))),
          title: Padding(
              padding: EdgeInsets.only(bottom: 60),
              child: Image.asset(
                "assets/logo/logo.png",
                height: 100,
              )),
          backgroundColor: Colors.black,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            TabBarReBeal(
              i: 0,
              key: widget.key,
            ),
            TabBarReBeal(
              i: 1,
              key: widget.key,
            ),
            TabBarReBeal(
              i: 2,
              key: widget.key,
            )
          ],
        ));
  }
}

class TabBarReBeal extends StatefulWidget {
  int i;
  TabBarReBeal({required this.i, super.key});

  @override
  State<TabBarReBeal> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<TabBarReBeal> {
  List<String> contactEmails = [];
  @override
  void initState() {
    ContactsService.getContacts().then((contacts) {
      for (var contact in contacts) {
        for (var email in contact.emails!) {
          contactEmails.add(email.value!);
        }
      }
      setState(() {});
    });
    super.initState();
  }

  void _shareText(String text) {
    Share.share(
      text,
      subject: "Ajoute-moi sur ReBeal.",
      sharePositionOrigin: Rect.fromLTWH(0, 0, 10, 10),
    );
  }

  String _text() {
    if (widget.i == 0) return "AJOUTER TES CONTACTS";
    if (widget.i == 1) return "MES AMIS (${widget.i})";
    if (widget.i == 2) return "DEMANDES D'AMI (${widget.i})";
    // ignore: null_check_always_fails
    return null!;
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: GestureDetector(
                onTap: () {
                  _shareText(
                      "rebe.al/${state.profileUserModel!.userName!.replaceAll("@", "").toLowerCase()}");
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      color: ReBealColor.ReBealDarkGrey,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      height: 100,
                                      imageUrl: state
                                          .profileUserModel!.profilePic
                                          .toString(),
                                    ),
                                  )),
                              Container(
                                width: 10,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Invite tes amis sur ReBeal\n',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'rebe.al/${state.profileUserModel!.userName!.replaceAll("@", "").toLowerCase()}',
                                      style: TextStyle(
                                        color: ReBealColor.ReBealLightGrey,
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
                            CupertinoIcons.share,
                            color: Colors.white,
                            size: 22,
                          )
                        ],
                      ),
                    )))),
        Container(
          height: 20,
        ),
        Row(
          children: [
            Container(
              width: 10,
            ),
            Text(
              _text(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
            )
          ],
        ),
        _text() == "AJOUTER TES CONTACTS"
            ? Expanded(
                child: ListView.builder(
                itemCount: contactEmails.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(contactEmails[index]),
                      leading: Icon(CupertinoIcons.profile_circled),
                      trailing: Container(
                          width: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  height: 30,
                                  width: 90,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ReBealColor.ReBealDarkGrey,
                                      borderRadius: BorderRadius.circular(90)),
                                  child: Text(
                                    "AJOUTER",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  )),
                              Container(
                                width: 10,
                              ),
                              Icon(
                                Icons.close,
                                size: 18,
                                color: ReBealColor.ReBealLightGrey,
                              )
                            ],
                          )));
                },
              ))
            : Container(),
        Row(
          children: [
            Container(
              width: 10,
            ),
            Text(
              "PERSONNES QUE TU DOIS CONNAITRE",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
            )
          ],
        ),
        Container(height: 260,)
      ],
    );
  }
}
