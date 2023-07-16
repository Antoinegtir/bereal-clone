import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebeal/state/auth.state.dart';
import 'package:rebeal/styles/color.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatefulWidget {
  const ShareButton({super.key});

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

void shareText(String text) {
  Share.share(
    text,
    subject: "Follow me on ReBeal.",
    sharePositionOrigin: Rect.fromLTWH(0, 0, 10, 10),
  );
}

class _ShareButtonState extends State<ShareButton> {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: GestureDetector(
                onTap: () {
                  shareText(
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
                                                .profileUserModel?.profilePic ??
                                            "https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg"),
                                  )),
                              Container(
                                width: 10,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Invite you\'re friends on ReBeal\n',
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
      ],
    );
  }
}
