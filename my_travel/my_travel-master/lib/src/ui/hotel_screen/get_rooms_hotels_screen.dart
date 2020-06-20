import 'package:flutter/material.dart';
import 'package:my_travel/src/bloc/hotels_bloc.dart';
import 'package:my_travel/src/model/rooms_hotels_models.dart';
import 'package:my_travel/src/shared/appbar/app_bar.dart';
import 'package:my_travel/src/shared/item_list/item_rooms.dart';
import 'package:my_travel/src/shared/style/color.dart';

import 'detail_hotels.dart';

class GetRoomsHotelsScreen extends StatefulWidget {
  String userID;
  final String nameHotels;
  final String idHotels;
  final int yearStart;
  int monthStart;
  final int daysStart;
  int yearEnd;
  final int monthEnd;
  int daysEnd;

  GetRoomsHotelsScreen(
      {this.idHotels,
      this.nameHotels,
      this.daysEnd,
      this.monthEnd,
      this.yearEnd,
      this.daysStart,
      this.monthStart,
      this.userID,
      this.yearStart});

  @override
  State createState() => new _GetRoomsHotelsScreenScreenState();
}

class _GetRoomsHotelsScreenScreenState extends State<GetRoomsHotelsScreen> {
  @override
  void initState() {
    super.initState();
    hotelsBloc.getRoomsHotels(widget.idHotels, widget.yearStart, widget.monthStart,
        widget.daysStart, widget.yearEnd, widget.monthEnd, widget.daysEnd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.BACKGROUND_COLOR_SCREEN,
      appBar: PreferredSize(
        child: MyAppBar(
          title: widget.nameHotels,
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
                  stream: hotelsBloc.getRoomsHotelsModel,
                  builder: (c, AsyncSnapshot<RoomsHotelsModels> snap) {
                    if (snap.hasData) {
                      return GridView.builder(
//                  physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 1),
                        itemCount: snap.data.data.recommendedEntries.length,
                        itemBuilder: (context, index) {
                          RecommendedEntry data = snap.data.data.recommendedEntries[index];
                          double mony =
                              double.parse(data.roomList[0].rateDisplay.baseFare.amount) / 23200;
                          String price = mony.toStringAsFixed(2);
                          return ItemRooms(
                            image: data.roomList[0].roomImages[0],
                            title: data.roomList[0].name,
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailHotelScreen(
                                          image: data.roomList[0].roomImages[0],
                                          title: data.roomList[0].name,
                                          region: "",
                                          userID: widget.userID,
                                          starRating: 5,
                                          price: price,
                                          images: data.roomList[0].roomImages,
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
