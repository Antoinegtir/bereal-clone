import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rebeal/model/user.dart';
import 'package:rebeal/widget/custom/title_text.dart';

class UserTile extends StatelessWidget {
  const UserTile({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading:
          CachedNetworkImage(imageUrl: user.profilePic.toString(), height: 40),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: TitleText(user.displayName!,
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(width: 3),
        ],
      ),
      subtitle: Text(
        user.userName!,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
