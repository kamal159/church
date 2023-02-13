import 'package:chruch/church/presentation/controller/sign_up/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/global/components/components.dart';

class BirthDayComponent extends StatelessWidget {
  final TextEditingController dateInputController = TextEditingController();

  BirthDayComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return customTextFormField(
      context: context,
      controller: dateInputController,
      labelText: 'تاريخ الميلاد',
      keyboardType: TextInputType.datetime,
      readOnly: true,
      validator: (val) {
        return null;
      },
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          SignUpBloc.formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          dateInputController.text = SignUpBloc.formattedDate!;
        }
      },
      prefixIcon: Icons.date_range_outlined,
    );
  }
}
