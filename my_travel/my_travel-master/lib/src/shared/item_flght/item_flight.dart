import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemFlightm extends StatelessWidget {
  ItemFlightm(
      {this.nameAirportEnd,
      this.nameAirportStart,
      this.nameEnd,
      this.nameFlight,
      this.namePlanes,
      this.nameStart,
      this.timeEnd,this.timeStart});

  final String nameStart;
  final String nameEnd;
  final String nameFlight;
  final String namePlanes;
  final String timeStart;
  final String timeEnd;
  final String nameAirportStart;
  final String nameAirportEnd;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(20, size.width / 13, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/icon/icon_deatil_flight.PNG",
            height: 110,
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: size.width / 1.3,
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          nameStart,
                          style: TextStyle(
                              color: Palette.BLACK,
                              fontSize: FontSize.TITLE_APPBAR,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal),
                        ),
                        Text(
                          timeStart,
                          style: TextStyle(
                              color: Palette.BLACK,
                              fontSize: FontSize.TITLE_ITEM,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Text(
                        nameAirportStart,
                        style: TextStyle(
                            color: Palette.COLOR_BORDER_TEXTF,
                            fontSize: FontSize.TEXT_ALL,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Chuyến bay: " + nameFlight,
                            style: TextStyle(
                                color: Palette.COLOR_BORDER_TEXTF,
                                fontSize: FontSize.TEXT_ALL,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              "Máy bay: " + namePlanes,
                              style: TextStyle(
                                  color: Palette.COLOR_BORDER_TEXTF,
                                  fontSize: FontSize.TEXT_ALL,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width / 1.3,
                margin: EdgeInsets.fromLTRB(10, 15, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          nameEnd,
                          style: TextStyle(
                              color: Palette.BLACK,
                              fontSize: FontSize.TITLE_APPBAR,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal),
                        ),
                        Text(
                          timeEnd,
                          style: TextStyle(
                              color: Palette.BLACK,
                              fontSize: FontSize.TITLE_ITEM,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Text(
                        nameAirportEnd,
                        style: TextStyle(
                            color: Palette.COLOR_BORDER_TEXTF,
                            fontSize: FontSize.TEXT_ALL,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
