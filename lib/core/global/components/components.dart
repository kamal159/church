import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:translator/translator.dart';

import '../theme/app_color/app_color_light.dart';

void navigateTo(BuildContext context, Widget screen, {bool until = true}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => until);
}

Widget customButton({
  required BuildContext context,
  required String text,
  Widget? widget,
  required void Function()? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
    child: InkWell(
      onTap: onTap,
      child: Container(
          height: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColorsLight.primary),
          child: Center(
              child: widget ??
                  Text(text,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white)))),
    ),
  );
}

Widget customTextFormField({
  required BuildContext context,
  required controller,
  required labelText,
  void Function(String val)? onFieldSubmitted,
  void Function(String val)? onChanged,
  required TextInputType keyboardType,
  required String? Function(String? val) validator,
  required IconData prefixIcon,
  IconData? suffixIcon,
  void Function()? suffixIconOnPressed,
  TextDirection textDirection = TextDirection.rtl,
  TextInputAction textInputAction = TextInputAction.next,
  bool obscureText = false,
  Function()? onTap,
  readOnly = false,
}) {
  return Theme(
    data: ThemeData().copyWith(
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: AppColorsLight.third,
          ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 0),
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        readOnly: readOnly,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        textDirection: textDirection,
        decoration: InputDecoration(
          errorStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.red[900],
                fontWeight: FontWeight.bold,
              ),
          filled: true,
          fillColor: Colors.white70,
          contentPadding: const EdgeInsets.all(10),
          labelText: labelText,
          labelStyle: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: const Color(0xff7A716E)),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon == null
              ? null
              : IconButton(
                  onPressed: suffixIconOnPressed,
                  icon: Icon(suffixIcon),
                ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColorsLight.third, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColorsLight.third, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColorsLight.third, width: 1),
          ),
        ),
      ),
    ),
  );
}

Future<bool?> toastShow({
  required String text,
  bool translate = false,
  required ToastStates state,
}) async {
  Translation? translation;
  if (translate) {
    translation = await GoogleTranslator().translate(text, to: 'ar');
  }

  return Fluttertoast.showToast(
      msg: translate ? translation!.text : text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { success, error, warning }

chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
