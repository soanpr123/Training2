import 'package:flutter/material.dart';
import 'package:logindemo/src/models/user.dart';
import 'package:logindemo/src/provider/user_provider.dart';
import 'package:logindemo/src/widgets/friend_item.dart';
import 'package:provider/provider.dart';
import 'package:getflutter/getflutter.dart';

class HomeScreen extends StatefulWidget {
  static const routername = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatumUser datumUser=DatumUser();

  List<String> list = [];
  
  var isInit = true;
  var isLoading = false;
  Future<void> _refrestProducts(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).fetchUser(onSucess: (data){
      datumUser=data;
    return;
    });
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<UserProvider>(context).fetchUser().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
//    final itemUser = Provider.of<UserProvider>(context,listen: false).users2 ;
    return Scaffold(
        appBar: AppBar(
          title: Text("U-Oi Communication Tool"),
        ),
        body:
              isLoading ? Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                          onRefresh: () => _refrestProducts(context),
                          child: Consumer<UserProvider>(
                              builder: (ctx, userpro, _) => Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: <Widget>[
                                        GFSearchBar(
                                          searchList: list,
                                          searchQueryBuilder: (query, list) {
                                            return list
                                                .where((item) =>
                                                item.toLowerCase().contains(query.toLowerCase()))
                                                .toList();
                                          },
                                          overlaySearchListItemBuilder: (item) {
                                            return Container(
                                              padding: const EdgeInsets.all(0),
                                              child: Text(
                                                item,
                                                style: const TextStyle(fontSize: 18),
                                              ),
                                            );
                                          },
                                          onItemSelected: (item) {
                                            setState(() {
                                              print('$item');
                                            });
                                          },
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: ListView.builder(
                                              itemBuilder: (ctx, index) => FrientItems(
                                                   disPlayname: userpro.users[index].displayname,
                                                    imgeUrl: userpro.users[index].avatars,
                                                  ),
                                              itemCount: userpro.users.length),
                                        ),
                                      ],
                                    ),
                                  ))),
    );
  }
}
