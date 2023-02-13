import 'package:chruch/core/global/components/components.dart';
import 'package:chruch/core/global/components/default_login_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpSecondScreen extends StatelessWidget {
  SignUpSecondScreen({Key? key}) : super(key: key);
  final TextEditingController dateInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultLoginSignupScreen(
      content: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white70,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('تم تسجيل ايميلك بنجاح', style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Color(0xff00AC26),
                ),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.check_circle_outline, color: Color(0xff00AC26),),
                ),
                Text("""أنتظر طلب قبولك للخدمة من 
(الخادم - أمين الخدمة - الأب الكاهن)
وأعد محاولة “تسجيل الدخول”""", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Color(0xff521213),
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
