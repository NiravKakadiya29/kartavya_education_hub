import '/const/consts.dart';
import '/view/Login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'intro_screens/intro_page.dart';
import 'intro_screens/intro_page_2.dart';
import 'intro_screens/intro_page_3.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

PageController _controller = PageController();

class _IntroPageState extends State<IntroPage> {
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //page view
          PageView(
            controller: _controller,
            onPageChanged: (index) {
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
          //dot indicator
          Container(
            alignment: Alignment(0, 0.90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // skip
                'skip'.text.size(20).make().onTap(() {
                  _controller.jumpToPage(2);
                }),

                //dot indicator
                SmoothPageIndicator(controller: _controller, count: 3),

                // next or done
                onLastPage
                    ? 'done'.text.size(20).make().onTap(
                        () {
                          Get.to(Login());
                        },
                      )
                    : 'next'.text.size(20).make().onTap(
                        () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
