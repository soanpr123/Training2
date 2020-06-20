import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemTravelTop extends StatelessWidget {
  ItemTravelTop({this.image, this.title, this.onTap});

  final dynamic image;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width / 7,
        height: size.width / 7,
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: size.width / 7,
                  height: size.width / 7,
                  alignment: Alignment.center,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.network(
                          image,
                          width: size.width / 7,
                          height: size.width / 7,
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
                Container(
                  width: size.width / 7,
                  height: size.width / 7,
                  decoration: BoxDecoration(
                    color: Palette.WHITE,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Palette.COLOR_BORDER_TEXTF.withOpacity(0.3),
                        Palette.BLACK.withOpacity(0.5),
                      ],
                      stops: [0.0, 2.0],
                    ),
                  ),
                ),
                Container(
                  width: size.width / 7,
                  height: size.width / 7,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, size.width / 30),
                  margin: EdgeInsets.fromLTRB(0, 9, 0, 0),
                  child: Text(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Palette.ITEM_TEXT_COLOR,
                        fontSize: FontSize.TEXT_ITEM_HOTEL,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
