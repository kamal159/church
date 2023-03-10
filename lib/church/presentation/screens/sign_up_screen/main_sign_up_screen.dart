import 'package:chruch/church/presentation/screens/sign_up_screen/sign_up_second_screen.dart';
import 'package:chruch/core/global/components/components.dart';
import 'package:chruch/core/global/components/default_login_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import '../../../../core/global/theme/app_color/app_color_light.dart';
import '../../../../core/services/sevices_locator.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/icon_constance.dart';
import '../../controller/sign_up/sign_up_bloc.dart';
import '../../controller/sign_up/sign_up_event.dart';
import '../../controller/sign_up/sign_up_state.dart';
import 'components/birthday_component.dart';
import 'components/password_component.dart';
import 'components/pick_image_component.dart';
import 'components/select_father_component.dart';
import 'components/select_gender_component.dart';
import 'components/select_school_component.dart';
import 'components/servant_component.dart';

class MainSignUpScreen extends StatefulWidget {
  const MainSignUpScreen({Key? key}) : super(key: key);

  @override
  State<MainSignUpScreen> createState() => _MainSignUpScreenState();
}

class _MainSignUpScreenState extends State<MainSignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultSignupSignInScreen(
        content: Center(
      child: BlocProvider(
        create: (context) => sl<SignUpBloc>()..add(GetFatherEvent()),
        lazy: false,
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state.requestState == RequestState.success) {
              navigateTo(context, SignUpSecondScreen());
              state.copyWith(requestState: RequestState.waiting);
            } else if (state.requestState == RequestState.error) {
              toastShow(
                text: state.errorMessage.split('] ').last,
                state: ToastStates.error,
                translate: true,
              );
            }
          },
          listenWhen: (previous, current) =>
              previous.requestState != current.requestState,
          builder: (context, state) {
            SignUpBloc cubit = BlocProvider.of<SignUpBloc>(context);
            return WillPopScope(
              onWillPop: () async {
                return true;
              },
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: PickImageComponent(),
                    ),
                    customTextFormField(
                        context: context,
                        controller: nameController,
                        labelText: '?????????? ??????????????',
                        keyboardType: TextInputType.name,
                        validator: (val) {
                          if (!val!.isValidName()) return text('?????????? ??????????????');
                          return null;
                        },
                        prefixIcon: IconlyBroken.edit_square),
                    customTextFormField(
                        textDirection: TextDirection.ltr,
                        context: context,
                        controller: emailController,
                        labelText: '??????????????',
                        keyboardType: TextInputType.name,
                        validator: (val) {
                          if (!val!.isValidEmail()) {
                            return text('??????????????');
                          }
                          return null;
                        },
                        onChanged: (val) {},
                        prefixIcon: IconlyBroken.message),
                    customTextFormField(
                        textDirection: TextDirection.ltr,
                        context: context,
                        controller: phoneController,
                        labelText: '?????? ????????????',
                        keyboardType: TextInputType.phone,
                        validator: (val) {
                          if (!val!.isValidPhoneNumber()) {
                            return text('?????? ????????????');
                          }
                          return null;
                        },
                        prefixIcon: IconlyBroken.call),
                    SelectFatherComponent(),
                    const PasswordComponent(),
                    const BirthDayComponent(),
                    customTextFormField(
                        context: context,
                        controller: addressController,
                        labelText: '??????????????',
                        keyboardType: TextInputType.streetAddress,
                        validator: (val) {
                          if (val!.length < 5) {
                            return text('?????????????? ??????????????????');
                          }
                          return null;
                        },
                        prefixIcon: IconlyBroken.home),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '??????: ?????????????? ?????????? ?????????? ?????? ?????????? ???? ???? ???????? ???????? ???????? ?????????????? ???? ?????? ?????????? ?????? ?????? ??????...',
                              style: Theme.of(context).textTheme.labelLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                cubit.determinePosition().then((value) {
                                  showBanner(context,
                                      const Text('???? ?????????????? ??????????'), '????????');
                                }).catchError((e) {
                                  showBanner(
                                      context,
                                      const Text(
                                          '?????? ??????, ???????? ???????????????? ?????? ????????'),
                                      '????????');
                                });
                              },
                              child: const Text('???????? ?????? ??????????????')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: const SelectGenderComponent(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 0),
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white70,
                            border: Border.all(
                                width: 1, color: AppColorsLight.third)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const ServantComponent(),
                            Text('???? ?????? ???????? ??',
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),
                    ),
                    const SelectSchoolComponent(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: customButton(
                        context: context,
                        text: '????????????',
                        widget: state.requestState == RequestState.loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : null,
                        onTap: () {
                          if (_formKey.currentState!.validate() &&
                              SignUpBloc.isMale != null &&
                              SignUpBloc.formattedDate != null &&
                              state.position != null &&
                              SignUpBloc.image != null &&
                              ((state.fatherName == '????????' &&
                                      SignUpBloc.fatherName != '') ||
                                  state.fatherName != '????????')) {
                            cubit.add(
                              SignUpUserEvent(
                                level: !SignUpBloc.isServant
                                    ? SignUpBloc.selectLevel + 1
                                    : null,
                                position: state.position!,
                                isServant: SignUpBloc.isServant,
                                name: nameController.text,
                                school: !SignUpBloc.isServant
                                    ? SignUpBloc.schoolName
                                    : null,
                                email: emailController.text,
                                fatherName: SignUpBloc.fatherName!,
                                password: SignUpBloc.password!,
                                phone: phoneController.text,
                                date: SignUpBloc.formattedDate!,
                                isMale: SignUpBloc.isMale!,
                                img: SignUpBloc.image!,
                                address: addressController.text,
                                userPath: !SignUpBloc.isServant
                                    ? '${SignUpBloc.schoolName}/${SignUpBloc.selectLevel + 1}st'
                                    : 'servants/all',
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("???????? ???? ?????????? ??????????????"),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                )),
              ),
            );
          },
        ),
      ),
    ));
  }

  String text(text) => '?????????? ???????????? ???? $text';
}
