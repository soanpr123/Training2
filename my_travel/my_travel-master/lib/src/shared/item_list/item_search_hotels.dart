import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemSearchHotels extends StatelessWidget {
  ItemSearchHotels({this.title, this.content, this.price, this.onTap});

  final String title;
  final String content;
  final String price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: Image.network(
                    "http://pstatic.itap-world.com/property/0/312/7631s.jpg",
                    fit: BoxFit.fill,
                    width: size.width,
                    height: size.height / 5,
                  ),
                ),
              ),
              Container(
                width: size.width,
                margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Palette.BLACK,
                      fontSize: FontSize.TITLE_BANNER,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal),
                ),
              ),
              Container(
                width: size.width,
                margin: EdgeInsets.fromLTRB(10, 0, 5, 5),
                child: Text(
                  content,
                  style: TextStyle(
                      fontSize: FontSize.TIME3_ITEM, color: Palette.TEXT_2),
                ),
              ),
              Container(
                width: size.width,
                margin: EdgeInsets.fromLTRB(10, 5, 5, 15),
                child: Row(
                  children: <Widget>[
                    Text(
                      price,
                      style: TextStyle(
                          color: Palette.COLOR_BORDER_TEXTF,
                          fontSize: FontSize.TITLE_LOGIN3,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal),
                    ),
                    Text(
                      "  per night",
                      style: TextStyle(
                          color: Palette.COLOR_BORDER_TEXTF,
                          fontSize: FontSize.TEXT_DETAIL,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
