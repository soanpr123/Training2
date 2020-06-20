import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_travel/src/bloc/pay_bloc.dart';
import 'package:my_travel/src/resources/flight_service.dart';
import 'package:my_travel/src/resources/login_service.dart';
import 'package:my_travel/src/shared/item_buttom/item_buttom_login.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class DetailHotelScreen extends StatefulWidget {
  String userID;
  final dynamic image;
  final String title;
  final String region;
  final String price;
  final double starRating;
  final List<dynamic> images;

  DetailHotelScreen(
      {this.userID, this.image, this.title, this.region, this.starRating, this.price, this.images});

  @override
  State createState() => new _DetailHotelScreenState();
}

class _DetailHotelScreenState extends State<DetailHotelScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Palette.WHITE,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: size.width,
                    width: size.width,
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              width: size.width,
                              height: size.width / 1.5,
                              child: Image.network(
                                widget.image,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              height: size.width / 1.5,
                              decoration: BoxDecoration(
                                  color: Palette.WHITE,
                                  gradient: LinearGradient(
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                      colors: [
                                        Palette.COLOR_BORDER_TEXTF.withOpacity(0.3),
                                        Palette.BLACK.withOpacity(0.7),
                                      ],
                                      stops: [
                                        0.0,
                                        1.0
                                      ])),
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, size.width / 13, 0, 0),
                                    child: InkWell(
                                      onTap: () => Navigator.pop(context),
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Palette.WHITE,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        widget.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Palette.WHITE,
                                            fontSize: FontSize.TITLE_APPBAR,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                            child: RatingBar(
                                              initialRating: widget.starRating,
                                              itemCount: 5,
                                              itemSize: 20.0,
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Palette.ORANGE,
                                              ),
                                              onRatingUpdate: null,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(10, 5, 0, 2),
                                            child: Text(
                                              widget.region,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Palette.BACKGROUND_COLOR_SCREEN,
                                                  fontSize: FontSize.TEXT_ITEM_HOTEL,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Roboto',
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: Palette.COLOR_BORDER_TEXTF,
                              width: 0.2,
                            ),
                          )),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 0,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        widget.price + " \$",
                                        style: TextStyle(
                                            color: Palette.BLACK,
                                            fontSize: FontSize.TITLE_PRICE_DETAIL,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                      Container(
                                        width: size.width / 4,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Average per night",
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Palette.BLACK,
                                              fontSize: FontSize.TEXT_ALL,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Roboto',
                                              fontStyle: FontStyle.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Perks",
                                        style: TextStyle(
                                            color: Palette.BLACK,
                                            fontSize: FontSize.TITLE_ITEM,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.wifi,
                                              size: 20,
                                              color: Palette.BLACK,
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                              child: Text(
                                                "Complimentary Wifi",
                                                style: TextStyle(
                                                    color: Palette.BLACK,
                                                    fontSize: FontSize.TEXT_ALL,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: 'Roboto',
                                                    fontStyle: FontStyle.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.home,
                                              size: 20,
                                              color: Palette.BLACK,
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                              child: Text(
                                                "Larger than average rooms.",
                                                style: TextStyle(
                                                    color: Palette.BLACK,
                                                    fontSize: FontSize.TEXT_ALL,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: 'Roboto',
                                                    fontStyle: FontStyle.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.access_time,
                                              size: 20,
                                              color: Palette.BLACK,
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                              child: Text(
                                                "Late checkout available.",
                                                style: TextStyle(
                                                    color: Palette.BLACK,
                                                    fontSize: FontSize.TEXT_ALL,
                                                    fontWeight: FontWeight.normal,
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
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    height: size.width / 0.99,
                    width: size.width,
                    padding: EdgeInsets.fromLTRB(0, 0, size.width / 10, size.width / 4.3),
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Palette.COLOR2),
                      child: Icon(
                        Icons.star,
                        color: Palette.WHITE,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0),
                            itemCount: widget.images.length,
                            itemBuilder: (context, index) {
                              return Image.network(widget.images[index]);
                            },
                          )),
                    ),
                  ),
                  Expanded(
                      flex: 0,
                      child: InkWell(
                        onTap: () => _onConfirm(widget.price),
                        child: Container(
                          width: size.width,
                          height: size.width / 8,
                          alignment: Alignment.center,
                          color: Palette.BACKGROUND_COLOR_BUTTOM_LOGIN,
                          child: Text(
                            "Đặt khách sạn ${widget.price} \$",
                            style: TextStyle(
                                color: Palette.WHITE,
                                fontSize: FontSize.TITLE_APPBAR,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onConfirm(String price) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: size.width - 100,
              width: size.width,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 0,
                    child: Container(
                      height: size.width / 7,
                      width: size.width,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      color: Palette.BACKGROUND_COLOR_BUTTOM_LOGIN,
                      child: Text(
                        "Giá " + "$price" + "\$",
                        style: TextStyle(
                            color: Palette.WHITE,
                            fontSize: FontSize.TITLE_APPBAR,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                height: size.width / 3.6,
                                width: size.width / 3.6,
                                margin: EdgeInsets.fromLTRB(20, 20, 15, 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    widget.image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.fromLTRB(0, size.width / 25, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: size.width / 1.75,
                                      child: Text(
                                        widget.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Palette.BLACK,
                                            fontSize: FontSize.TEXT_TITLE,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                      child: Text(
                                        price + "\$ " + "1 Night",
                                        style: TextStyle(
                                            color: Palette.COLOR_BORDER_TEXTF,
                                            fontSize: FontSize.TEXT_ITEM_HOTEL,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.wifi,
                                            size: 20,
                                            color: Palette.BLACK,
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                            child: Text(
                                              "Complimentary Wifi",
                                              style: TextStyle(
                                                  color: Palette.BLACK,
                                                  fontSize: FontSize.TEXT_ALL,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'Roboto',
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.home,
                                            size: 20,
                                            color: Palette.BLACK,
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                            child: Text(
                                              "Larger than average rooms.",
                                              style: TextStyle(
                                                  color: Palette.BLACK,
                                                  fontSize: FontSize.TEXT_ALL,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'Roboto',
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            size: 20,
                                            color: Palette.BLACK,
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                            child: Text(
                                              "Late checkout available.",
                                              style: TextStyle(
                                                  color: Palette.BLACK,
                                                  fontSize: FontSize.TEXT_ALL,
                                                  fontWeight: FontWeight.normal,
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
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
                            child: ItemButTomLogIn(
                              titleButTom: "Xác nhận",
                              color: Palette.BACKGROUND_COLOR_BUTTOM_LOGIN,
                              size1: FontSize.TITLE_LOGIN,
                              colorTitle: Palette.WHITE,
                              onTap: () async {
                                double pricea = double.parse(price) * 23200;
                                await FlightService().addHistory(
                                  type: LoginService.typeHotel,
                                  titleHotel: widget.title,
                                  starRatingHotel: widget.starRating.toString(),
                                  regionHotel: widget.region,
                                  priceHotel: widget.price,
                                  imagesHotel: widget.images,
                                  imageHotel: widget.image,
                                  userID: widget.userID,
                                );
                                payBloc.openMoMo(pricea.toString());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
