import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FeedPostWidget extends StatelessWidget {
  const FeedPostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height / 1.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 10,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                        height: 35,
                        width: 35,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://avatars.githubusercontent.com/u/114834504?v=4",
                        ))),
                Container(
                  width: 10,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Antoine\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: '6h late',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.6,
                ),
                Icon(Icons.more_horiz, color: Colors.white)
              ],
            ),
            Container(
              height: 10,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                    height: MediaQuery.of(context).size.height / 1.63,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 1.63,
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "https://www.pixfan.com/wp-content/uploads/2020/06/plus_belles_citations.jpg"))),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    width:
                                        MediaQuery.of(context).size.width / 3.9,
                                    child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://media.istockphoto.com/id/1329031407/fr/photo/jeune-homme-avec-sac-à-dos-prenant-un-portrait-selfie-sur-une-montagne-sourire-heureux-gars.jpg?s=612x612&w=0&k=20&c=fJX0Jn-UrIfitSbS6yJVpdz4b4xSeSfpa8fAUfQjpHY=")))),
                      ],
                    )))
          ],
        ));
  }
}
