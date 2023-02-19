import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chruch/church/presentation/screens/get_started_screen/get_started_screen.dart';
import 'package:chruch/church/presentation/screens/layout_screen/layout_screen.dart';
import 'package:chruch/core/global/theme/app_color/app_color_light.dart';
import 'package:chruch/core/utils/app_constance.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/global/components/components.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../generated/assets.dart';
import '../sign_in_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      if (_controller.value >= 0.4) {
        navigateTo(
            context,
            AppConstance.uId == null
                ? const GetStartedScreen()
                : const LayoutScreen());
        _controller.reverse();
      }
      if (!_controller.isAnimating) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Lottie.asset(
                height: 140,
                controller: _controller,
                Assets.lottieChurchSplash,
                onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..forward();
                },
              ),
            ),
            const SizedBox(height: 20),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 30.0,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(AppString.appName,
                      textStyle: Theme.of(context).textTheme.headlineMedium,
                      speed: Duration(milliseconds: 180)),
                ],
              ),
            ),
            // Text(
            //   AppString.appName,
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.all(30.0),
            //     child:  AppConstance.circularProgressIndicator,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
