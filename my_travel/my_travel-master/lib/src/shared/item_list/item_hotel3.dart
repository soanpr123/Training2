import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemHotels3 extends StatelessWidget {
  ItemHotels3({this.onTap,this.image,this.title,this.address});

  final dynamic image;
  final String title;
  final String address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
          width: size.width / 1.18,
          height: size.width / 3,
          decoration: BoxDecoration(
              color: Palette.WHITE,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 0,
                child: Container(
                  width: size.width/4.5,
                  height: size.width/4.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Image.network(
                      image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  width: size.width,
                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: size.width,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Palette.BLACK,
                              fontSize: FontSize.TITLE_ITEM,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Palette.COLOR_BORDER_TEXTF,
                              fontSize: FontSize.TIME3_ITEM,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
