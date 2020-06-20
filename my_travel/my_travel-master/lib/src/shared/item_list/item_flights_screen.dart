import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemFlightsScreen extends StatelessWidget {
  ItemFlightsScreen(
      {this.title,
      this.price,
      this.code,
      this.endTime,
      this.startTime,
      this.specificTime,
      this.specificTime2,
      this.addressToGo,
      this.destinationAddress,
        this.image,
      this.onTap});

  final String title;
  final dynamic image;
  final String code;
  final String startTime;
  final String endTime;
  final String specificTime;
  final String specificTime2;
  final String price;
  final String addressToGo;
  final String destinationAddress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Card(
          elevation: 1,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 120,
                color: Palette.WHITE,
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: GestureDetector(
                  onTap: onTap,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              height: size.height,
                              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              width: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 70,
                                    width: 70,
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    child: Image.network(image),
                                  ),
                                  Text(
                                    code,
                                    style: TextStyle(
                                        color: Palette.TEXT_2,
                                        fontSize: FontSize.TEXT_DETAIL,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              //  height: 70,
                              //    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 15,
                                      height: 8,
                                      decoration: new BoxDecoration(
                                        color: Palette.GREY8,
                                        borderRadius: new BorderRadius.only(
                                          bottomRight:
                                              const Radius.circular(35.0),
                                          bottomLeft:
                                              const Radius.circular(35.0),
                                        ),
                                      ),
                                      //  color: Palette.black11,
                                    ),
                                  ),
                                  Container(
                                    child: Image.asset(
                                      "assets/icon/icon_gachc.png",
                                      height: 100,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 15,
                                      height: 8,
                                      decoration: new BoxDecoration(
                                        color: Palette.GREY8,
                                        borderRadius: new BorderRadius.only(
                                          topRight: const Radius.circular(35.0),
                                          topLeft: const Radius.circular(35.0),
                                        ),
                                      ),
                                      //  color: Palette.black11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    width: size.width / 1.9,
                                    height: 90,
                                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              title,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Palette.BLACK,
                                                  fontSize:
                                                      FontSize.TEXT_DETAIL,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(price + "\$",
                                                style: TextStyle(
                                                    color: Palette
                                                        .COLOR_PRICE_ITEM,
                                                    fontSize:
                                                        FontSize.TEXT_DETAIL,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              startTime,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Palette.BLACK,
                                                  fontSize: FontSize.TIME_ITEM,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(specificTime,
                                                    style: TextStyle(
                                                        color: Palette.TEXT_2,
                                                        fontSize:
                                                            FontSize.TIME2_ITEM,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 2, 0, 2),
                                                  height: 0.5,
                                                  width: 60,
                                                  color: Palette.TEXT_2,
                                                ),
                                                Text(specificTime2,
                                                    style: TextStyle(
                                                        color: Palette.TEXT_2,
                                                        fontSize:
                                                            FontSize.TIME2_ITEM,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                            Text(endTime,
                                                style: TextStyle(
                                                    color: Palette.BLACK,
                                                    fontSize:
                                                        FontSize.TIME_ITEM,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                        Container(
                                          width: size.width / 2.2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                addressToGo,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Palette.TEXT_2,
                                                    fontSize:
                                                        FontSize.TEXT_DETAIL,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(destinationAddress,
                                                  style: TextStyle(
                                                      color: Palette.TEXT_2,
                                                      fontSize:
                                                          FontSize.TEXT_DETAIL,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
//        Container(
//          alignment: Alignment.bottomLeft,
//          margin: EdgeInsets.fromLTRB(102.5, 115, 0, 0),
//          child: Image.asset("assets/icon/icon_n.png"),
//        ),
      ],
    );
  }
}
