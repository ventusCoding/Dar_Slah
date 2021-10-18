import 'package:dar_sllah/classes/OnBoarding.dart';
import 'package:dar_sllah/widgets/OnBoarding/Dot.dart';
import 'package:dar_sllah/widgets/OnBoarding/OnBoarding_Widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../Login.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentIndex = 0;
  PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<OnBoarding> onBoardingContents = [
    OnBoarding(
        "Saveurs\n& Passions",
        "Discover Tunisian culture through other\nperspective\nby exploring the known ",
        "assets/images/Onboarding_Img01.png"),
    OnBoarding(
        "Fraîcheur &\nOriginalité",
        "Discover Tunisian culture through other\nperspective\nby exploring the known ",
        "assets/images/Onboarding_Img02.png"),
    OnBoarding(
        "LA BOX DE\nDAR SLAH",
        "Discover Tunisian culture through other\nperspective\nby exploring the known ",
        "assets/images/Onboarding_Img03.png"),
    OnBoarding(
        "Votre cuisine\nfamiliale",
        "Discover Tunisian culture through other\nperspective\nby exploring the known ",
        "assets/images/Onboarding_Img04.png"),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: MediaQuery.of(context).size.height > 1000 ? 10 : 17,
          child: PageView.builder(
              controller: _controller,
              itemCount: onBoardingContents.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return OnBoardingWidget(
                  onBoardingContents[i].title,
                  onBoardingContents[i].description,
                  onBoardingContents[i].images,
                );
              }),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 8.5,
          child: RaisedButton(
            onPressed: () {
              if (_currentIndex == onBoardingContents.length - 1) {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              }

              _controller.nextPage(
                duration: Duration(milliseconds: 100),
                curve: Curves.bounceIn,
              );
            },
            child: Text(
              _currentIndex == onBoardingContents.length - 1 ? 'Start' : 'Next',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 21.5,
              ),
            ),
            textColor: Theme.of(context).backgroundColor,
            elevation: 0,
            highlightElevation: 0,
          ),
        ),
        Dot(_currentIndex, onBoardingContents.length),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.bottomRight,
            child: _currentIndex < onBoardingContents.length - 1
                ? GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width / 30,color: Theme.of(context).primaryColor),
                    ),
                  )
                : SizedBox(),
          ),
        ),
      ],
    ));
  }
}
