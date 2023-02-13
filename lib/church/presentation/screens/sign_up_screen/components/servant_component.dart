import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/sign_up/sign_up_bloc.dart';
import '../../../controller/sign_up/sign_up_state.dart';

class ServantComponent extends StatelessWidget {
  const ServantComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.isServant != current.isServant,
      builder: (context, state) {
        var cubit = BlocProvider.of<SignUpBloc>(context);
        return ToggleButtons(
          onPressed: (val) {
            cubit.changeIsServant(val == 0 ? true : false);
          },
          fillColor: Colors.green,
          selectedColor: Colors.white,
          disabledColor: Colors.brown,
          borderRadius: BorderRadius.circular(10),
          isSelected: [
            state.isServant,
            !state.isServant,
          ],
          children: [
            customText(
                text: 'نعم',
                context: context,
                color: state.isServant ? Colors.white : Colors.brown),
            customText(
                text: 'لا',
                context: context,
                color: !state.isServant ? Colors.white : Colors.brown),
          ],
        );
      },
    );
  }

  Widget customText({
    required String text,
    required BuildContext context,
    required Color color,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          text,
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(color: color),
        ),
      );
}
