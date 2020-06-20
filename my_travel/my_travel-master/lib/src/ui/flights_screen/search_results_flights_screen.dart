import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_travel/src/bloc/flights_bloc.dart';
import 'package:my_travel/src/model/flight_model.dart';
import 'package:my_travel/src/model/flight_one_way_model.dart';
import 'package:my_travel/src/shared/appbar/app_bar.dart';
import 'package:my_travel/src/shared/item_list/item_flights_screen.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/ui/flights_screen/flight_selected_screen.dart';

class SearchResultsFlightsScreen extends StatefulWidget {
  final int status;

  SearchResultsFlightsScreen(
      {this.dayEnd,
      this.dayStart,
      this.monthEnd,
      this.monthStart,
      this.yearEnd,
      this.yearStart,
      this.numAdults,
      this.endCode,
      this.startCode,
      this.status});

  final String startCode;
  final String endCode;
  final String yearStart;
  final String monthStart;
  final String dayStart;
  final String yearEnd;
  final String monthEnd;
  final String dayEnd;
  final String numAdults;

  @override
  State createState() => new _SearchResultsFlightsScreenState();
}

class _SearchResultsFlightsScreenState
    extends State<SearchResultsFlightsScreen> {
  @override
  void initState() {
    super.initState();
    checkService(widget.status);
    print(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Palette.GREY8,
      appBar: PreferredSize(
        child: MyAppBar(
          title: "HN" + " - " + "TL",
          icon: "assets/icon/icon_notification.png",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Container(
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 10),
                  child: Text(
                    "Chuyến bay được tìm thấy",
                    style: TextStyle(
                        color: Palette.COLOR_TITLE_FLIGHTS2,
                        fontWeight: FontWeight.w500,
                        fontSize: FontSize.TITLE_ITEM_BANNER),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: size.height,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: checkStatus(widget.status),
              ),
            ) //            ItemFlightsScreen()
          ],
        ),
      ),
    );
  }

  checkStatus(int i) {
    if (i == 1) {
      return StreamBuilder(
          stream: flightsBloc.getFlight1,
          builder: (context, AsyncSnapshot<DataFlight2> snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 0,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                      child: Text(
                        snapshot.data.flightModel.data.searchResults.length
                                .toString() +
                            " Chuyến",
                        style: TextStyle(
                            color: Palette.COLOR_TITLE_FLIGHTS2,
                            fontWeight: FontWeight.w500,
                            fontSize: FontSize.TITLE_LENG_LIST),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: ListView.builder(
                        itemCount:
                            snapshot.data.flightModel.data.searchResults.length,
                        itemBuilder: (context, index) {
                          SearchResult2 data = snapshot
                              .data.flightModel.data.searchResults[index];
                          // diểm đi
                          String arrivalAirport = data
                              .connectingFlightRoutes[0].arrivalAirport
                              .toString();
                          String addressToGo = arrivalAirport.substring(
                              arrivalAirport.length - 3, arrivalAirport.length);

                          // điểm kết thúc
                          String departureAirport = data
                              .connectingFlightRoutes[0].departureAirport
                              .toString();
                          String destinationAddress =
                              departureAirport.substring(
                                  arrivalAirport.length - 3,
                                  arrivalAirport.length);
                          double price = double.parse(data
                                  .airlineFareInfo.totalAdditionalFare.amount) /
                              23200;

                          final airlineCode = data
                              .connectingFlightRoutes[0].segments[0].airlineCode
                              .toString();

                          Bl2 bl = Bl2.fromJson(snapshot.data.b1[airlineCode]);
                          AirportDataMap2 airportDataMap =
                              AirportDataMap2.fromJson(
                                  snapshot.data.airportDataMap[addressToGo]);
                          AirportDataMap2 departureAirport2 =
                              AirportDataMap2.fromJson(snapshot
                                  .data.airportDataMap[destinationAddress]);

                          var moonLanding = DateTime.utc(
                              int.parse(data.connectingFlightRoutes[0]
                                  .segments[0].departureDate.year),
                              int.parse(data.connectingFlightRoutes[0]
                                  .segments[0].departureDate.month),
                              int.parse(data.connectingFlightRoutes[0]
                                  .segments[0].departureDate.day));
                          var date =
                              new DateFormat("d MMM, EEE").format(moonLanding);

                          return Container(
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: ItemFlightsScreen(
                              title: bl.name,
                              code: data.connectingFlightRoutes[0].segments[0]
                                  .flightNumber,
                              price: price.toStringAsFixed(2).toString(),
                              startTime: data.connectingFlightRoutes[0]
                                      .segments[0].departureTime.hour +
                                  ":" +
                                  data.connectingFlightRoutes[0].segments[0]
                                      .departureTime.minute,
                              endTime: data.connectingFlightRoutes[0]
                                      .segments[0].arrivalTime.hour +
                                  ":" +
                                  data.connectingFlightRoutes[0].segments[0]
                                      .arrivalTime.minute,
                              specificTime: data.connectingFlightRoutes[0]
                                          .segments[0].aircraftInformation !=
                                      null
                                  ? data.connectingFlightRoutes[0].segments[0]
                                      .aircraftInformation.cabinBaggage.weight
                                  : "12" + "KG",
                              specificTime2: data.connectingFlightRoutes[0]
                                  .segments[0].flightNumber,
                              addressToGo: addressToGo,
                              destinationAddress: destinationAddress,
                              image: bl.iconUrl,
                              onTap: () {
                                double timeH = double.parse(data
                                        .connectingFlightRoutes[0]
                                        .segments[0]
                                        .arrivalTime
                                        .hour) -
                                    double.parse(data.connectingFlightRoutes[0]
                                        .segments[0].departureTime.hour);

                                double timeM = double.parse(data
                                        .connectingFlightRoutes[0]
                                        .segments[0]
                                        .arrivalTime
                                        .minute) -
                                    double.parse(data.connectingFlightRoutes[0]
                                        .segments[0].departureTime.minute);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FlightSelectedScreen(
                                              timeH: timeH,
                                              timeM: timeM,
                                              addressToGo: addressToGo,
                                              destinationAddress:
                                                  destinationAddress,
                                              price: price
                                                  .toStringAsFixed(2)
                                                  .toString(),
                                              startTime: data
                                                      .connectingFlightRoutes[0]
                                                      .segments[0]
                                                      .departureTime
                                                      .hour +
                                                  ":" +
                                                  data
                                                      .connectingFlightRoutes[0]
                                                      .segments[0]
                                                      .departureTime
                                                      .minute,
                                              andTime: data
                                                      .connectingFlightRoutes[0]
                                                      .segments[0]
                                                      .arrivalTime
                                                      .hour +
                                                  ":" +
                                                  data
                                                      .connectingFlightRoutes[0]
                                                      .segments[0]
                                                      .arrivalTime
                                                      .minute,
                                              code: data
                                                  .connectingFlightRoutes[0]
                                                  .segments[0]
                                                  .flightNumber,
                                              image: bl.iconUrl,
                                              title: bl.name,
                                              nameCityStart:
                                                  airportDataMap.city,
                                              nameCityEnd:
                                                  departureAirport2.city,
                                              moonLanding: date,
                                              specificTime: data
                                                          .connectingFlightRoutes[
                                                              0]
                                                          .segments[0]
                                                          .aircraftInformation !=
                                                      null
                                                  ? data
                                                      .connectingFlightRoutes[0]
                                                      .segments[0]
                                                      .aircraftInformation
                                                      .cabinBaggage
                                                      .weight
                                                  : "12" + "KG",
                                              nameFlightEnd:
                                                  departureAirport2.localName,
                                              nameFlightStart:
                                                  airportDataMap.localName,
                                              quantity: data
                                                          .connectingFlightRoutes[
                                                              0]
                                                          .segments[0]
                                                          .aircraftInformation !=
                                                      null
                                                  ? data
                                                      .connectingFlightRoutes[0]
                                                      .segments[0]
                                                      .aircraftInformation
                                                      .cabinBaggage
                                                      .quantity
                                                  : "1",
                                              weight: data
                                                          .connectingFlightRoutes[
                                                              0]
                                                          .segments[0]
                                                          .aircraftInformation !=
                                                      null
                                                  ? data
                                                      .connectingFlightRoutes[0]
                                                      .segments[0]
                                                      .aircraftInformation
                                                      .cabinBaggage
                                                      .weight
                                                  : "12" + "KG",
                                              status: widget.status,
                                            )));
                              },
                            ),
                          );
                        }),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    } else {
      return StreamBuilder(
          stream: flightsBloc.getFlight,
          builder: (context, AsyncSnapshot<DataFlight> snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 0,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                      child: Text(
                        snapshot.data.flightModel.data.searchResults.length
                                .toString() +
                            " Chuyến",
                        style: TextStyle(
                            color: Palette.COLOR_TITLE_FLIGHTS2,
                            fontWeight: FontWeight.w500,
                            fontSize: FontSize.TITLE_LENG_LIST),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: ListView.builder(
                        itemCount:
                            snapshot.data.flightModel.data.searchResults.length,
                        itemBuilder: (context, index) {
                          SearchResult data = snapshot
                              .data.flightModel.data.searchResults[index];
                          // diểm đi
                          String arrivalAirport = data
                              .connectingFlightRoutes[0].arrivalAirport
                              .toString();
                          String addressToGo = arrivalAirport.substring(
                              arrivalAirport.length - 3, arrivalAirport.length);

                          // điểm kết thúc
                          String departureAirport = data
                              .connectingFlightRoutes[0].departureAirport
                              .toString();
                          String destinationAddress =
                              departureAirport.substring(
                                  arrivalAirport.length - 3,
                                  arrivalAirport.length);
                          double price = double.parse(data
                                  .airlineFareInfo.totalAdditionalFare.amount) /
                              23200;

                          final airlineCode = data
                              .connectingFlightRoutes[0].segments[0].airlineCode
                              .toString();

                          Bl bl = Bl.fromJson(snapshot.data.b1[airlineCode]);
                          AirportDataMap airportDataMap =
                              AirportDataMap.fromJson(
                                  snapshot.data.airportDataMap[addressToGo]);
                          AirportDataMap departureAirport2 =
                              AirportDataMap.fromJson(snapshot
                                  .data.airportDataMap[destinationAddress]);

                          var moonLanding = DateTime.utc(
                              int.parse(data.connectingFlightRoutes[0]
                                  .segments[0].departureDate.year),
                              int.parse(data.connectingFlightRoutes[0]
                                  .segments[0].departureDate.month),
                              int.parse(data.connectingFlightRoutes[0]
                                  .segments[0].departureDate.day));
                          var date =
                              new DateFormat("d MMM, EEE").format(moonLanding);

                          return Container(
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: ItemFlightsScreen(
                              title: bl.name,
                              code: data.connectingFlightRoutes[0].segments[0]
                                  .flightNumber,
                              price: price.toStringAsFixed(2).toString(),
                              startTime: data.connectingFlightRoutes[0]
                                      .segments[0].departureTime.hour +
                                  ":" +
                                  data.connectingFlightRoutes[0].segments[0]
                                      .departureTime.minute,
                              endTime: data.connectingFlightRoutes[0]
                                      .segments[0].arrivalTime.hour +
                                  ":" +
                                  data.connectingFlightRoutes[0].segments[0]
                                      .arrivalTime.minute,
                              specificTime: data
                                      .connectingFlightRoutes[0]
                                      .segments[0]
                                      .aircraftInformation
                                      .cabinBaggage
                                      .weight +
                                  "KG",
                              specificTime2: data.connectingFlightRoutes[0]
                                  .segments[0].flightNumber,
                              addressToGo: addressToGo,
                              destinationAddress: destinationAddress,
                              image: bl.iconUrl,
                              onTap: () {
                                double timeH = double.parse(data
                                        .connectingFlightRoutes[0]
                                        .segments[0]
                                        .arrivalTime
                                        .hour) -
                                    double.parse(data.connectingFlightRoutes[0]
                                        .segments[0].departureTime.hour);

                                double timeM = double.parse(data
                                        .connectingFlightRoutes[0]
                                        .segments[0]
                                        .arrivalTime
                                        .minute) -
                                    double.parse(data.connectingFlightRoutes[0]
                                        .segments[0].departureTime.minute);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FlightSelectedScreen(
                                              timeH: timeH,
                                              timeM: timeM,
                                              addressToGo: addressToGo,
                                              destinationAddress:
                                                  destinationAddress,
                                              price: price
                                                  .toStringAsFixed(2)
                                                  .toString(),
                                              startTime: data
                                                      .connectingFlightRoutes[0]
                                                      .segments[0]
                                                      .departureTime
                                                      .hour +
                                                  ":" +
                                                  data
                                                      .connectingFlightRoutes[0]
                                                      .segments[0]
                                                      .departureTime
                                                      .minute,
                                              andTime: data
                                                      .connectingFlightRoutes[0]
                                                      .segments[0]
                                                      .arrivalTime
                                                      .hour +
                                                  ":" +
                                                  data
                                                      .connectingFlightRoutes[0]
                                                      .segments[0]
                                                      .arrivalTime
                                                      .minute,
                                              code: data
                                                  .connectingFlightRoutes[0]
                                                  .segments[0]
                                                  .flightNumber,
                                              image: bl.iconUrl,
                                              title: bl.name,
                                              nameCityStart:
                                                  airportDataMap.city,
                                              nameCityEnd:
                                                  departureAirport2.city,
                                              moonLanding: date,
                                              specificTime: data
                                                      .connectingFlightRoutes[0]
                                                      .segments[0]
                                                      .aircraftInformation
                                                      .cabinBaggage
                                                      .weight +
                                                  "KG",
                                              nameFlightEnd:
                                                  departureAirport2.localName,
                                              nameFlightStart:
                                                  airportDataMap.localName,
                                              quantity: data
                                                  .connectingFlightRoutes[0]
                                                  .segments[0]
                                                  .aircraftInformation
                                                  .cabinBaggage
                                                  .quantity,
                                              weight: data
                                                  .connectingFlightRoutes[0]
                                                  .segments[0]
                                                  .aircraftInformation
                                                  .cabinBaggage
                                                  .weight,
                                              status: widget.status,
                                            )));
                              },
                            ),
                          );
                        }),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    }
  }

  checkService(int i) {
    if (i == 1) {
      flightsBloc.getFlights1(widget.startCode, widget.endCode,
          widget.yearStart, widget.monthStart, widget.dayStart);
    } else {
      flightsBloc.getFlights(
          widget.startCode,
          widget.endCode,
          widget.numAdults,
          widget.yearStart,
          widget.monthStart,
          widget.dayStart,
          widget.yearEnd,
          widget.monthEnd,
          widget.dayEnd);
    }
  }
}
