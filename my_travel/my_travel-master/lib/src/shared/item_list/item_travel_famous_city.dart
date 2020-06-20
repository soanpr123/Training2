import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemTravelFamousCity extends StatelessWidget {
  ItemTravelFamousCity(
      {this.image, this.title, this.conTent,this.onTap});

  final dynamic image;
  final String title;
  final String conTent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width / 2.5,
        height: size.width / 1.2,
        margin: EdgeInsets.fromLTRB(7, 10, 7, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: size.width / 2.5,
                  height: size.width / 1.5,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  height: size.width / 1.5,
                  decoration: BoxDecoration(
                      color: Palette.WHITE,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Palette.COLOR_BORDER_TEXTF.withOpacity(0.3),
                            Palette.BLACK.withOpacity(0.5),
                          ],
                          stops: [
                            0.7,
                            1.0
                          ])),
                )
              ],
            ),
            
            Container(
              margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Palette.BLACK,
                    fontSize: FontSize.TITLE_LOGIN3,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
              child: Text(
                conTent,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Palette.COLOR_BORDER_TEXTF,
                    fontSize: FontSize.TIME3_ITEM,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
