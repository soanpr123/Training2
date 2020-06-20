import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemHotels extends StatelessWidget {
  ItemHotels({this.title, this.content, this.price, this.onTap, this.image,this.userRating});

  final String title;
  final String content;
  final String price;
  final double userRating;
  final dynamic image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                        width: size.width,
                        height: size.height / 5,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 25,
                      width: 60,
                      padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          image: AssetImage("assets/image/backgound_price.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Text(
                        price +" \$",
                        style: TextStyle(
                            color: Palette.WHITE,
                            fontSize: FontSize.TIME3_ITEM,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: size.width,
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: FontSize.TEXT_DETAIL, color: Palette.BLACK),
                ),
              ),
              Container(
                width: size.width,
                margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: Text(
                  content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: FontSize.TIME3_ITEM, color: Palette.TEXT_2),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: RatingBar(
                  initialRating: userRating,
                  itemCount: 5,
                  itemSize: 15.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Palette.ORANGE,
                  ),
                  onRatingUpdate: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
