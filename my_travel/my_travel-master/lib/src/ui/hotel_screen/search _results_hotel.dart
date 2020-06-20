import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_travel/src/bloc/hotels_bloc.dart';
import 'package:my_travel/src/model/hotels_model.dart';
import 'package:my_travel/src/shared/appbar/app_bar.dart';
import 'package:my_travel/src/shared/item_list/item_hotel3.dart';
import 'package:my_travel/src/shared/item_list/item_hotels.dart';
import 'package:my_travel/src/shared/item_list/item_hotels2.dart';
import 'package:my_travel/src/shared/item_list/item_search_hotels.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/ui/hotel_screen/get_rooms_hotels_screen.dart';
import 'package:my_travel/src/ui/hotel_screen/search_hotel.dart';

import 'detail_hotels.dart';

class SearchResultsHotelsScreen extends StatefulWidget {
  final String city;
  final String geoId;
  final String nameCity;
  final String sourceType;
  final int yearStart;
  int monthStart;
  final int daysStart;
  int yearEnd;
  final int monthEnd;
  int daysEnd;

  SearchResultsHotelsScreen(
      {this.city,
      this.sourceType,
      this.nameCity,
      this.geoId,
      this.daysEnd,
      this.monthEnd,
      this.yearEnd,
      this.daysStart,
      this.monthStart,
      this.yearStart});

  @override
  State createState() => new _SearchResultsHotelsScreenState();
}

class _SearchResultsHotelsScreenState extends State<SearchResultsHotelsScreen> {
  @override
  void initState() {
    super.initState();
    hotelsBloc.getHotels(
        widget.geoId,
        widget.nameCity,
        widget.sourceType,
        widget.yearStart,
        widget.monthStart,
        widget.daysStart,
        widget.yearEnd,
        widget.monthEnd,
        widget.daysEnd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.BACKGROUND_COLOR_SCREEN,
      appBar: PreferredSize(
        child: MyAppBar(
          title: widget.city,
          icon: "",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: StreamBuilder(
                  stream: hotelsBloc.getHotel,
                  builder: (c, AsyncSnapshot<HotelsModel> snap) {
                    if (snap.hasData) {
                      return GridView.builder(
//                  physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 2.0,
                            childAspectRatio: 0.67),
                        itemCount: snap.data.data.entries.length,
                        itemBuilder: (context, index) {
                          Entry data = snap.data.data.entries[index];
                          double mony = double.parse(data.hotelInventorySummary
                                  .cheapestRateDisplay.baseFare.amount) /
                              23200;
                          String price = mony.toStringAsFixed(2);
                          return ItemHotels(
                            title: data.displayName,
                            content: data.region,
                            price: price,
                            image: data.imageUrl,
                            userRating: double.parse(data.starRating),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailHotelScreen(
                                      image: data.imageUrl,
                                      title: data.name,
                                      region: data.region,
                                      starRating:
                                      double.parse(data.starRating),
                                      price: price,
                                      images: data.imageUrls,
                                    ))),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
