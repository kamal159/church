import 'package:chruch/church/presentation/screens/sign_up_screen/main_sign_up_screen.dart';
import 'package:chruch/core/global/components/components.dart';
import 'package:chruch/core/global/theme/app_color/app_color_light.dart';
import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';
import '../sign_in_screen/login_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          const Image(
              image: AssetImage(Assets.imagesBg), fit: BoxFit.fitHeight),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40)),
                    color: AppColorsLight.secondary,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            customButton(context:context, text: 'تسجيل الدخول', onTap: () {
                              navigateTo(context, SignInScreen());
                            }),
                            const SizedBox(height: 15),
                            customButton(context: context,text:  'مستخدم جديد',onTap:  () {
                              navigateTo(context, const MainSignUpScreen());
                            }),
                          ],
                        ),
                      )))),
          Positioned(
              top: 40,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: const Color(0xffF4F1EF)),
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('مطرانية شبين القناطر وتوابعها - الخصوص',
                          style: Theme.of(context).textTheme.labelLarge)))),
        ],
      ),
    );
  }


}
