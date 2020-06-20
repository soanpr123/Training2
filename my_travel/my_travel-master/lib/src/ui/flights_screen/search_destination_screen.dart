import 'package:flutter/material.dart';
import 'package:my_travel/src/bloc/flights_bloc.dart';
import 'package:my_travel/src/model/code_airport_model.dart';
import 'package:my_travel/src/shared/appbar/app_bar.dart';
import 'package:my_travel/src/shared/item_list/item_code_flight.dart';
import 'package:my_travel/src/shared/item_list/item_travel_top.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/ui/flights_screen/search_flight.dart';
import 'package:my_travel/src/ui/flights_screen/search_results_flights_screen.dart';

class SearchDestinationScreen extends StatefulWidget {
  final String arrivalAirportCode;
  final String yearStart;
  final String monthStart;
  final String dayStart;
  final String yearEnd;
  final String monthEnd;
  final String dayEnd;
  final String numAdults;
  final int status;

  SearchDestinationScreen(
      {this.arrivalAirportCode,
      this.yearEnd,
      this.monthEnd,
      this.dayEnd,
      this.yearStart,
      this.monthStart,
      this.numAdults,
      this.status,
      this.dayStart});

  @override
  State createState() => new _SearchDestinationScreenState();
}

class _SearchDestinationScreenState extends State<SearchDestinationScreen> {
  TextEditingController controllerSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    flightsBloc.getCodeAirportModel5("châu á");
    print(widget.status);
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
                      child: Row(
                        children: <Widget>[
                          InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.arrow_back)),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              "Tìm kiếm điểm đến",
                              style: TextStyle(
                                  fontSize: FontSize.TITLE_APPBAR,
                                  fontWeight: FontWeight.w700,
                                  color: Palette.BLACK),
                            ),
                          ),
                        ],
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
                              hintText: "Tìm kiếm điểm đến...",
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
              flex: 4,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Container(
                            height: 30,
                            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Gợi ý điểm đến",
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
                          height: size.width / 5,
                          width: size.width,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(10, 0, 15, 0),
                          child: StreamBuilder(
                              stream: flightsBloc.getCodeAirport5,
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
                                        image: "http://bit.ly/383XYar",
                                        title: data.shortLocation,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchResultsFlightsScreen(
                                                        startCode: widget
                                                            .arrivalAirportCode,
                                                        endCode: data.code,
                                                        yearStart:
                                                            widget.yearStart,
                                                        yearEnd: widget.yearEnd,
                                                        monthStart:
                                                            widget.monthStart,
                                                        monthEnd:
                                                            widget.monthEnd,
                                                        dayStart:
                                                            widget.dayStart,
                                                        dayEnd: widget.dayEnd,
                                                        numAdults:
                                                            widget.numAdults,
                                                        status: widget.status,
                                                      )));
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
                    StreamBuilder(
                        stream: flightsBloc.getCodeAirport6,
                        builder: (context,
                            AsyncSnapshot<CodeAirportModel> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              height: size.height - 300,
                              padding: EdgeInsets.fromLTRB(10, 20, 15, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, size.width / 50, 0, 0),
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Kết quả tìm kiếm",
                                        style: TextStyle(
                                            color: Palette.BLACK,
                                            fontSize: FontSize.TEXT_TITLE,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal),
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Container(
                                      height: size.height - 360,
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data.data
                                            .recommendationAirportOrArea.length,
                                        itemBuilder: (context, index) {
                                          AirportDisplay data = snapshot
                                              .data
                                              .data
                                              .recommendationAirportOrArea[
                                                  index]
                                              .airportDisplay;

                                          return ItemcodeFlight(
                                            nameCity: data.shortLocation,
                                            code: data.code,
                                            country: data.country,
                                            name: data.name,
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SearchResultsFlightsScreen(
                                                            startCode: widget
                                                                .arrivalAirportCode,
                                                            endCode: data.code,
                                                            yearStart: widget
                                                                .yearStart,
                                                            yearEnd:
                                                                widget.yearEnd,
                                                            monthStart: widget
                                                                .monthStart,
                                                            monthEnd:
                                                                widget.monthEnd,
                                                            dayStart:
                                                                widget.dayStart,
                                                            dayEnd:
                                                                widget.dayEnd,
                                                            numAdults: widget
                                                                .numAdults,
                                                            status:
                                                                widget.status,
                                                          )));
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                  ],
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
      flightsBloc.getCodeAirportModel6(search);
//      Navigator.push(
//          context,
//          MaterialPageRoute(
//              builder: (context) => GetListSearchScreen(
//                    search: search,
//                  )));
    } else {
      print("fali");
    }
  }
}
