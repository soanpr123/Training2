import 'package:flutter/material.dart';
import 'package:my_travel/src/bloc/hotels_bloc.dart';
import 'package:my_travel/src/model/hotels_model.dart';
import 'package:my_travel/src/shared/appbar/app_bar.dart';
import 'package:my_travel/src/shared/item_list/item_hotels.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/ui/hotel_screen/detail_hotels.dart';

class SearchTravelScreen extends StatefulWidget {
  SearchTravelScreen({this.city});
  final String city;
  @override
  State createState() => new _SearchTravelScreenState();
}

class _SearchTravelScreenState extends State<SearchTravelScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
    );
  }
}
