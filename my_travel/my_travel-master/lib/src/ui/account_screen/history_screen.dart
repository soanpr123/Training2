import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_travel/src/model/history_model.dart';
import 'package:my_travel/src/resources/flight_service.dart';
import 'package:my_travel/src/resources/login_service.dart';
import 'package:my_travel/src/shared/item_hotels_booked.dart';
import 'package:my_travel/src/shared/item_list/item_flights_screen.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State createState() => new _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  StreamController _history = StreamController();

  Stream get history => _history.stream;

  getHistory() => FlightService()
      .getHistory(userID: LoginService.userID)
      .then((data) => _history.sink.add(data));

  List<History> listFlight = [];
  List<History> listHotel = [];

  bool status = true;

  @override
  void dispose() {
    super.dispose();
    _history.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    getHistory();

    return Scaffold(
      body: StreamBuilder<Object>(
          stream: history,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              HistoryModel data = snapshot.data;

              if (status) {
                for (var item in data.data) {
                  if (item.type == LoginService.typeHotel) {
                    listHotel.add(item);
                  } else {
                    listFlight.add(item);
                  }
                }
              }

              status = false;

              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                                child: Text(
                                  "Vé máy bay đã đặt",
                                  style: TextStyle(
                                      color: Palette.BLACK,
                                      fontSize: FontSize.TEXT_DETAIL,
                                      fontWeight: FontWeight.w400),
                                )),
                            Container(
                              height: 0.7,
                              color: Palette.TEXT_2,
                              width: size.width,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  listFlight.length > 3 ? 3 : listFlight.length,
                              itemBuilder: (context, index) => Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: ItemFlightsScreen(
                                    title: listFlight[index].titleFlight,
                                    code: listFlight[index].codeFlight,
                                    price: listFlight[index].quantityFlight,
                                    startTime:
                                        listFlight[index].dateStartFlight,
                                    endTime: listFlight[index].dateEndFlight,
                                    specificTime:
                                        listFlight[index].dateStartFlight,
                                    specificTime2:
                                        listFlight[index].dateEndFlight,
                                    addressToGo:
                                        listFlight[index].cityStartFlight,
                                    destinationAddress:
                                        listFlight[index].cityEndFlight,
                                    image: listFlight[index].iconFlight,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              height: 0.2,
                              color: Palette.TEXT_2,
                              width: size.width,
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                                child: Text(
                                  "Khách sạn đã đặt",
                                  style: TextStyle(
                                      color: Palette.BLACK,
                                      fontSize: FontSize.TEXT_DETAIL,
                                      fontWeight: FontWeight.w400),
                                )),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8.0,
                                        mainAxisSpacing: 8.0,
                                        childAspectRatio: 0.8),
                                itemCount:
                                    listHotel.length > 5 ? 5 : listHotel.length,
                                itemBuilder: (context, index) {
                                  return ItemHotelsBooked(
                                    history: listHotel[index],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
