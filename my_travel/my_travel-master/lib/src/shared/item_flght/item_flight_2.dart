import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemFlightm2 extends StatelessWidget {
  ItemFlightm2({this.title,this.icon,this.weight});
  final dynamic icon;
  final String title;
  final String weight;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(size.width/10, size.width / 13, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            icon,
            width: 15,
            fit: BoxFit.fill,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                 width: size.width/4.5,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Palette.COLOR_BORDER_TEXTF,
                        fontSize: FontSize.TEXT_DETAIL,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Text(
                    weight,
                    style: TextStyle(
                        color: Palette.BLACK,
                        fontSize: FontSize.TEXT_DETAIL,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
