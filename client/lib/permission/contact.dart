// ignore_for_file: must_be_immutable

// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rebeal/styles/color.dart';

import '../animation/animation.dart';
import 'notification.dart';

class ContactPage extends StatefulWidget {
  final VoidCallback? loginCallback;
  ContactPage({Key? key, this.loginCallback}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<String> contactEmails = [];
  @override
  void initState() {
    super.initState();
    // ContactsService.getContacts().then((contacts) {
    //   for (var contact in contacts) {
    //     for (var email in contact.emails!) {
    //       contactEmails.add(email.value!);
    //     }
    //   }
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            setState(() {
              Navigator.pop(context);
            });
          }
        },
        child: Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                    padding: EdgeInsets.only(top: 15, right: 10),
                    child: GestureDetector(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          Navigator.push(
                            context,
                            AwesomePageRoute(
                              transitionDuration: Duration(milliseconds: 600),
                              exitPage: widget,
                              enterPage: NotificationPage(),
                              transition: ZoomOutSlideTransition(),
                            ),
                          );
                        },
                        child: Text("Passer",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 61, 61, 61),
                            ))))
              ],
              elevation: 0,
              title: Image.asset(
                "assets/rebeals.png",
                height: 100,
              ),
              backgroundColor: Colors.black,
            ),
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.black,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                ),
                Text(
                  "Find you're friends\n",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Find you're friends that already\nuse Rebeal.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Expanded(
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
                                        borderRadius:
                                            BorderRadius.circular(90)),
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
              ],
            )));
  }
}
