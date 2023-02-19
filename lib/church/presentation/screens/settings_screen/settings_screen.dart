import 'package:chruch/core/utils/app_constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/sevices_locator.dart';
import '../../controller/settings/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(AppConstance.uId);
    return SingleChildScrollView(
      child: BlocProvider(
        create: (context) => sl<SettingsBloc>(),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     // cubit.imagePicker();
                    //   },
                    //   child: CircleAvatar(
                    //     radius: 75,
                    //     backgroundColor: AppColorsLight.third,
                    //     foregroundImage: SettingsBloc.image != null
                    //         ? FileImage(File(SettingsBloc.image!.path))
                    //         : null,
                    //     child: null == null
                    //         ? const Text('اضف صورة واضحة لوجهك',
                    //         textAlign: TextAlign.center)
                    //         : const CircularProgressIndicator(),
                    //   ),
                    // ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: Colors.white,
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
                          // cubit.imagePicker();
                        },
                        icon: const Icon(Icons.image_outlined),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}
