import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rebeal/model/user.module.dart';
import 'package:rebeal/pages/profile.dart';
import 'package:rebeal/styles/color.dart';
import 'package:rebeal/widget/custom/title_text.dart';

class UserTilePage extends StatelessWidget {
  UserTilePage({Key? key, required this.user, required this.isadded})
      : super(key: key);
  final UserModel user;
  bool? isadded;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          ProfilePage.getRoute(profileId: user.userId!),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: user.profilePic ??
                    "https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg",
                height: 60,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TitleText(
                    user.displayName!,
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    user.userName!,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isadded!
                      ? Container()
                      : Container(
                          height: 30,
                          width: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(221, 69, 69, 69),
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: Text(
                            "ADD",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.close,
                    size: 18,
                    color: ReBealColor.ReBealLightGrey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
