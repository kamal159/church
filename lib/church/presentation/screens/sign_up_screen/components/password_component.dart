import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/global/components/components.dart';
import '../../../controller/sign_up/sign_up_bloc.dart';
import '../../../controller/sign_up/sign_up_state.dart';

class PasswordComponent extends StatelessWidget {

  const PasswordComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();

    final TextEditingController passwordAgainController = TextEditingController();

    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.visible != current.visible,
      builder: (context, state) {
        var cubit = BlocProvider.of<SignUpBloc>(context);
        return Column(
          children: [
            customTextFormField(
              textDirection: TextDirection.ltr,
              context: context,
              controller: passwordController,
              labelText: 'الباسورد',
              keyboardType: TextInputType.visiblePassword,
              validator: (val) {
                if (val == null || val.isEmpty || val.length < 6) return text('الباسورد مكون من 6 رموز علي الاقل');
                return null;
              },
              onChanged: (val) {
                SignUpBloc.password = passwordController.text;
              },
              prefixIcon: Icons.password_outlined,
              suffixIcon:
                  state.visible ? Icons.visibility_off : Icons.visibility,
              suffixIconOnPressed: () {
                cubit.changeVisiblePassword();
              },
              obscureText: !state.visible,
            ),
            customTextFormField(
              textDirection: TextDirection.ltr,
              context: context,
              controller: passwordAgainController,
              labelText: 'الباسورد مرة اخرى',
              keyboardType: TextInputType.visiblePassword,
              validator: (val) {
                if (passwordController.text != passwordAgainController.text){
                  return 'الباسورد الذي ادخلته غير مطابق';
                }
                return null;
              },
              prefixIcon: Icons.password_outlined,
              suffixIcon:
                  state.visible ? Icons.visibility_off : Icons.visibility,
              suffixIconOnPressed: () {
                cubit.changeVisiblePassword();
              },
              obscureText: !state.visible,

            ),
          ],
        );
      },
    );
  }

  String text(String text) => 'برجاء ادخال $text';
}
