import 'package:flutter/material.dart';
import 'package:getflutter/components/search_bar/gf_search_bar.dart';
class FrientItems extends StatefulWidget {
  final String disPlayname;
  final String imgeUrl;
  FrientItems({this.disPlayname, this.imgeUrl});

  @override
  _FrientItemsState createState() => _FrientItemsState();
}

class _FrientItemsState extends State<FrientItems> {


  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return
        ListTile(
          title: Text(widget.disPlayname),
          leading: CircleAvatar(
            backgroundImage: NetworkImage("https://uoi.bachasoftware.com/api/avatars/${widget.imgeUrl}"),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {

                  },
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                  icon: Icon(Icons.message),
                  onPressed: (){
                  },
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
        );

  }
}