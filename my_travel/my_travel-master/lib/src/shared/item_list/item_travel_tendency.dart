import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemTravelTendency extends StatelessWidget {
  ItemTravelTendency({this.image, this.title,this.content,this.onTap});

  final dynamic image;
  final String title;
  final String content;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width / 2.5,
        height: size.width / 2.5,
        margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: size.width / 2.5,
                  height: size.width / 5,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        child: Image.network(
                          image,
//                    height: size.width / 5,
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
                Container(
                  width: size.width / 2.5,
                  height: size.width / 5,
                  decoration: BoxDecoration(
                      color: Palette.WHITE,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Palette.COLOR_BORDER_TEXTF.withOpacity(0.2),
                            Palette.BLACK.withOpacity(0.5),
                          ],
                          stops: [
                            0.0,
                            1.0
                          ])),
                ),
                Container(
                  width: size.width / 2.5,
                  height: size.width / 5,
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.fromLTRB(7, 0, 7, size.width / 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Palette.BACKGROUND_COLOR_SCREEN,
                            fontSize: FontSize.TITLE_LOGIN3,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal),
                      ),
                      Text(
                        content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Palette.COLOR_BORDER,
                            fontSize: FontSize.TEXT_ITEM_HOTEL,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
