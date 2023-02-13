import 'package:chruch/core/global/components/default_login_signup_screen.dart';
import 'package:chruch/core/global/components/components.dart';
import 'package:flutter/material.dart';

class FailedToLoginScreen extends StatelessWidget {
  const FailedToLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLoginSignupScreen(
      content: Column(
        children: [
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white70,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'لم يتم قبولك بعد ☹️'
                '\n'
                'يرجى الذهاب لـ'
                '\n\n'
                '(الخادم - أمين الخدمة - الأب الكاهن)',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          const Spacer(),
          customButton(
            context: context,
            text: 'رجوع',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
