import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemcodeFlight extends StatelessWidget {
  ItemcodeFlight({this.onTap,this.nameCity,this.code,this.country,this.name});

  final String code;
  final String nameCity;
  final String country;
  final String name;
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
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
              color: Palette.WHITE,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 0,
                          child: Container(
                            width: 30,
                            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            child: Text(code,
                              style: TextStyle(
                                  color: Palette.COLOR_TITE3,
                                  fontSize: FontSize.TITLE_STATUS_TIME,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal),),
                          )),
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      nameCity,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Palette.BLACK,
                                          fontSize: FontSize.TITLE_ITEM,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Roboto',
                                          fontStyle: FontStyle.normal),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(6, 3, 3, 3),
                                      decoration: BoxDecoration(
                                        color: Palette.COLOR2,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        )
                                      ),
                                      child: Text(
                                        country,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Palette.WHITE,
                                            fontSize: FontSize.TEXT_ITEM_HOTEL,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  name,
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
            ],
          ),
        ),
      ),
    );
  }
}
