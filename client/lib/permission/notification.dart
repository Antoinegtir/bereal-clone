// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../animation/animation.dart';
import '../notification/notification.dart';

class NotificationPage extends StatefulWidget {
  final VoidCallback? loginCallback;
  NotificationPage({Key? key, this.loginCallback}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          elevation: 0,
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
              "Quand poster ton\nReBeal ?\n",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            Text(
              "La seule façon de savoir quand poster ton\nReBeal est d'activer les notiifcations !",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 30,
            ),
            Container(
              height: 300,
              width: 250,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Text(
                    "\nMerci d'activer les\n notifications",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "\nToutes les notifications sur ReBeal\nsont silencieuse sauf celle qui\nt'indique quand poster ron BeReal\n une fois par jour.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () async {
                        HapticFeedback.heavyImpact();
                        // FlutterLocalNotificationsPlugin
                        //     flutterLocalNotificationsPlugin =
                        //     FlutterLocalNotificationsPlugin();
                        // await flutterLocalNotificationsPlugin.show(
                        //   0,
                        //   'Sample Notification',
                        //   'This is a sample notification',
                        //   NotificationDetails(
                        //     android: AndroidNotificationDetails(
                        //       'channel_id',
                        //       'channel_name',
                        //       'channel_description',
                        //       importance: Importance.max,
                        //       priority: Priority.high,
                        //     ),
                        //     iOS: IOSNotificationDetails(),
                        //   ),
                        // );
                        Navigator.push(
                          context,
                          AwesomePageRoute(
                            transitionDuration: Duration(milliseconds: 600),
                            exitPage: widget,
                            enterPage: NotifcationTest(),
                            transition: ZoomOutSlideTransition(),
                          ),
                        );
                      },
                      child: Container(
                        width: 260,
                        height: 40,
                        color: Color.fromARGB(255, 0, 120, 232),
                        alignment: Alignment.center,
                        child: Text(
                          "Autoriser",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "Autoriser dans le\nRésumé programmé",
                    style: TextStyle(
                        color: Color.fromARGB(255, 89, 89, 89),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    color: Colors.grey,
                    height: 0.3,
                    width: 250,
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "Refuser",
                    style: TextStyle(
                        color: Color.fromARGB(255, 89, 89, 89),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
