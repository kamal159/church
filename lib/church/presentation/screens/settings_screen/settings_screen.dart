import 'dart:io';

import 'package:chruch/church/presentation/screens/settings_screen/update_user_password_screen/update_user_password_screen.dart';
import 'package:chruch/church/presentation/screens/settings_screen/update_user_profile_image/update_user_profile_image_screen.dart';
import 'package:chruch/core/network/local/cache_helper.dart';
import 'package:chruch/core/utils/widget_constance.dart';
import 'package:path/path.dart';
import 'package:chruch/church/presentation/screens/get_started_screen/get_started_screen.dart';
import 'package:chruch/core/global/components/components.dart';
import 'package:chruch/core/utils/app_constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/global/theme/app_color/app_color_light.dart';
import '../../../../core/services/sevices_locator.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/user_constance.dart';
import '../../controller/settings/settings_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('hellllllllloooo');
    return SingleChildScrollView(
      child: BlocProvider(
        lazy: false,
        create: (context) => sl<SettingsBloc>(),
        child: BlocConsumer<SettingsBloc, SettingsState>(
          listener: (context, state) {
            // print(state.requestUserProfileImageState);
          },
          builder: (context, state) {
            SettingsBloc cubit = BlocProvider.of<SettingsBloc>(context);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      InkWell(
                        onTap: () {
                          navigateTo(context, const ViewImage());
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child:  Hero(
                          tag: 'img',
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width,
                            imageUrl: UserConstance.img,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: AppColorsLight.appBarBackground,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(2, 2),
                              blurRadius: 5,
                              spreadRadius: .1,
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            cubit.imagePicker().then((value) {
                              if (SettingsBloc.image != null) navigateTo(context, UpdateUserProfileImageScreen(pickedFile: SettingsBloc.image,));
                            });
                            },
                          icon: const Icon(IconlyBroken.image,
                              color: AppColorsLight.lightText),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  customButtonSettings(
                    context: context,
                    text: 'تعديل بياناتك',
                    onTap: () {},
                  ),
                  customButtonSettings(
                    context: context,
                    text: 'تعديل الباسورد',
                    onTap: () {
                      navigateTo(context, const UpdateUserPasswordScreen());
                    },
                  ),
                  customButtonSettings(
                    context: context,
                    text: 'حول التطبيق',
                    onTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 30),
                    child: customButton(
                        text: 'تسجيل الخروج',
                        context: context,
                        onTap: () async {
                            await CacheHelper.removeData(key: 'isUserDataSaved');
                            await CacheHelper.removeData(key: 'firstDB').then((value) {
                              UserConstance.isEmailVerified = false;
                              navigateTo(context, const GetStartedScreen(), until: false);
                            });
                        },
                        color: AppColorsLight.darkText),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  Widget customButtonSettings({context, text, onTap}) => customButton(
      fontSize: 20,
      context: context,
      text: text,
      onTap: onTap,
      color: AppColorsLight.backgroundButtonColor);
}


class ViewImage extends StatelessWidget {
  const ViewImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(UserConstance.name),),
      body: Center(
        child: Hero(
          tag: 'img',
          child: CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
            imageUrl: UserConstance.img,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
