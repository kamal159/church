import 'package:chruch/church/presentation/controller/sign_up/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../../../../core/global/components/components.dart';

class BirthDayComponent extends StatelessWidget {

  const BirthDayComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController dateInputController = TextEditingController(text: SignUpBloc.formattedDate);

    return customTextFormField(
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
      prefixIcon: IconlyBroken.calendar,
    );
  }
  String text(text) => 'برجاء التاكد من $text';

}
