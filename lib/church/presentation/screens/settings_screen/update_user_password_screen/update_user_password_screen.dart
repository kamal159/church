import 'package:chruch/core/global/components/components.dart';
import 'package:chruch/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/services/sevices_locator.dart';
import '../../../controller/settings/settings_bloc.dart';

class UpdateUserPasswordScreen extends StatefulWidget {
  const UpdateUserPasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdateUserPasswordScreen> createState() =>
      _UpdateUserPasswordScreenState();
}

class _UpdateUserPasswordScreenState extends State<UpdateUserPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordAgainController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل الباسورد'),
      ),
      body: Form(
        key: _formKey,
        child: BlocProvider(
          create: (context) => sl<SettingsBloc>(),
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              var cubit = BlocProvider.of<SettingsBloc>(context);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      customTextFormField(
                          context: context,
                          controller: currentPasswordController,
                          labelText: 'الباسورد الحالي',
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val) {
                            if (val == null || val.length < 6)
                              return 'برجاء ادخال 6 رموز على الاقل';
                            return null;
                          },
                          prefixIcon: IconlyBold.password,
                          obscureText: state.isSure,
                          suffixIcon: !state.isSure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          suffixIconOnPressed: () {
                            cubit.changeVisiblePassword();
                          },
                          textDirection: TextDirection.ltr),
                      customTextFormField(
                          context: context,
                          controller: passwordController,
                          labelText: 'الباسورد الجديد',
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val) {
                            if (val == null || val.length < 6)
                              return 'برجاء ادخال 6 رموز على الاقل';
                            return null;
                          },
                          prefixIcon: IconlyBold.password,
                          obscureText: state.isSure,
                          suffixIcon: !state.isSure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          suffixIconOnPressed: () {
                            cubit.changeVisiblePassword();
                          },
                          textDirection: TextDirection.ltr),
                      customTextFormField(
                          context: context,
                          controller: passwordAgainController,
                          labelText: 'الباسورد الجديد مرة اخرى',
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val) {
                            if (val != passwordController.text)
                              return 'الباسورد الذي ادخلته غير متطابق';
                            return null;
                          },
                          prefixIcon: IconlyBold.password,
                          obscureText: state.isSure,
                          suffixIcon: !state.isSure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          suffixIconOnPressed: () {
                            cubit.changeVisiblePassword();
                          },
                          textDirection: TextDirection.ltr),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: customButton(
                            context: context,
                            text: 'حفظ',
                            isLoading: state.requestState == RequestState.loading,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.add(UpdateUserPasswordEvent(
                                  password: passwordController.text,
                                  currentPassword:
                                      currentPasswordController.text,
                                ));
                              }
                            }),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
