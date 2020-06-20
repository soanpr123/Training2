import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemFamousCity extends StatelessWidget {
  ItemFamousCity({this.title, this.content, this.price,this.onTap});

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
              Stack(
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
                ],
              ),
              Container(
                width: size.width,
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: FontSize.TEXT_DETAIL, color: Palette.BLACK),
                ),
              ),
              Container(
                width: size.width,
                margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: Text(
                  content,
                  style: TextStyle(
                      fontSize: FontSize.TIME3_ITEM, color: Palette.TEXT_2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
