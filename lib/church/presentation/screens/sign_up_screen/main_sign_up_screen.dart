import 'dart:io';

import 'package:chruch/church/presentation/screens/sign_up_screen/sign_up_second_screen.dart';
import 'package:chruch/core/global/components/components.dart';
import 'package:chruch/core/global/components/default_login_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/global/theme/app_color/app_color_light.dart';
import '../../../../core/services/sevices_locator.dart';
import '../../../../core/utils/enums.dart';
import '../../controller/sign_up/sign_up_bloc.dart';
import '../../controller/sign_up/sign_up_event.dart';
import '../../controller/sign_up/sign_up_state.dart';
import 'components/password_component.dart';
import 'components/pick_image_component.dart';
import 'components/select_gender_component.dart';
import 'components/select_school_component.dart';
import 'components/servant_component.dart';
import 'package:geolocator/geolocator.dart';

class MainSignUpScreen extends StatefulWidget {
  const MainSignUpScreen({Key? key}) : super(key: key);

  @override
  State<MainSignUpScreen> createState() => _MainSignUpScreenState();
}

class _MainSignUpScreenState extends State<MainSignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController fatherOfConfessionController =
      TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController dateInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultLoginSignupScreen(
        content: Center(
      child: BlocProvider(
        create: (context) => sl<SignUpBloc>(),
        lazy: true,
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state.requestState == RequestState.success) {
              navigateTo(context, SignUpSecondScreen());
            }
          },
          listenWhen: (previous, current) =>
              previous.requestState != current.requestState,
          buildWhen: (previous, current) =>
              previous.requestState != current.requestState,
          builder: (context, state) {
            var cubit = BlocProvider.of<SignUpBloc>(context);
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  const PickImageComponent(),
                  const SizedBox(height: 20),
                  customTextFormField(
                      context: context,
                      controller: nameController,
                      labelText: 'الاسم بالكامل',
                      keyboardType: TextInputType.name,
                      validator: (val) {
                        if (!val!.isValidName()) return text('الاسم بالكامل');
                        return null;
                      },
                      prefixIcon: Icons.edit_outlined),
                  customTextFormField(
                      context: context,
                      controller: emailController,
                      labelText: 'الايميل',
                      keyboardType: TextInputType.name,
                      validator: (val) {
                        if (!val!.isValidEmail()) {
                          return text('الايميل');
                        }
                        return null;
                      },
                      onChanged: (val) {},
                      prefixIcon: Icons.mail_outline),
                  customTextFormField(
                      context: context,
                      controller: phoneController,
                      labelText: 'رقم الهاتف',
                      keyboardType: TextInputType.phone,
                      validator: (val) {
                        if (!val!.isValidPhoneNumber()) {
                          return text('رقم الهاتف');
                        }
                        return null;
                      },
                      prefixIcon: Icons.phone_outlined),
                  customTextFormField(
                    context: context,
                    controller: fatherOfConfessionController,
                    labelText: 'اسم اب الاعتراف',
                    keyboardType: TextInputType.name,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return text('اسم اب الاعتراف');
                      }

                      return null;
                    },
                    prefixIcon: Icons.person_outline,
                  ),
                  PasswordComponent(),
                  customTextFormField(
                    context: context,
                    controller: dateInputController,
                    labelText: 'تاريخ الميلاد',
                    keyboardType: TextInputType.datetime,
                    readOnly: true,
                    validator: (val) {
                      if (val!.isEmpty) return text('تاريخ الميلاد');
                      return null;
                    },
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        cancelText: 'الغاء',
                        confirmText: 'تم',
                        firstDate: DateTime(int.parse(
                                DateFormat('yyyy').format(DateTime.now())) -
                            120),
                        initialDate: DateTime.now(),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        SignUpBloc.formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        dateInputController.text = SignUpBloc.formattedDate!;
                      }
                    },
                    prefixIcon: Icons.date_range_outlined,
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
                          Text('هل انت خادم ؟',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ),
                  ),
                  const SelectSchoolComponent(),
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
                            'هام: يساعدنا تسجيل موقعك علي معرفة من هو اقرب خادم اليك ليفتدقك في حال غيابك وما الي ذلك...',
                            style: Theme.of(context).textTheme.labelLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              showBanner(context,
                                  const Text('تم التسجيل بنجاح'), 'اعلم');

                              // _determinePosition(context);
                            },
                            child: const Text('اضغط هنا للتسجيل')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Builder(
                      builder: (context) {
                        if (state.requestState == RequestState.loading) {
                          return customButton(
                            context: context,
                            text: '',
                            widget: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            onTap: () {},
                          );
                        }
                        return submitButton(cubit);
                      },
                    ),
                  ),
                ],
              )),
            );
          },
        ),
      ),
    ));
  }

  Widget submitButton(cubit) => customButton(
        context: context,
        text: 'التالي',
        onTap: () {
          if (checkFormValidation() &&
              (!SignUpBloc.isServant &&
                      (SignUpBloc.lastExpandedGrade > 3 &&
                          SignUpBloc.lastSelectSchool == -1) ||
                  !SignUpBloc.isServant &&
                      (SignUpBloc.lastExpandedGrade != -1 &&
                          SignUpBloc.lastSelectSchool != -1) ||
                  SignUpBloc.isServant) &&
              SignUpBloc.isMale != null &&
              SignUpBloc.formattedDate != null &&
              SignUpBloc.position != null) {
            cubit.add(
              SignUpUserEvent(
                isServant: SignUpBloc.isServant,
                name: nameController.text,
                school: !SignUpBloc.isServant
                    ? SignUpBloc.lastSelectSchool == -1
                        ? SignUpBloc
                            .schoolGradeModel[SignUpBloc.lastExpandedGrade]
                            .nameGrade
                        : "${SignUpBloc.schoolGradeModel[SignUpBloc.lastExpandedGrade].nameGrade} الصف ${SignUpBloc.levelGrades[SignUpBloc.lastSelectSchool]}"
                    : null,
                email: emailController.text,
                fatherName: fatherOfConfessionController.text,
                password: SignUpBloc.password!,
                phone: phoneController.text,
                date: SignUpBloc.formattedDate!,
                gender: SignUpBloc.isMale! ? "male" : "female",
              ),
            );
            // navigateTo(context, screen),
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("تاكد من ادخال بياناتك"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
      );

  String text(text) => 'برجاء التاكد من $text';

  bool checkFormValidation() {
    return _formKey.currentState!.validate();
  }
// Future<void> customBottomSheet(context) {
//   return showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     elevation: 0,
//     builder: (context) {
//       return DraggableScrollableSheet(
//         initialChildSize: .65,
//         minChildSize: .65,
//         builder: (_, controller) {
//           return StatefulBuilder(
//             builder: (context, setState) {
//               return Container(
//                 decoration: const BoxDecoration(
//                   borderRadius:
//                   BorderRadius.vertical(top: Radius.circular(30)),
//                   color: AppColorsLight.third,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 30),
//                   child: ListView(
//                     controller: controller,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 30),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             ElevatedButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 child: const Text('تم')),
//                             Text(
//                               'المرحلة التعليمية',
//                               style: Theme
//                                   .of(context)
//                                   .textTheme
//                                   .titleMedium
//                                   ?.copyWith(color: Colors.white),
//                             )
//                           ],
//                         ),
//                       ),
//                       Container(
//                         color: Colors.white12,
//                         child: ToggleButtons(
//                           direction: Axis.vertical,
//                           fillColor: Colors.green,
//                           color: Colors.white,
//                           selectedColor: Colors.white,
//                           onPressed: (index) {
//                             if (lastSelectSchool == -1) {
//                               lastSelectSchool = index;
//                               _schoolSelections[index] = true;
//                             } else if (index != lastSelectSchool) {
//                               _schoolSelections[lastSelectSchool] = false;
//                               lastSelectSchool = index;
//                               _schoolSelections[index] = true;
//                             }
//                             print(_schoolSelections[index]);
//                             setState(() {});
//                           },
//                           isSelected: _schoolSelections,
//                           children: schoolGrades.keys
//                               .map((e) => Text('ال$e'))
//                               .toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );-
//         },
//       );
//     },
//   );
// }
}

Future<void> _determinePosition(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(content: Text(''), actions: TextButton(onPressed: (){}, child: Text('data'),)));
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  SignUpBloc.position = await Geolocator.getCurrentPosition();
  if (SignUpBloc.position != null) {
    showBanner(context, const Text('تم التسجيل بنجاح'), 'اعلم');

    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
      content: const Text('تم التسجيل بنجاح'),
      actions: [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
          child: const Text('اعلم'),
        ),
      ],
      backgroundColor: AppColorsLight.lightText,
      elevation: 5,
      contentTextStyle: Theme.of(context).textTheme.titleMedium,
    ));
  } else {
    showBanner(context, const Text('حدث خطأ, يرجي المحاولة مرة أخرى'), 'حسنا');
  }
}

Future<void> showBanner(
    BuildContext context, Widget content, String text) async {
  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      content: content,
      actions: [
        TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text(text, style: Theme.of(context).textTheme.titleMedium))
      ],
      backgroundColor: AppColorsLight.primary,
      elevation: 5,
      contentTextStyle: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: Colors.white),
    ),
  );
  await Future.delayed(const Duration(seconds: 2));
  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
}
