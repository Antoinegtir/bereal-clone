import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GridPostWidget extends StatelessWidget {
  const GridPostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          fit: StackFit.expand,
          children: [
            FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.63,
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            "https://www.pixfan.com/wp-content/uploads/2020/06/plus_belles_citations.jpg"))),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 7.5, left: 5),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Louloute\n',
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
            )
          ],
        ));
  }
}
