import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_constance.dart';
import '../../../generated/assets.dart';

class DefaultLoginSignupScreen extends StatelessWidget {
  final Widget content;

  const DefaultLoginSignupScreen({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          const Image(
              image: AssetImage(Assets.imagesBg), fit: BoxFit.fitHeight),
          Container(color: Colors.white.withOpacity(.1)),
          Container(color : const Color.fromRGBO(21, 18, 17, 0.1),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: content,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                15, AppConstanceScreenSize.topPadding(context) + 15, 0, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    color: Colors.grey,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
