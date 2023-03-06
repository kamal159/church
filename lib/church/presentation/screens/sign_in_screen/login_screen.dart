import 'package:chruch/church/presentation/controller/sign_in/sign_in_event.dart';
import 'package:chruch/church/presentation/controller/sign_up/sign_up_bloc.dart';
import 'package:chruch/church/presentation/screens/sign_in_screen/failed_to_login_screen.dart';
import 'package:chruch/core/global/components/default_login_signup_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/global/components/components.dart';
import '../../../../core/global/theme/app_color/app_color_light.dart';
import '../../../../core/services/sevices_locator.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/user_constance.dart';
import '../../components/sign_in_components/sign_in_components.dart';
import '../../controller/sign_in/sign_in_bloc.dart';
import '../../controller/sign_in/sign_in_state.dart';
import '../layout_screen/layout_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return DefaultSignupSignInScreen(
      content: BlocProvider(
        create: (context) => sl<SignInBloc>(),
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) async {
            if (state.requestState == RequestState.success) {
              if (state.isEmailVerified) {
                navigateTo(context, const LayoutScreen(), until: false);
              } else {
                navigateTo(context, const FailedToLoginScreen());
              }
            }
          },
          listenWhen: (previous, current) =>
              previous.requestState != current.requestState,
          builder: (context, state) {
            var cubit = BlocProvider.of<SignInBloc>(context);
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  customTextFormField(
                    textDirection: TextDirection.ltr,
                    context: context,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'الايميل',
                    prefixIcon: IconlyBroken.profile,
                    validator: (val) {
                      if (!val!.isValidEmail()) {
                        return 'من فضلك ادخل الايميل بطريقة صحيحية';
                      }
                      return null;
                    },
                  ),
                  customTextFormField(
                    textDirection: TextDirection.ltr,
                    context: context,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: 'الباسورد',
                    prefixIcon: IconlyBroken.password,
                    validator: (val) {
                      if (val == null || val.isEmpty || val.length < 6) {
                        return text('الباسورد مكون من 6 رموز علي الاقل');
                      }
                      return null;
                    },
                    onFieldSubmitted: (val) {
                      _formKey.currentState!.validate();
                    },
                    suffixIcon: state.visible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    obscureText: !state.visible,
                    suffixIconOnPressed: () {
                      cubit.changeVisiblePassword();
                    },
                  ),
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: 170,
                      height: 33,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColorsLight.primary.withOpacity(.7),
                              border: Border.all(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                width: 1,
                              ),
                            ),
                          ),
                          Text(
                            'نسيت كلمة السر',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  customButton(
                    widget: state.requestState == RequestState.loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : null,
                    context: context,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.add(SignInUserEvent(
                            email: emailController.text,
                            password: passwordController.text));
                      }
                    },
                    text: 'تسجيل الدخول',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String text(String text) => 'برجاء ادخال $text';
}
