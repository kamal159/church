import 'package:chruch/core/global/components/default_login_signup_screen.dart';
import 'package:flutter/material.dart';

class SignUpSecondScreen extends StatelessWidget {
  SignUpSecondScreen({Key? key}) : super(key: key);
  final TextEditingController dateInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultSignupSignInScreen(
      content: Center(
        child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white70,
          ),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('تم تسجيل ايميلك بنجاح',textAlign: TextAlign.center,  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: const Color(0xff00AC26),
                ),),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.check_circle_outline, color: Color(0xff00AC26),),
                ),
                Text("""أنتظر طلب قبولك للخدمة من 
(الخادم - أمين الخدمة - الأب الكاهن)
وأعد محاولة “تسجيل الدخول”""", textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: const Color(0xff521213),
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
