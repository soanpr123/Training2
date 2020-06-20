import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel/src/model/history_model.dart';
import 'package:my_travel/src/resources/login_service.dart';
import 'package:my_travel/src/shared/item_buttom/item_buttom_confirm.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/ui/flights_screen/detail_flight_screen.dart';

import 'form_buying_screen.dart';

class FlightSelectedScreen extends StatefulWidget {
  FlightSelectedScreen(
      {this.destinationAddress,
      this.addressToGo,
      this.price,
      this.startTime,
      this.image,
      this.title,
      this.andTime,
      this.nameCityStart,
      this.nameCityEnd,
      this.code,
      this.timeH,
      this.specificTime,
      this.moonLanding,
      this.nameFlightEnd,
      this.nameFlightStart,
      this.weight,
        this.status,
      this.quantity,
      this.timeM});

  final String destinationAddress, addressToGo;
  final String startTime, andTime;
  final String price, code;
  final String nameCityStart, nameCityEnd;
  final String nameFlightStart, nameFlightEnd;
  final String title;
  final double timeH;
  final double timeM;
  final String specificTime;
  final String moonLanding;
  final String weight;
  final String quantity;
  final int status;
  final dynamic image;

  @override
  State createState() => new _FlightSelectedScreenState();
}

class _FlightSelectedScreenState extends State<FlightSelectedScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Palette.BACKGROUND_COLOR_SCREEN,
      body: Stack(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.width / 1.5,
            child: Image.asset(
              "assets/image/image_her.png",
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.fromLTRB(0, size.width / 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: Palette.WHITE,
                      ),
                    )),
                Text(
                  widget.addressToGo + " - " + widget.destinationAddress,
                  style: TextStyle(
                      color: Palette.WHITE,
                      fontSize: FontSize.TITLE_ITEM_TRAVEL,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal),
                ),
                SizedBox(
                  width: 40,
                )
              ],
            ),
          ),
          Container(
            width: size.width,
            margin: EdgeInsets.fromLTRB(0, size.width / 2.2, 0, 0),
            height: size.height / 1.1,
            decoration: BoxDecoration(
                color: Palette.BACKGROUND_COLOR_SCREEN,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(35.0), topRight: const Radius.circular(35.0))),
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: size.width / 1.12,
                    margin: EdgeInsets.fromLTRB(0, size.width / 19, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 0,
                          child:
                              Container(width: size.width / 5, child: Image.network(widget.image)),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            widget.title,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Palette.BLACK,
                                fontSize: FontSize.TITLE_LOGIN,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Container(
                            width: size.width / 5,
                            child: Text(
                              widget.price + "\$",
                              style: TextStyle(
                                  color: Palette.COLOR_PRICE_ITEM,
                                  fontSize: FontSize.TITLE_LOGIN,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, size.height / 5.5, 0, 0),
                        child: Container(
                          height: size.width / 1.1,
                          width: size.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              image: new DecorationImage(
                            image: new AssetImage("assets/image/image_border.png"),
                            fit: BoxFit.fill,
                          )),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(45, size.width / 14, 45, size.width / 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  widget.moonLanding,
                                  style: TextStyle(
                                      color: Palette.BLACK,
                                      fontSize: FontSize.TITLE_ITEM_TRAVEL,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.normal),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Outhound",
                                        style: TextStyle(
                                            color: Palette.COLOR_TITE2,
                                            fontSize: FontSize.TEXT_DETAIL,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                      Text(
                                        "Flight: " + widget.code,
                                        style: TextStyle(
                                            color: Palette.COLOR_TITE2,
                                            fontSize: FontSize.TEXT_DETAIL,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(40, 15, 40, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            widget.addressToGo,
                                            style: TextStyle(
                                                color: Palette.BLACK,
                                                fontSize: FontSize.TIME_ITEM,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto',
                                                fontStyle: FontStyle.normal),
                                          ),
                                          Text(
                                            widget.nameCityStart,
                                            style: TextStyle(
                                                color: Palette.TEXT_2,
                                                fontSize: FontSize.TEXT_ALL,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto',
                                                fontStyle: FontStyle.normal),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        widget.specificTime.toString(),
                                        style: TextStyle(
                                            color: Palette.TEXT_2,
                                            fontSize: FontSize.TEXT_ALL,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            widget.destinationAddress,
                                            style: TextStyle(
                                                color: Palette.BLACK,
                                                fontSize: FontSize.TIME_ITEM,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto',
                                                fontStyle: FontStyle.normal),
                                          ),
                                          Text(
                                            widget.nameCityEnd,
                                            style: TextStyle(
                                                color: Palette.TEXT_2,
                                                fontSize: FontSize.TEXT_ALL,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto',
                                                fontStyle: FontStyle.normal),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(40, 15, 40, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        widget.startTime,
                                        style: TextStyle(
                                            color: Palette.BLACK,
                                            fontSize: FontSize.TIME_ITEM,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                      Text(
                                        "${widget.timeH.toStringAsFixed(0).toString()}h${widget.timeM.toStringAsFixed(0).toString()}m",
                                        style: TextStyle(
                                            color: Palette.TEXT_2,
                                            fontSize: FontSize.TEXT_ALL,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                      Text(
                                        widget.andTime,
                                        style: TextStyle(
                                            color: Palette.BLACK,
                                            fontSize: FontSize.TIME_ITEM,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailFlightScreen(
                                          title: widget.title,
                                          icon: widget.image,
                                          cityEnd: widget.nameCityEnd,
                                          cityStart: widget.nameCityStart,
                                          nameFlightStart: widget.nameFlightStart.toString(),
                                          nameFlightEnd: widget.nameFlightEnd,
                                          code: widget.code,
                                          dateStart: widget.startTime + "," + widget.moonLanding,
                                          dateEnd: widget.andTime + "," + widget.moonLanding,
                                          weight: widget.weight,
                                          quantity: widget.quantity,
                                          status: widget.status,
                                        ),
                                      ),
                                    ),
                                    child: Text("Chi tiết chuyến bay và hành lý",
                                        style: TextStyle(
                                            color: Palette.COLOR_TITE3,
                                            fontSize: FontSize.TEXT_DETAIL,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          height: size.width / 1.5,
                          width: size.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              image: new DecorationImage(
                            image: new AssetImage("assets/image/image_border.png"),
                            fit: BoxFit.fill,
                          )),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(45, 0, 45, size.width / 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  widget.moonLanding,
                                  style: TextStyle(
                                      color: Palette.BLACK,
                                      fontSize: FontSize.TITLE_ITEM_TRAVEL,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.normal),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Outhound",
                                        style: TextStyle(
                                            color: Palette.COLOR_TITE,
                                            fontSize: FontSize.TEXT_DETAIL,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                      Text(
                                        "Chuyến bay: " + widget.code,
                                        style: TextStyle(
                                            color: Palette.COLOR_TITE,
                                            fontSize: FontSize.TEXT_DETAIL,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(40, 15, 40, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            widget.addressToGo,
                                            style: TextStyle(
                                                color: Palette.BLACK,
                                                fontSize: FontSize.TIME_ITEM,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto',
                                                fontStyle: FontStyle.normal),
                                          ),
                                          Text(
                                            widget.nameCityStart,
                                            style: TextStyle(
                                                color: Palette.TEXT_2,
                                                fontSize: FontSize.TEXT_ALL,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto',
                                                fontStyle: FontStyle.normal),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        widget.specificTime,
                                        style: TextStyle(
                                            color: Palette.TEXT_2,
                                            fontSize: FontSize.TEXT_ALL,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            widget.destinationAddress,
                                            style: TextStyle(
                                                color: Palette.BLACK,
                                                fontSize: FontSize.TIME_ITEM,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto',
                                                fontStyle: FontStyle.normal),
                                          ),
                                          Text(
                                            widget.nameCityEnd,
                                            style: TextStyle(
                                                color: Palette.TEXT_2,
                                                fontSize: FontSize.TEXT_ALL,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto',
                                                fontStyle: FontStyle.normal),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(40, 15, 40, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        widget.startTime,
                                        style: TextStyle(
                                            color: Palette.BLACK,
                                            fontSize: FontSize.TIME_ITEM,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                      Text(
                                        "${widget.timeH.toStringAsFixed(0).toString()}h${widget.timeM.toStringAsFixed(0).toString()}m",
                                        style: TextStyle(
                                            color: Palette.TEXT_2,
                                            fontSize: FontSize.TEXT_ALL,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                      Text(
                                        widget.andTime,
                                        style: TextStyle(
                                            color: Palette.BLACK,
                                            fontSize: FontSize.TIME_ITEM,
                                            fontWeight: FontWeight.w400,
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
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(size.width / 3, 0, size.width / 3, size.width / 20),
                    child: ItemButTomconfirm(
                      titleButTom: "Confirm",
                      onTap: () {
                        double price = double.parse(widget.price) * 23200;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormBuyingScreen(
                                      money: price.toString(),
                                      history: History(
                                        id: LoginService.userID,
                                        cityEndFlight: widget.nameCityEnd,
                                        cityStartFlight: widget.nameCityStart,
                                        codeFlight: widget.code,
                                        dateEndFlight: widget.andTime,
                                        dateStartFlight: widget.startTime,
                                        iconFlight: widget.image,
                                        nameFlightEndFlight: widget.nameFlightEnd,
                                        nameFlightStartFlight: widget.nameFlightStart,
                                        quantityFlight: widget.quantity,
                                        titleFlight: widget.title,
                                        priceFlight: widget.price,
                                      ),
                                    )));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
