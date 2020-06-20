import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

class ItemHotels4 extends StatelessWidget {
  ItemHotels4({this.title, this.content, this.price, this.onTap, this.image});

  final String title;
  final String content;
  final String price;
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
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: size.width / 5,
                height: size.width / 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                    width: size.width,
                    height: size.height / 5,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: size.width/1.9,
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
                      width: size.width/1.9,
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
                        initialRating: 4,
                        itemCount: 5,
                        itemSize: 10.0,
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
            ],
          ),
        ),
      ),
    );
  }
}
