import 'package:chruch/church/data/datasource/chruch_local_data_source.dart';
import 'package:chruch/church/domain/usecases/local_usecase/get_user_table_db_usecase.dart';
import 'package:chruch/church/domain/usecases/remote_usecase/get_fathers_usecase.dart';
import 'package:chruch/church/domain/usecases/remote_usecase/get_user_data_usecase.dart';
import 'package:chruch/church/domain/usecases/remote_usecase/update_user_password_usecase.dart';
import 'package:chruch/church/presentation/controller/layout/layout_bloc.dart';
import 'package:chruch/church/presentation/controller/sign_up/sign_up_bloc.dart';
import 'package:chruch/church/presentation/controller/splash/splash_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../church/data/datasource/church_remote_data_source.dart';
import '../../church/data/repository/local_church_repository.dart';
import '../../church/data/repository/remote_church_repository.dart';
import '../../church/domain/repository/base_local_church_repository.dart';
import '../../church/domain/repository/base_remote_church_repository.dart';
import '../../church/domain/usecases/local_usecase/create_user_table_db_usecase.dart';
import '../../church/domain/usecases/local_usecase/insert_user_data_usecase.dart';
import '../../church/domain/usecases/remote_usecase/sign_in_usecase.dart';
import '../../church/domain/usecases/remote_usecase/sign_up_usecase.dart';
import '../../church/domain/usecases/remote_usecase/update_user_profile_image_usecase.dart';
import '../../church/presentation/controller/settings/settings_bloc.dart';
import '../../church/presentation/controller/sign_in/sign_in_bloc.dart';


final sl = GetIt.instance;


class ServicesLocator {
  void init (){
    /// Bloc
    sl.registerFactory(() => SignUpBloc(sl(), sl()));
    sl.registerFactory(() => SignInBloc(sl(), sl(), sl()));
    sl.registerFactory(() => LayoutBloc());
    sl.registerFactory(() => SettingsBloc(sl(), sl()));
    sl.registerFactory(() => SplashBloc(sl()));
    /// USE CASES
    sl.registerLazySingleton(() => SignUpUseCase(sl()));
    sl.registerLazySingleton(() => SignInUseCase(sl()));
    sl.registerLazySingleton(() => GetUserDataUseCase(sl()));
    sl.registerLazySingleton(() => GetFathersUseCase(sl()));
    sl.registerLazySingleton(() => UpdateUserPasswordUseCase(sl()));
    sl.registerLazySingleton(() => InsertUserDataUseCase(sl()));
    sl.registerLazySingleton(() => CreateUserTableDBUseCase(sl()));
    sl.registerLazySingleton(() => GetUserTableDataBaseUseCase(sl()));
    sl.registerLazySingleton(() => UpdateUserProfileImageUseCase(sl()));
    /// Repository
    sl.registerLazySingleton<BaseRemoteChurchRepository>(() => RemoteChurchRepository(sl()));
    sl.registerLazySingleton<BaseLocalChurchRepository>(() => LocalChurchRepository(sl()));
    /// DATA SOURCE
    sl.registerLazySingleton<BaseRemoteChurchDataSource>(() => ChurchRemoteDataSource());
    sl.registerLazySingleton<BaseLocalChurchDataSource>(() => ChurchLocalDataSource());
  }
}