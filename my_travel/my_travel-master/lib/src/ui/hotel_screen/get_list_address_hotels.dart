import 'package:flutter/material.dart';
import 'package:my_travel/src/bloc/hotels_bloc.dart';
import 'package:my_travel/src/model/hotel_addressmodel.dart';
import 'package:my_travel/src/shared/appbar/app_bar.dart';
import 'package:my_travel/src/shared/item_list/item_hotels4.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:intl/intl.dart';
import 'package:my_travel/src/ui/hotel_screen/search%20_results_hotel.dart';

class GetListAddressHotels extends StatefulWidget {
  final String search;

  GetListAddressHotels({this.search});

  @override
  State createState() => new _GetListAddressHotelsState();
}

class _GetListAddressHotelsState extends State<GetListAddressHotels> {
  static String timeStart;
  static String timeEnd;
  var now = new DateTime.now();
  static String yearStart, monthStart, daysStart, yearEnd, monthEnd, daysEnd;

  @override
  void initState() {
    super.initState();
    hotelsBloc.getAddressHotels(widget.search);
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
      appBar: PreferredSize(
        child: MyAppBar(
          title:  widget.search,
          icon: "",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(15, 20, 15, 15),
        child: StreamBuilder(
            stream: hotelsBloc.getAddressHotel,
            builder: (c, AsyncSnapshot<AddressHotelsModel> snap) {
              if (snap.hasData) {
                AreaRecommendationContent dataa = snap.data.data.areaRC;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 0,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(2, 0, 0, 10),
                          child: Text(
                            dataa.geoName,
                            style: TextStyle(
                                color: Palette.COLOR_BORDER_TEXTF,
                                fontSize: FontSize.TITLE_ITEM,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal),
                          ),
                        )),
                    Expanded(
                      flex: 5,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snap.data.data.areaRC
                            .areaRecommendationContentRow.length,
                        itemBuilder: (context, index) {
                          AreaRecommendationContentRow data = snap.data.data
                              .areaRC.areaRecommendationContentRow[index];
                          return ItemHotels4(
                            title: data.name,
                            image: data.imageUrl,
                            content: data.additionalInfo,
                            price: "sdsd",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SearchResultsHotelsScreen(
                                    city: dataa.geoName,
                                    geoId: data.geoId,
                                    nameCity: data.name,
                                    sourceType: data.type,
                                    yearStart: int.parse(yearStart),
                                    monthStart: int.parse(monthStart),
                                    daysStart: int.parse(daysStart),
                                    yearEnd: int.parse(yearEnd),
                                    monthEnd: int.parse(monthEnd),
                                    daysEnd: int.parse(daysEnd),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
