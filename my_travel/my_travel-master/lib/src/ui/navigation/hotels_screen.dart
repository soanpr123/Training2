import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_travel/src/bloc/hotels_bloc.dart';
import 'package:my_travel/src/model/hotel_addressmodel.dart';
import 'package:my_travel/src/shared/item_list/item_hotel3.dart';
import 'package:my_travel/src/shared/item_list/item_hotels2.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/ui/hotel_screen/get_list_address_hotels.dart';
import 'package:my_travel/src/ui/hotel_screen/search%20_results_hotel.dart';

class HotelsScreen extends StatefulWidget {
  @override
  State createState() => new _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  TextEditingController controllerSearch = TextEditingController();
  static String timeStart;
  static String timeEnd;
  var now = new DateTime.now();
  static String yearStart, monthStart, daysStart, yearEnd, monthEnd, daysEnd;

  @override
  void initState() {
    super.initState();
    hotelsBloc.getAddressHotelsHaNoi("ha noi");
    hotelsBloc.getAddressHotelsBangkok("Bangkok");
    hotelsBloc.getAddressHotelsKorea("korea");
    timeStart = new DateFormat("dd-MM-yyyy").format(now);
    yearStart = timeStart.substring(6, 10);
    monthStart = timeStart.substring(3, 5);
    daysStart = timeStart.substring(0, 2);
    var thirtyDaysAgo = now.add(new Duration(days: 1)).toString();
    String date = thirtyDaysAgo.substring(0, 10);
    yearEnd = date.substring(0, 4);
    monthEnd = date.substring(5, 7);
    daysEnd = date.substring(8, 10);
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
                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 60,
                      padding: const EdgeInsets.only(
                          left: 00, right: 30, top: 17.0, bottom: 17.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Khách sạn",
                        style: TextStyle(
                            fontSize: FontSize.TITLE_APPBAR,
                            fontWeight: FontWeight.w700,
                            color: Palette.BLACK),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Card(
                margin: EdgeInsets.fromLTRB(17, 0, 17, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Container(
                  width: size.width,
                  height: size.width / 9,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      color: Palette.WHITE,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: TextFormField(
                            controller: controllerSearch,
                            decoration: InputDecoration(
                              hintText: "Tìm kiếm nơi bạn muốn đến...",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Palette.WHITE),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Palette.WHITE),
                              ),
                            ),
                            style: TextStyle(color: Palette.BLACK),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Container(
                          height: size.width / 18,
                          width: 1,
                          color: Palette.COLOR_BORDER,
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () => _onSubmit(controllerSearch.text),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 20, 15, 10),
//                padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                child: SingleChildScrollView(
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
                                "Ha Noi",
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
                            height: size.width / 3.5,
                            width: size.width,
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: StreamBuilder(
                                stream: hotelsBloc.getAddressHotelHanoi,
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
                                                .areaRecommendationContentRow[
                                            index];
                                        return ItemHotels2(
                                          title: data.displayName,
                                          image: data.imageUrl,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchResultsHotelsScreen(
                                                  city: "Hà nội",
                                                  geoId: data.geoId,
                                                  nameCity: data.name,
                                                  sourceType: data.type,
                                                  yearStart:
                                                      int.parse(yearStart),
                                                  monthStart:
                                                      int.parse(monthStart),
                                                  daysStart:
                                                      int.parse(daysStart),
                                                  yearEnd: int.parse(yearEnd),
                                                  monthEnd: int.parse(monthEnd),
                                                  daysEnd: int.parse(daysEnd),
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
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin:
                                EdgeInsets.fromLTRB(5, size.width / 15, 0, 0),
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Bangkok",
                              style: TextStyle(
                                  color: Palette.BLACK,
                                  fontSize: FontSize.TEXT_TITLE,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                          Container(
                            height: size.width / 3.5,
                            width: size.width,
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: StreamBuilder(
                                stream: hotelsBloc.getAddressHotelBangkok,
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
                                                .areaRecommendationContentRow[
                                            index];
                                        return ItemHotels3(
                                          image: data.imageUrl,
                                          title: data.displayName,
                                          address: data.additionalInfo,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchResultsHotelsScreen(
                                                      city: "Bangkok",
                                                      geoId: data.geoId,
                                                      nameCity: data.name,
                                                      sourceType: data.type,
                                                      yearStart:
                                                      int.parse(yearStart),
                                                      monthStart:
                                                      int.parse(monthStart),
                                                      daysStart:
                                                      int.parse(daysStart),
                                                      yearEnd: int.parse(yearEnd),
                                                      monthEnd: int.parse(monthEnd),
                                                      daysEnd: int.parse(daysEnd),
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
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            margin:
                                EdgeInsets.fromLTRB(0, size.width / 15, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Top hotel Korea",
                                    style: TextStyle(
                                        color: Palette.BLACK,
                                        fontSize: FontSize.TEXT_TITLE,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                        fontStyle: FontStyle.normal),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                                  alignment: Alignment.center,
                                  width: 40,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Palette.COLOR_ICON_NAVIGATION,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Text("Hot",
                                      style: TextStyle(
                                          color: Palette.WHITE,
                                          fontSize: FontSize.TEXT_ITEM_HOTEL,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto',
                                          fontStyle: FontStyle.normal)),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: size.width / 3.5,
                            width: size.width,
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                            child: StreamBuilder(
                                stream: hotelsBloc.getAddressHotelKorea,
                                builder: (context,
                                    AsyncSnapshot<AddressHotelsModel> snap) {
                                  if (snap.hasData) {
                                    return ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 6,
                                      itemBuilder: (context, index) {
                                        AreaRecommendationContentRow data = snap
                                                .data
                                                .data
                                                .areaRC
                                                .areaRecommendationContentRow[
                                            index];
                                        return ItemHotels2(
                                          title: data.displayName,
                                          image: data.imageUrl,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchResultsHotelsScreen(
                                                      city: "Korea",
                                                      geoId: data.geoId,
                                                      nameCity: data.name,
                                                      sourceType: data.type,
                                                      yearStart:
                                                      int.parse(yearStart),
                                                      monthStart:
                                                      int.parse(monthStart),
                                                      daysStart:
                                                      int.parse(daysStart),
                                                      yearEnd: int.parse(yearEnd),
                                                      monthEnd: int.parse(monthEnd),
                                                      daysEnd: int.parse(daysEnd),
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
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onSubmit(String search) {
    if (search != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GetListAddressHotels(
                    search: search,
                  )));
      print(search);
    } else {
      print("fali");
    }
  }
}
