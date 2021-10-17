import 'package:dar_sllah/classes/about_card_class.dart';
import 'package:dar_sllah/widgets/about_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutScreen extends StatelessWidget {
  final List<AboutCardClass> aboutList = [
    AboutCardClass("assets/images/moto_icon.png", "Home delivery",
        "We Deliver the best quality food at your doorsteps\nfor 7DT extra cost for each delivery past 60 DT"),
    AboutCardClass("assets/images/vegetable_icon.png", "Fresh Fodd",
        "Sadri goes to the Central Market of Tunis to select\nthe best products, the freshest, the seasonal"),
    AboutCardClass("assets/images/bag_food_icon.png", "48H Of Resistance ",
        "with our special packaging, you can save the food\nin your fridge for 48 hours and find as it is"),
  ];

  void customLunch(command) async{
    if(await canLaunch(command)){
      await launch(command);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
              width: double.infinity,
            ),
            SizedBox(
              height: 150,
              width: 250,
              child: Image.asset("assets/images/logo_green.png"),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 20,
                  width: 20,
                  child: Image.asset("assets/images/location_icon.png"),
                ),
                Text(
                  'Rue du Tamis, Tunis',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 15,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    customLunch('tel: 54330852');
                  },
                  child: Container(
                    width: 150,
                    height: 100,
                    child: Image.asset("assets/images/call_us_btn.png"),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 150,
                  height: 100,
                  child: Image.asset("assets/images/get_direction_btn.png"),
                ),
              ],
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              color: Colors.white,
              child: Container(
                width: double.infinity,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Opening Hours',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 15,
                        color: const Color(0xff3d3d3d),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 15,
                              color: const Color(0xff000000),
                            ),
                            children: [
                              TextSpan(
                                text: 'Monday-Saturday:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: ' 8:00AM–6:00PM',
                                style: TextStyle(
                                  color: const Color(0xfffbce01),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'Description',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 24,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'En plein cœur de la Médina de Tunis, à 150m de la Mosquée Zitouna, sur l’une des artères les plus riches et colorées des souks, la rue de la Kasbah, le restaurant « Dar Slah » vous accueille dans un cadre chaleureux et convivial pour vous faire voyager aux saveurs des goûts authentiques de la cuisine tunisienne',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 14,
                  color: const Color(0xffa2a2a2),
                  height: 2.857142857142857,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 150,
              width: 250,
              child: Image.asset("assets/images/Onboarding_Img02.png"),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Sadri Smoali',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 18,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w600,
                  height: 2.7222222222222223,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 308.0,
              child: Text(
                'vous pourrez goûter aux réjouissances gustatives des tables tunisiennes',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 15,
                  color: const Color(0xffa2a2a2),
                  height: 2.6666666666666665,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'Why Dar sllah',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 27,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 350,
                width: double.infinity,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: aboutList.length,
                  itemBuilder: (context, index) => AboutCardWidget(
                      aboutList[index].image,
                      aboutList[index].name,
                      aboutList[index].description),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
