import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/global/components/components.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/usecases/get_user_data_usecase.dart';
import 'layout_event.dart';
import 'layout_state.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {

  LayoutBloc() : super(const LayoutState()){
    getUserDB();
    print('donnneeee');
  }


}
