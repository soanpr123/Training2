import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/appbar/app_bar.dart';
import 'package:my_travel/src/shared/item_buttom/item_buttom_confirm.dart';
import 'package:my_travel/src/shared/item_flght/item_flight.dart';
import 'package:my_travel/src/shared/item_flght/item_flight_2.dart';
import 'package:my_travel/src/shared/item_my_travel/item_or2.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/ui/flights_screen/form_buying_screen.dart';

class DetailFlightScreen extends StatefulWidget {
  DetailFlightScreen(
      {this.title,
      this.icon,
      this.cityEnd,
      this.cityStart,
      this.nameFlightStart,
      this.nameFlightEnd,
      this.dateStart,
      this.dateEnd,
      this.weight,
      this.quantity,
      this.status,
      this.code});

  final String title;
  final String cityStart;
  final String cityEnd;
  final String nameFlightStart;
  final String nameFlightEnd;
  final String code;
  final String dateStart;
  final String dateEnd;
  final String weight;
  final String quantity;
  final int status;
  final dynamic icon;

  @override
  State createState() => new _DetailFlightScreenState();
}

class _DetailFlightScreenState extends State<DetailFlightScreen> {
  
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          child: MyAppBar(
            title: "Chi tiết chuyến bay",
            icon: "",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
        ),
        backgroundColor: Palette.BACKGROUND_COLOR_SCREEN,
        body: Container(
          width: size.width,
          height: size.height,
          child: checkStatus(widget.status),
        ));
  }

  checkStatus(int i) {
    Size size = MediaQuery.of(context).size;
    if (i == 1) {
      return Stack(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(
                      size.width / 8, size.width / 20, size.width / 8, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.network(
                        widget.icon,
                        width: size.width / 5,
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                            color: Palette.BLACK,
                            fontSize: FontSize.TITLE_APPBAR,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal),
                      ),
                    ],
                  ),
                ),
                ItemFlightm(
                  nameStart: widget.cityStart,
                  timeStart: widget.dateStart,
                  nameAirportStart: widget.nameFlightStart,
                  nameFlight: widget.code,
                  namePlanes: widget.title,
                  timeEnd: widget.dateEnd,
                  nameEnd: widget.cityEnd,
                  nameAirportEnd: widget.nameFlightEnd,
                ),
//                Container(
//                    margin: EdgeInsets.fromLTRB(0, size.width / 13, 0, 0),
//                    child: ItemOr2()),
//                ItemFlightm(
//                  nameStart: widget.cityEnd,
//                  nameEnd: widget.cityStart,
//                  timeStart: widget.dateStart,
//                  nameAirportStart: widget.nameFlightEnd,
//                  nameFlight: widget.code,
//                  timeEnd: widget.dateEnd,
//                  namePlanes: widget.title,
//                  nameAirportEnd: widget.nameFlightStart,
//                ),
              ],
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            child: Container(
              height: size.width / 1.5,
              alignment: Alignment.bottomCenter,
              width: size.width,
              child: Container(
                height: size.width / 1.5,
                width: size.width,
                padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                decoration: BoxDecoration(
                  color: Palette.COLOR_TITLE_FLIGHTS,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(60.0),
                    topRight: const Radius.circular(60.0),
                  ),
                ),
                child: Container(
                  height: size.width / 1.9,
                  width: size.width,
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  decoration: BoxDecoration(
                    color: Palette.WHITE,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(60.0),
                      topRight: const Radius.circular(60.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: ItemFlightm2(
                              icon: "assets/icon/icon_hl.png",
                              title: "Cabin hành lý",
                              weight: widget.weight + "kg",
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ItemFlightm2(
                              icon: "assets/icon/icon_kt_hl.png",
                              title: "Quantity",
                              weight: widget.quantity,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: ItemFlightm2(
                              icon: "assets/icon/icon_baby.png",
                              title: "Lựa chọn chỗ ngồi",
                              weight: "Chọn tại quầy",
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ItemFlightm2(
                              icon: "assets/icon/roast_turkey.png",
                              title: "Bữa ăn",
                              weight: "Có sẵn",
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(size.width / 10,
                            size.width / 10, size.width / 10, size.width / 10),
                        child: ItemButTomconfirm(
                          titleButTom: "Book a ticket",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormBuyingScreen(),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else  {
      return Stack(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(
                      size.width / 8, size.width / 20, size.width / 8, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.network(
                        widget.icon,
                        width: size.width / 5,
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                            color: Palette.BLACK,
                            fontSize: FontSize.TITLE_APPBAR,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal),
                      ),
                    ],
                  ),
                ),
                ItemFlightm(
                  nameStart: widget.cityStart,
                  timeStart: widget.dateStart,
                  nameAirportStart: widget.nameFlightStart,
                  nameFlight: widget.code,
                  namePlanes: widget.title,
                  timeEnd: widget.dateEnd,
                  nameEnd: widget.cityEnd,
                  nameAirportEnd: widget.nameFlightEnd,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, size.width / 13, 0, 0), child: ItemOr2()),
                ItemFlightm(
                  nameStart: widget.cityEnd,
                  nameEnd: widget.cityStart,
                  timeStart: widget.dateStart,
                  nameAirportStart: widget.nameFlightEnd,
                  nameFlight: widget.code,
                  timeEnd: widget.dateEnd,
                  namePlanes: widget.title,
                  nameAirportEnd: widget.nameFlightStart,
                ),
              ],
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            child: Container(
              height: size.width / 1.5,
              alignment: Alignment.bottomCenter,
              width: size.width,
              child: Container(
                height: size.width / 1.5,
                width: size.width,
                padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                decoration: BoxDecoration(
                  color: Palette.COLOR_TITLE_FLIGHTS,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(60.0),
                    topRight: const Radius.circular(60.0),
                  ),
                ),
                child: Container(
                  height: size.width / 1.9,
                  width: size.width,
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  decoration: BoxDecoration(
                    color: Palette.WHITE,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(60.0),
                      topRight: const Radius.circular(60.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: ItemFlightm2(
                              icon: "assets/icon/icon_hl.png",
                              title: "Cabin hành lý",
                              weight: widget.weight + "kg",
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ItemFlightm2(
                              icon: "assets/icon/icon_kt_hl.png",
                              title: "Quantity",
                              weight: widget.quantity,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: ItemFlightm2(
                              icon: "assets/icon/icon_baby.png",
                              title: "Lựa chọn chỗ ngồi",
                              weight: "Chọn tại quầy",
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ItemFlightm2(
                              icon: "assets/icon/roast_turkey.png",
                              title: "Bữa ăn",
                              weight: "Có sẵn",
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(size.width / 10,
                            size.width / 10, size.width / 10, size.width / 10),
                        child: ItemButTomconfirm(
                          titleButTom: "Book a ticket",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormBuyingScreen(),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
