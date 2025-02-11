import 'package:flutter/material.dart';
import 'package:fullapp/intro_screens/introPage1.dart';
import 'package:fullapp/intro_screens/introPage2.dart';
import 'package:fullapp/intro_screens/introPage3.dart';
import 'package:fullapp/screens/homePage.dart';
import 'package:fullapp/widgets/livePages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:fullapp/screens/LivesPage.dart';

class OnBoardingPage extends StatefulWidget {

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController _controller = PageController();

  //keep track of last page or not
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index){
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),

          Container(
            alignment: Alignment(0,0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return HomePage();
                    }));
                  },
                  child: Text('Skip'),
                ),

                buildIndicator(),

                onLastPage?
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return LivePages();
                    }));
                  },
                  child: Text('Done'),
                ):
                GestureDetector(
                  onTap: () {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                    },
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildIndicator() => SmoothPageIndicator(
    controller: _controller,
    count: 3,
    effect: WormEffect(
      activeDotColor: Colors.yellow.shade700,
    ),
  );
}