import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/intro_screens/introPage1.dart';
import 'package:fullapp/intro_screens/introPage2.dart';
import 'package:fullapp/intro_screens/introPage3.dart';
import 'package:fullapp/intro_screens/introPage4.dart';
import 'package:fullapp/screens/homePage.dart';
import 'package:fullapp/widgets/livePages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:fullapp/screens/LivesPage.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController _controller = PageController();
  bool onLastPage = false;
  int currentPage = 0;
  double _opacity = 1.0; // Controls fade-out effect

  void _fadeAndNavigate() {
    setState(() {
      _opacity = 0.0; // Start fade-out animation
    });

    Future.delayed(Duration(milliseconds: 800), () {
      Navigator.of(context).pushReplacement(_fadeRoute(LivePages())); // Transition after fade-out
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOut,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          leading: currentPage > 0
              ? IconButton(
                  onPressed: () {
                    _controller.previousPage(
                      duration: Duration(milliseconds: 700),
                      curve: Curves.easeOut,
                    );
                  },
                  icon: Icon(
                    CupertinoIcons.back,
                    size: 30,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                )
              : null,
        ),
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              physics: PageScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                  onLastPage = (index == 3);
                });
              },
              children: [
                IntroPage1(),
                IntroPage2(),
                IntroPage3(),
                IntroPage4(),
              ],
            ),
            Container(
              alignment: Alignment(-0.77, 0.265),
              child: buildIndicator(),
            ),
            Container(
              padding: EdgeInsets.only(left: 43, right: 43, top: 10),
              alignment: Alignment(0, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _fadeAndNavigate,
                    child: Text(
                      'Skip',
                      style: GoogleFonts.interTight(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                  onLastPage
                      ? GestureDetector(
                          onTap: _fadeAndNavigate,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.0115,
                              horizontal: screenHeight * 0.0345,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiary,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'Done',
                              style: GoogleFonts.interTight(
                                color: Theme.of(context).colorScheme.background,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 700),
                              curve: Curves.easeOut,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: screenHeight * 0.012,
                              bottom: screenHeight * 0.012,
                              left: screenHeight * 0.025,
                              right: screenHeight * 0.011,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiary,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Next',
                                  style: GoogleFonts.interTight(
                                    color: Theme.of(context).colorScheme.background,
                                  ),
                                ),
                                SizedBox(width: 14),
                                Icon(
                                  CupertinoIcons.forward,
                                  color: Theme.of(context).colorScheme.background,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => SmoothPageIndicator(
        controller: _controller,
        count: 4,
        effect: WormEffect(
          dotHeight: 8.5,
          dotWidth: 8.5,
          activeDotColor: Theme.of(context).colorScheme.tertiary,
          dotColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.grey.shade300,
        ),
      );
}

// ✅ Fade transition route
PageRouteBuilder _fadeRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 800),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}