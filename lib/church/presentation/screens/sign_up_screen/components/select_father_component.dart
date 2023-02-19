import 'package:chruch/church/presentation/controller/sign_up/sign_up_bloc.dart';
import 'package:chruch/church/presentation/controller/sign_up/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/global/components/components.dart';
import '../../../../../core/global/theme/app_color/app_color_light.dart';
import '../../../controller/sign_up/sign_up_state.dart';

class SelectFatherComponent extends StatelessWidget {
  SelectFatherComponent({Key? key}) : super(key: key);
  final TextEditingController fatherOfConfessionController =
      TextEditingController(text: SignUpBloc.fatherName);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          previous.fatherName != current.fatherName ||
          previous.fathers != current.fathers,
      builder: (context, state) {
        SignUpBloc cubit = BlocProvider.of<SignUpBloc>(context);
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70,
                  border: Border.all(width: 1, color: AppColorsLight.third)),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('اختر اب الاعتراف',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: const Color(0xff7A716E),
                          )),
                  DropdownButton(
                    alignment: Alignment.center,
                    dropdownColor: Colors.white,
                    focusColor: AppColorsLight.third,
                    items: state.fathers
                        .map((e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (String? val) {
                      cubit.changeFatherName(val!);
                    },
                    value: state.fatherName,
                    iconEnabledColor: AppColorsLight.third,
                    iconSize: 30,
                    // isExpanded: true,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  Text('القمص', style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
            if (state.fatherName == 'اخرى')
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
                onChanged: (val) {
                  SignUpBloc.fatherName = val;
                },
                prefixIcon: Icons.person_outline,
              ),
          ],
        );
      },
    );
  }
  String text(text) => 'برجاء التاكد من $text';

}
