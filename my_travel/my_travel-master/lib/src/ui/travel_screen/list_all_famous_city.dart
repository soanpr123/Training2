import 'package:flutter/material.dart';
import 'package:my_travel/src/shared/item_list/item_famous_city.dart';
import 'package:my_travel/src/shared/style/color.dart';
import 'package:my_travel/src/shared/style/font_size.dart';

import 'detail_famous_city_screen.dart';

class ListAllFamousCityScreen extends StatefulWidget {
  @override
  State createState() => new _ListAllFamousCityScreenState();
}

class _ListAllFamousCityScreenState extends State<ListAllFamousCityScreen> {
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
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    color: Palette.COLOR_BORDER_TEXTF,
                    width: 0.2,
                  ),
                )),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 70,
                        margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        padding: const EdgeInsets.only(
                            left: 00, right: 30, top: 16.0, bottom: 10),
//                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            icon: Icon(Icons.arrow_back, color: Palette.BLACK),
                            onPressed: () => Navigator.pop(context)),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.only(
                            left: 00, right: 30, top: 17.0, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Famous city",
                          style: TextStyle(
                              fontSize: FontSize.TITLE_APPBAR,
                              fontWeight: FontWeight.w700,
                              color: Palette.BLACK),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: GridView.builder(
//                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0,
                      childAspectRatio: 0.83),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return ItemFamousCity(
                      title: "Lady Liberty",
                      content: "THINGS TO DO",
                      price: "283239",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailFamousCityScreen(
                                title: "New York, United States",
                                image: "http://bit.ly/2R1dOwn",
                                content:
                                "Thông thường khi được chọn sân đầu trận đấu, đội tuyển Việt Nam th"
                                    "ường lấy phần sân cùng phía với khu vực kỹ thuật của đội nhà t"
                                    "rong hiệp một. Tuy nhiên, ở trận gặp U22 Lào, đội trưởng Quang Hả"
                                    "i đưa ra quyết định ngược lại, chọn phần sân ngược nắng cho U22 Việt Nam"
                                    "Em nghĩ là khi vào sân có hai lợi thế, mỗi bên sân có một lợi thế. Bên này lợi"
                                    " gió, bên kia lợi nắng. Em chọn lợi gió, tiền vệ mang áo số 19 giải thích. D"
                                    "ù thi đấu cả hiệp một trong tình trạng ngược nắng, U22 Việt Nam không gặ"
                                    "p bất lợi gì do các học trò của HLV Park Hang Seo kiểm soát thế trận rất tốt, "
                                    "không cho đối thủ có nhiều bóng để tấn công.Nhận xét về điều kiện thi đấu của sâ"
                                    "n Binan, Quang Hải chia sẻ: Mặt sân cỏ nhân tạo đá khó hơn cỏ thường do độ nảy k"
                                    "hác và không lường trước được bóng sẽ đi đâu nên khống chế khá là khó khăn.",
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
