import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/global/theme/app_color/app_color_light.dart';
import '../../../controller/sign_up/sign_up_bloc.dart';
import '../../../controller/sign_up/sign_up_state.dart';

class PickImageComponent extends StatelessWidget {
  const PickImageComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        var cubit = BlocProvider.of<SignUpBloc>(context);
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            InkWell(
              onTap: () {
                cubit.imagePicker();
              },
              child: CircleAvatar(
                radius: 75,
                backgroundColor: AppColorsLight.third,
                foregroundImage: SignUpBloc.image != null
                    ? FileImage(File(SignUpBloc.image!.path))
                    : null,
                child: SignUpBloc.image == null
                    ? const Text('اضف صورة واضحة لوجهك',
                        textAlign: TextAlign.center)
                    : const CircularProgressIndicator(),
              ),
            ),
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
                  cubit.imagePicker();
                },
                icon: const Icon(Icons.image_outlined),
              ),
            ),
          ],
        );
      },
    );
  }
}
