import 'package:chruch/church/presentation/controller/sign_up/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/sign_up/sign_up_state.dart';

class SelectGenderComponent extends StatelessWidget {
  const SelectGenderComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      // buildWhen: (previous, current) => previous.,
      builder: (context, state) {
        var cubit = BlocProvider.of<SignUpBloc>(context);

        return ToggleButtons(
          borderRadius: BorderRadius.circular(10),
          fillColor: Colors.green,
          selectedColor: Colors.white,
          isSelected: SignUpBloc.genderSelections,
          onPressed: (index) {
            cubit.changeGender(index);
          },
          children: [
            customItemToggle('انثي', Icons.female),
            customItemToggle('ذكر', Icons.male),
          ],
        );
      },
    );
  }

  Widget customItemToggle(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
      child: Row(
        children: [
          Text(text),
          const SizedBox(width: 5),
          Icon(icon),
        ],
      ),
    );
  }
}
