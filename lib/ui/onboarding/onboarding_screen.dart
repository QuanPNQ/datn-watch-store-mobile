import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/images.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/models.dart';
import 'package:flutter_mob/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<WalkThrough> listWalkThrough = Constants.listWalkThroughDefault;
  final PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  SharedPrefManager sharedPrefManager = SharedPrefManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            children: listWalkThrough.map((e) {
              return Stack(
                children: [
                  Image.asset(
                    e.imagePath,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.contain,
                  ),
                  Image.asset(
                    AppImages.imgBlurBackground,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill,
                  ),
                ],
              );
            }).toList(),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height: 44,
                          alignment: Alignment.center,
                          child: currentIndex != (listWalkThrough.length - 1)
                              ? GestureDetector(
                                  onTap: handleClickSkip,
                                  child: TextNormal(title: StringName.skip))
                              : null)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextNormal(
                    title: listWalkThrough[currentIndex].title,
                    size: 24,
                    lineHeight: 1.3,
                    fontName: AppThemes.dmSerifDisplay,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextNormal(
                    title: listWalkThrough[currentIndex].content,
                    size: 14,
                    lineHeight: 1.3,
                  ),
                  const Spacer(),
                  ButtonNormal(
                    text: currentIndex != (listWalkThrough.length - 1)
                        ? StringName.next
                        : StringName.getStarted,
                    onPressed: handleClickButton,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  handleClickButton() {
    if (currentIndex != (listWalkThrough.length - 1)) {
      pageController.animateToPage(currentIndex + 1,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
      return;
    }

    sharedPrefManager.putBool(SharedPrefManager.isCompleteWalkThrough, true);
    Navigator.pushReplacementNamed(context, Constants.loginScreen);
  }

  handleClickSkip() {
    sharedPrefManager.putBool(SharedPrefManager.isCompleteWalkThrough, true);
    Navigator.pushReplacementNamed(context, Constants.loginScreen);
  }
}
