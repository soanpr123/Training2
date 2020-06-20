import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_travel/src/bloc/flights_bloc.dart';
import 'package:my_travel/src/bloc/hotels_bloc.dart';
import 'package:my_travel/src/bloc/travel_bloc.dart';
import 'package:my_travel/src/model/code_airport_model.dart';
import 'package:my_travel/src/model/hotel_addressmodel.dart';
import 'package:my_travel/src/shared/item_list/item_travel_famous_city.dart';
import 'package:my_travel/src/shared/item_list/item_travel_tendency.dart';
import 'package:my_travel/src/shared/item_list/item_travel_top.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/ui/flights_screen/search_flight.dart';
import 'package:my_travel/src/ui/travel_screen/detail_famous_city_screen.dart';

class TravelScreen extends StatefulWidget {
  @override
  State createState() => new _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  CarouselSlider carouselSlider;

  @override
  void initState() {
    super.initState();
    travelBloc.getTravel();
    hotelsBloc.getAddressHotelsA("Da Nang");
    hotelsBloc.getAddressHotelsN("Japan");
    flightsBloc.getAirportA("Lao");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Palette.BACKGROUND_COLOR_SCREEN,
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    color: Palette.COLOR_BORDER_TEXTF,
                    width: 0.1,
                  ),
                )),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        padding: const EdgeInsets.only(
                            left: 00, right: 30, top: 17.0, bottom: 17.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Địa điểm nổi tiếng!",
                          style: TextStyle(
                              fontSize: FontSize.TITLE_APPBAR,
                              fontWeight: FontWeight.w700,
                              color: Palette.BLACK),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 15, 10),
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Container(
                            height: 30,
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Đà Nẵng",
                              style: TextStyle(
                                  color: Palette.BLACK,
                                  fontSize: FontSize.TEXT_TITLE,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Container(
                          height: size.width / 1.2,
                          width: size.width,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: StreamBuilder(
                            stream: hotelsBloc.getAddressHotelA,
                            builder: (context,
                                AsyncSnapshot<AddressHotelsModel> snap) {
                              if (snap.hasData) {
                                return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snap.data.data.areaRC
                                      .areaRecommendationContentRow.length,
                                  itemBuilder: (context, index) {
                                    AreaRecommendationContentRow data = snap
                                        .data
                                        .data
                                        .areaRC
                                        .areaRecommendationContentRow[index];
                                    return ItemTravelFamousCity(
                                      image: data.imageUrl,
                                      title: data.displayName,
                                      conTent: data.name,
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailFamousCityScreen(
                                            title: data.name,
                                            image: data.imageUrl,
                                            content: data.name,
                                            status: 2,
                                            lat: data.geoLocation.lat,
                                            lon: data.geoLocation.lon,
                                            geoId: data.geoId,
                                            nameCity: data.name,
                                            sourceType: data.type,
                                            city: data.name,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 30,
                          margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Bay nhanh",
                            style: TextStyle(
                                color: Palette.BLACK,
                                fontSize: FontSize.TEXT_TITLE,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                        Container(
                          height: size.width / 5,
                          width: size.width,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: StreamBuilder(
                              stream: flightsBloc.getCodeAirportA,
                              builder: (context,
                                  AsyncSnapshot<CodeAirportModel> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data.data
                                        .recommendationAirportOrArea.length,
                                    itemBuilder: (context, index) {
                                      AirportDisplay data = snapshot
                                          .data
                                          .data
                                          .recommendationAirportOrArea[index]
                                          .airportDisplay;
                                      return ItemTravelTop(
                                        image:
                                            "https://bpic.588ku.com/element_origin_min_pic/19/03/07/84fac162f4c3b630e6f7b23255707589.jpg",
                                        title: data.shortLocation,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SearchFlightScreen(
                                                airportName: data.name,
                                                arrivalAirportCode: data.code,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 30,
                          margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Nhật Bản",
                            style: TextStyle(
                                color: Palette.BLACK,
                                fontSize: FontSize.TEXT_TITLE,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                        Container(
                          height: size.width / 3,
                          width: size.width,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: StreamBuilder(
                            stream: hotelsBloc.getAddressHotelN,
                            builder: (context,
                                AsyncSnapshot<AddressHotelsModel> snap) {
                              if (snap.hasData) {
                                return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snap.data.data.areaRC
                                      .areaRecommendationContentRow.length,
                                  itemBuilder: (context, index) {
                                    AreaRecommendationContentRow data = snap
                                        .data
                                        .data
                                        .areaRC
                                        .areaRecommendationContentRow[index];
                                    return ItemTravelTendency(
                                      image: data.imageUrl,
                                      title: data.displayName,
                                      content: data.name,
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailFamousCityScreen(
                                            title: data.name,
                                            image: data.imageUrl,
                                            content: data.name,
                                            status: 2,
                                            lat: data.geoLocation.lat,
                                            lon: data.geoLocation.lon,
                                            geoId: data.geoId,
                                            nameCity: data.name,
                                            sourceType: data.type,
                                            city: data.name,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
