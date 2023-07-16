import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:rebeal/common/splash.dart';
import 'package:rebeal/state/auth.state.dart';
import '../widget/custom/rippleButton.dart';

class NotifcationTest extends StatefulWidget {
  const NotifcationTest({Key? key}) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotifcationTest> {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
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
            Icon(
              Icons.arrow_upward_rounded,
              size: 60,
              color: Colors.white,
            ),
            Container(
              height: 30,
            ),
            Text(
              "\n${state.profileUserModel!.displayName}, we know you can do it!\nTap the\nnotification to get your first ReBeal.",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        bottomSheet: Container(
            height: 170,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 60),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Iconsax.notification,
                            color: Color.fromARGB(255, 101, 101, 101)),
                        Padding(
                            padding: EdgeInsets.only(top: 5, left: 5),
                            child: Text(
                              "Disable to not disturb",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 101, 101, 101)),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RippleButton(
                          splashColor: Colors.transparent,
                          child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width - 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                  child: Text(
                                "Resend notification",
                                style: TextStyle(
                                    fontFamily: "icons.ttf",
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800),
                              ))),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return SplashPage();
                              },
                            ));
                          },
                        )
                      ],
                    ),
                  ],
                ))));
  }
}
