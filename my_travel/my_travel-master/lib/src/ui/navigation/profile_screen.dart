import 'package:flutter/material.dart';
import 'package:my_travel/src/model/base_model/login.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';
import 'package:my_travel/src/ui/account_screen/history_screen.dart';
import 'package:my_travel/src/ui/account_screen/information_screen.dart';

class ProfileScreen extends StatefulWidget {
  DatumLogin datumLogin = DatumLogin();

  ProfileScreen({this.datumLogin});

  @override
  State createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selected = 0;
  TabController _tabController = TabController(length: 2, vsync: AnimatedListState());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 15),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          widget.datumLogin.name,
                          style: TextStyle(
                              fontSize: FontSize.TITLE_LOGIN,
                              color: Palette.BLACK,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: size.width / 1.6,
                        margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                        child: Text("Ngách 42, Ngõ 58, Nguyễn Khánh Toàn, Cầu Giấy, Hà Nội",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: FontSize.ITEM_MENU, color: Palette.TEXT_2)),
                      ),
                    ],
                  ),
                  Container(
                    height: size.height / 10,
                    width: size.width / 5.2,
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Palette.BACKGROUND_COLOR_BUTTOM_LOGIN),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child: Image.network(
                        widget.datumLogin.avatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Palette.BACKGROUND_COLOR_BUTTOM_LOGIN,
                  labelColor: Palette.BLACK,
                  unselectedLabelColor: Palette.COLOR_BORDER_TEXTF,
//                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  onTap: (i) async {
                    setState(() {
                      i == 0 ? selected = 0 : selected = 1;
                    });
                  },
                  tabs: [
                    Tab(
                      text: "Lịch sử",
                    ),
                    Tab(
                      text: "Thông tin",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: IndexedStack(
                index: selected,
                children: [
                  HistoryScreen(),
                  InformationScreen(
                    datumLogin: widget.datumLogin,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
