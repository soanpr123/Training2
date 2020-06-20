import 'package:flutter/material.dart';
import 'package:my_travel/src/model/history_model.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemHotelsBooked extends StatelessWidget {
  History history = History();

  ItemHotelsBooked({this.history});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    child: Image.network(
                      history.imageHotel,
                      fit: BoxFit.cover,
                      width: size.width,
                      height: size.height / 5,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  child: Text(
                    history.titleHotel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: FontSize.TEXT_DETAIL, color: Palette.BLACK,fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 2, 5, 0),
                  child: Text(
                    history.priceHotel + " \$",
                    style: TextStyle(
                        fontSize: FontSize.TEXT_DETAIL, color: Palette.COLOR_PRICE_ITEM),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            width: size.width,
            child: Container(
              width: 30,
              height: 30,
              child: Image.asset(
                "assets/icon/icon_booked.png",
                width: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
