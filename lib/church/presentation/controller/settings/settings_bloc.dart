
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/global/components/components.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../screens/get_started_screen/get_started_screen.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState());


  Future<void> logout(context) async {
    await deleteDB();
    await CacheHelper.removeData(key: 'uid');
    await CacheHelper.removeData(key: 'isUserDataSaved');
    navigateTo(context, const GetStartedScreen(), until: false);
  }
}
