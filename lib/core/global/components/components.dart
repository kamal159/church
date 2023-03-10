import 'package:chruch/core/utils/widget_constance.dart';
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
  Color color = AppColorsLight.primary,
  double? fontSize,
  required String text,
  Widget? widget,
  bool isLoading = false,
  required void Function()? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
    child: InkWell(
      onTap: onTap,
      child: Container(
          height: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: color),
          child: !isLoading
              ? Center(
                  child: widget ??
                      Text(text,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Colors.white, fontSize: fontSize)))
              : Center(
                  child: WidgetConstance.circularProgressIndicator,
                )),
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
  const Map<ToastStates, MaterialColor> toastColors = {
    ToastStates.success: Colors.green,
    ToastStates.warning: Colors.amber,
    ToastStates.error: Colors.red,
  };
  return toastColors[state];
}

void showBanner(BuildContext context, Widget content, String text) {
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
  Future.delayed(const Duration(seconds: 2)).then((value) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  });
}

// dropDB() async {
//   final Database db =
//       await openDatabase(join(await getDatabasesPath(), 'church.db'));
//   await db.execute('DROP TABLE IF EXISTS user_data');
//   await db.close();
//   print('DONE DROP TABLE');
// }
//
// deleteDB() async {
//   final databasePath = join(await getDatabasesPath(), 'church.db');
//   await deleteDatabase(databasePath);
// }
//
// Future<void> createTableUserDataBase() async {
//   final Database db = await openDatabase(
//       join(await getDatabasesPath(), 'church.db'),
//       version: 1);
//   await db.execute('''
//           CREATE TABLE user_data (
//             uid TEXT PRIMARY KEY,
//             name TEXT,
//             img TEXT,
//             cover TEXT,
//             email TEXT,
//             phone TEXT,
//             fatherName TEXT,
//             date TEXT,
//             bio TEXT,
//             isMale INTEGER,
//             school TEXT,
//             isEmailVerified INTEGER,
//             isServant INTEGER,
//             subscribe TEXT,
//             isAdmin INTEGER,
//             latitude REAL,
//             longitude REAL,
//             address TEXT,
//             userPath TEXT,
//             password TEXT)
//           ''').catchError((e) {});
//   await db.close();
// }
//
// Future<void> insertUserDataBase(VerifiedUserModel verifiedUserModel) async {
//   final bool createDB = CacheHelper.getData(key: 'firstDB') ?? true;
//   if (createDB) {
//     await createTableUserDataBase();
//     await CacheHelper.saveData(key: 'firstDB', value: false);
//     print('done create table db');
//   }
//   print('now in the insert function');
//   final Database db = await openDatabase(
//       join(await getDatabasesPath(), 'church.db'),
//       version: 1);
//   await db.insert('user_data', verifiedUserModel.toDB());
//   await db.close();
//   await CacheHelper.saveData(key: 'isUserDataSaved', value: true);
//   print('done inserted user data');
// }
//
// Future<void> getUserDB() async {
//   final Database db = await openDatabase(
//       join(await getDatabasesPath(), 'church.db'),
//       version: 1);
//   final List<Map<String, Object?>> data = await db.query('user_data');
//   await db.close();
//   final VerifiedUserModel verifiedUserModel = VerifiedUserModel.fromDB(data[0]);
//   UserConstance.uid = verifiedUserModel.uid!;
//   UserConstance.img = verifiedUserModel.img;
//   UserConstance.cover = verifiedUserModel.cover ?? '';
//   UserConstance.name = verifiedUserModel.name;
//   UserConstance.email = verifiedUserModel.email;
//   UserConstance.phone = verifiedUserModel.phone;
//   UserConstance.password = verifiedUserModel.password;
//   UserConstance.fatherName = verifiedUserModel.fatherName;
//   UserConstance.date = verifiedUserModel.date;
//   UserConstance.bio = verifiedUserModel.bio ?? '';
//   UserConstance.isMale = verifiedUserModel.isMale;
//   UserConstance.school = verifiedUserModel.school ?? '';
//   UserConstance.level = verifiedUserModel.level ?? '';
//   UserConstance.isEmailVerified = verifiedUserModel.isEmailVerified;
//   UserConstance.isServant = verifiedUserModel.isServant;
//   UserConstance.subscribe = verifiedUserModel.subscribe ?? [];
//   UserConstance.isAdmin = verifiedUserModel.isAdmin;
//   UserConstance.position = verifiedUserModel.position;
//   UserConstance.address = verifiedUserModel.address;
// }
