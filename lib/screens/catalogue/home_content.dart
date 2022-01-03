import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/rate_us.dart';
import 'package:url_launcher/url_launcher.dart';

import 'catalogue_ui.dart';

class Catalogue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: size.height * .02,
        ),
        Wrap(
          alignment: WrapAlignment.spaceAround,
          children: catalogueDataList.map((e) {
            return GestureDetector(
              onTap: () {
                !e.isNet
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (context) => e.onPressed))
                    : e.onTap();
              },
              child: DPadding(
                val: .005,
                child: Container(
                  width: size.width * .42,
                  height: size.height * .17,
                  child: DPadding(
                    val: .015,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54, width: 3),
                          borderRadius:
                              BorderRadius.circular(size.height * .017),
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/catalogues/${e.image}.png'),
                              fit: BoxFit.fill)),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                              top: size.height * .005,
                              left: size.width * .005,
                              child: e.isNet
                                  ? Icon(Icons.connect_without_contact)
                                  : Icon(Icons.policy)),
                          Positioned(
                              bottom: 0,
                              child: Opacity(
                                opacity: .6,
                                child: Container(
                                  width: size.width * .35,
                                  height: size.width * .08,
                                  color: Colors.black,
                                ),
                              )),
                          Positioned(
                              bottom: size.height * .009,
                              child: WTextB4(e.title))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CatalogueData {
  final String title, image;
  final Color color;
  final bool isNet;
  final Function onTap;
  final Widget onPressed;

  CatalogueData(
      {required this.title,
      required this.image,
      required this.color,
      this.isNet = true,
      required this.onTap,
      required this.onPressed});
}

List<CatalogueData> catalogueDataList = [
  CatalogueData(
      title: 'كتالوجات ألوان',
      image: 'color',
      color: Colors.pink,
      isNet: false,
      onPressed: Catalogues(),
      onTap: () {}),
  CatalogueData(
      title: 'كتالوجات ألوان',
      image: 'color',
      color: Colors.green,
      onPressed: Container(),
      onTap: () async {
        await launch(
            'https://drive.google.com/drive/folders/1YsM-aRUL2WeVkQ0CUS3hnLiP9gvzSwXK?usp=sharing');
      }),
  CatalogueData(
      title: 'كتالوجات قطاعات',
      image: 'profiles',
      color: Colors.blue,
      onPressed: Container(),
      onTap: () async {
        await launch(
            'https://drive.google.com/drive/folders/1RGE6KZeE9BSk6GHCwns9lHIVmtFNV-wy?usp=sharing');
      }),
  CatalogueData(
      title: 'كتالوجات صور',
      image: 'pic',
      color: Colors.purple,
      onPressed: RateUs(),
      onTap: () async {
        await launch(
            'https://drive.google.com/drive/folders/1hpqc0n-UZZ43Ls676GOmcJop1b6ey0Kv?usp=sharing');
      }),
];
