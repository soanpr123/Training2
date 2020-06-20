import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/ui/hotel_screen/search%20_results_hotel.dart';
import 'package:my_travel/src/ui/travel_screen/search_travel_screen.dart';

class DetailFamousCityScreen extends StatefulWidget {
  DetailFamousCityScreen(
      {this.title,
      this.image,
      this.content,
      this.status,
      this.lat,
      this.lon,
      this.city,
      this.nameCity,
      this.geoId,
      this.sourceType});

  final String title;
  final String content;
  final String lat, lon;
  final int status;
  final dynamic image;
  final String city;
  final String geoId;
  final String nameCity;
  final String sourceType;

  @override
  State createState() => new _DetailFamousCityScreenState();
}

class _DetailFamousCityScreenState extends State<DetailFamousCityScreen> {
  static String timeStart;
  static String timeEnd;
  var now = new DateTime.now();
  static String yearStart, monthStart, daysStart, yearEnd, monthEnd, daysEnd;
  
  @override
  void initState() {
    super.initState();
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
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 70,
                          margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          padding: EdgeInsets.only(
                              left: 00, right: 90, top: 16.0, bottom: 10),
                          child: IconButton(
                              icon:
                                  Icon(Icons.arrow_back, color: Palette.BLACK),
                              onPressed: () => Navigator.pop(context)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.only(
                            left: 00, right: 30, top: 17.0, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Giới thiệu các khách sạn",
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 16, 5, 0),
                            child: Text(
                              widget.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: FontSize.TITLE_BANNER,
                                  fontWeight: FontWeight.w700,
                                  color: Palette.BLACK),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.fromLTRB(3, 10, 3, 0),
                            child: Container(
                                width: size.width,
                                height: size.width / 1.8,
                                child: Image.network(
                                  widget.image,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                            child: Text(
                              widget.content,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontSize: FontSize.TITLE_LENG_LIST,
                                  fontWeight: FontWeight.w600,
                                  color: Palette.BLACK),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: checkStatus(widget.status),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkStatus(int i) {
    Size size = MediaQuery.of(context).size;
    if (i == 1) {
      return InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchTravelScreen(
              city: widget.title,
            ),
          ),
        ),
        child: Container(
          width: size.width,
          height: size.width / 8,
          color: Palette.BACKGROUND_COLOR_BUTTOM_LOGIN,
          alignment: Alignment.center,
          child: Text(
            "Tìm chuyến bay",
            style: TextStyle(
                color: Palette.WHITE,
                fontSize: FontSize.TITLE_BANNER,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchResultsHotelsScreen(
              city: "Bangkok",
              geoId: widget.geoId,
              nameCity: widget.city,
              sourceType: widget.sourceType,
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
        ),
        child: Container(
          width: size.width,
          height: size.width / 8,
          color: Palette.BACKGROUND_COLOR_BUTTOM_LOGIN,
          alignment: Alignment.center,
          child: Text(
            "Tìm khách sạn",
            style: TextStyle(
                color: Palette.WHITE,
                fontSize: FontSize.TITLE_BANNER,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal),
          ),
        ),
      );
    }
  }
}
