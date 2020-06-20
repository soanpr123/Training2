import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/item_list/item_hotel3.dart';
import 'package:my_travel/src/shared/item_list/item_hotels2.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/ui/hotel_screen/search%20_results_hotel.dart';

class SearchHotelsScreen extends StatefulWidget {
  @override
  State createState() => new _SearchHotelsScreenState();
}

class _SearchHotelsScreenState extends State<SearchHotelsScreen> {
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
                              child: Container(
                                height: 40,
                                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Palette.BLACK,
                                ),
                              )),
                          Text(
                            "Search hotels",
                            style: TextStyle(
                                fontSize: FontSize.TITLE_APPBAR,
                                fontWeight: FontWeight.w700,
                                color: Palette.BLACK),
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
                            decoration: InputDecoration(
                              hintText: "Search for a hotel...",
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
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SearchResultsHotelsScreen(),
                              ),
                            ),
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
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  height: 30,
                                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "For you",
                                    style: TextStyle(
                                        color: Palette.BLACK,
                                        fontSize: FontSize.TEXT_TITLE,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                        fontStyle: FontStyle.normal),
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "Show all",
                                    style: TextStyle(
                                        color: Palette.COLOR_ICON_NAVIGATION,
                                        fontSize: FontSize.TEXT_ALL,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto',
                                        fontStyle: FontStyle.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: size.width / 3.5,
                            width: size.width,
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return ItemHotels2();
                              },
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            margin:
                            EdgeInsets.fromLTRB(0, size.width / 15, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  height: 30,
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "Popular deals",
                                    style: TextStyle(
                                        color: Palette.BLACK,
                                        fontSize: FontSize.TEXT_TITLE,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                        fontStyle: FontStyle.normal),
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "Show all",
                                    style: TextStyle(
                                        color: Palette.COLOR_ICON_NAVIGATION,
                                        fontSize: FontSize.TEXT_ALL,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto',
                                        fontStyle: FontStyle.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: size.width / 3.5,
                            width: size.width,
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return ItemHotels3();
                              },
                            ),
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
                                    "Top hotel",
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
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return ItemHotels2();
                              },
                            ),
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
}
