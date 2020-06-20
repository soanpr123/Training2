import 'package:flutter/material.dart';
import 'package:my_travel/src/bloc/flights_bloc.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/ui/flights_screen/fly_one_way_screen.dart';
import 'package:my_travel/src/ui/flights_screen/round_trip_screen.dart';

class SearchFlightScreen extends StatefulWidget {
  SearchFlightScreen({this.arrivalAirportCode,this.airportName});

  final String arrivalAirportCode;
  final String airportName;

  @override
  State createState() => new _SearchFlightScreenState();
}

class _SearchFlightScreenState extends State<SearchFlightScreen> {
  int selectedIndex = 0;

  int _selectedActivity = 0;

  @override
  Widget build(BuildContext context) {
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
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 00, right: 30, top: 17.0, bottom: 0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.arrow_back)),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          "Chọn hình thức bay",
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
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: activity(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget activity() {
    Size size = MediaQuery.of(context).size;
    List<Widget> _listActivity = [
      FlyOneWayScreen(
        status: 1,
        airportName: widget.airportName,
        arrivalAirportCode: widget.arrivalAirportCode,
      ),
      RoundTripScreen(
        status: 2,
        airportName: widget.airportName,
        arrivalAirportCode: widget.arrivalAirportCode,
      ),
    ];

    return Column(
      children: <Widget>[
        Expanded(
          flex: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: flightsBloc.visible ? 50 : 0.0,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Container(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 7.5, 0),
                      height: size.width / 10,
                      width: size.width / 2.2,
                      decoration: BoxDecoration(
                          color: _selectedActivity == 0
                              ? Palette.COLOR_TAB2
                              : Palette.COLOR_TAB1,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            _selectedActivity = 0;
                          });
                        },
                        child: Text("Bay 1 chiều",
                            style: TextStyle(
                              color: _selectedActivity == 0
                                  ? Palette.WHITE
                                  : Palette.BLACK,
                            )),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(7.5, 0, 30, 0),
                      height: size.width / 10,
                      width: size.width / 2.2,
                      decoration: BoxDecoration(
                          color: _selectedActivity == 1
                              ? Palette.COLOR_TAB2
                              : Palette.COLOR_TAB1,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            _selectedActivity = 1;
                          });
                        },
                        child: Text("Khứ hồi",
                            style: TextStyle(
                              color: _selectedActivity == 1
                                  ? Palette.WHITE
                                  : Palette.BLACK,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(flex: 5, child: _listActivity.elementAt(_selectedActivity)),
      ],
    );
  }
}
