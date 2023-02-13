import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/global/theme/app_color/app_color_light.dart';
import '../../../../../core/services/sevices_locator.dart';
import '../../../controller/sign_up/sign_up_bloc.dart';
import '../../../controller/sign_up/sign_up_state.dart';

class SelectSchoolComponent extends StatefulWidget {
  const SelectSchoolComponent({Key? key}) : super(key: key);

  @override
  State<SelectSchoolComponent> createState() => _SelectSchoolComponentState();
}

class _SelectSchoolComponentState extends State<SelectSchoolComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          previous.lastSelectSchool != current.lastSelectSchool ||
          previous.isServant != current.isServant ||
          previous.lastExpandedGrade != current.lastExpandedGrade,
      builder: (context, state) {
        if (!SignUpBloc.isServant) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (SignUpBloc.lastSelectSchool != -1 ||
                      (SignUpBloc.lastExpandedGrade > 3 &&
                          SignUpBloc.lastSelectSchool == -1))
                    const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text('أختر المرحلة التعليمية'),
                ],
              ),
              onPressed: () {
                customBottomSheet(context);
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Future<void> customBottomSheet(context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            setState(() {});
            return true;
          },
          child: DraggableScrollableSheet(
            initialChildSize: .65,
            minChildSize: .65,
            builder: (_, controller) {
              return BlocProvider(
                create: (context) => sl<SignUpBloc>(),
                child: BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    var cubit = BlocProvider.of<SignUpBloc>(context);
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                        color: AppColorsLight.third,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ListView(
                          controller: controller,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: const Text('تم')),
                                  Text(
                                    'المرحلة التعليمية',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            ExpansionPanelList(
                              expansionCallback: (panelIndex, isExpanded) {
                                cubit.changeExpanded(panelIndex, isExpanded);
                              },
                              // dividerColor: Colors.white,
                              children: SignUpBloc.schoolGradeModel
                                  .where((element) => element.levelCount != 0)
                                  .map(
                                (e) {
                                  final int length = e.levelCount;
                                  return ExpansionPanel(
                                    canTapOnHeader: true,
                                    isExpanded: e.isExpanded,
                                    backgroundColor: Colors.brown[400],
                                    body: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(': الصف',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      color: Colors.white)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ToggleButtons(
                                            fillColor: Colors.green,
                                            direction: Axis.vertical,
                                            isSelected: [
                                              for (int i = 0; i < length; i++)
                                                SignUpBloc.schoolSelections[i],
                                            ],
                                            onPressed: (index) {
                                              setState(() {
                                                cubit.selectSchool(index);
                                              });
                                            },
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            selectedColor: Colors.green,
                                            children: [
                                              for (int i = 0; i < length; i++)
                                                SizedBox(
                                                  width: double.maxFinite,
                                                  child: Text(
                                                    SignUpBloc.levelGrades[i],
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    headerBuilder: (_, isExpanded) => ListTile(
                                        title: Text(
                                      e.nameGrade,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(color: Colors.white),
                                    )),
                                  );
                                },
                              ).toList(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                verticalDirection: VerticalDirection.down,
                                children: [
                                  ToggleButtons(
                                    onPressed: (index) {
                                      setState(() {
                                        cubit.selectOtherSchool(index + 4);
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    fillColor: Colors.green,
                                    isSelected: SignUpBloc.schoolGradeModel
                                        .where((element) =>
                                            element.levelCount == 0)
                                        .map((e) {
                                      return e.isExpanded;
                                    }).toList(),
                                    children: SignUpBloc.schoolGradeModel
                                        .where((element) =>
                                            element.levelCount == 0)
                                        .map((e) {
                                      return Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Text(e.nameGrade,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(color: Colors.white)),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
