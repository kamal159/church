import 'package:chruch/church/domain/usecases/get_fathers_usecase.dart';
import 'package:chruch/church/domain/usecases/get_user_data_usecase.dart';
import 'package:chruch/church/presentation/controller/layout/layout_bloc.dart';
import 'package:chruch/church/presentation/controller/sign_up/sign_up_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../church/data/datasource/church_remote_data_source.dart';
import '../../church/data/repository/church_repository.dart';
import '../../church/domain/repository/base_church_repository.dart';
import '../../church/domain/usecases/sign_in_usecase.dart';
import '../../church/domain/usecases/sign_up_usecase.dart';
import '../../church/presentation/controller/settings/settings_bloc.dart';
import '../../church/presentation/controller/sign_in/sign_in_bloc.dart';


final sl = GetIt.instance;


class ServicesLocator {
  void init (){
    /// Bloc
    sl.registerFactory(() => SignUpBloc(sl(), sl()));
    sl.registerFactory(() => SignInBloc(sl()));
    sl.registerFactory(() => LayoutBloc(sl()));
    sl.registerFactory(() => SettingsBloc());
    // sl.registerFactory(() => MovieDetailBloc(sl(), sl()));
    // sl.registerFactory(() => LoginBloc(sl(), sl()));
    /// USE CASES
    sl.registerLazySingleton(() => SignUpUseCase(sl()));
    sl.registerLazySingleton(() => SignInUseCase(sl()));
    sl.registerLazySingleton(() => GetUserDataUseCase(sl()));
    sl.registerLazySingleton(() => GetFathersUseCase(sl()));
    // sl.registerLazySingleton(() => GetPopularMoviesUseCase(sl()));
    // sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));
    // sl.registerLazySingleton(() => GetMovieDetailUseCase(sl()));
    // sl.registerLazySingleton(() => GetMovieRecommendationsUseCase(sl()));
    // sl.registerLazySingleton(() => GetNewSessionUseCase(sl()));
    // sl.registerLazySingleton(() => GetNewRequestTokenUseCase(sl()));
    /// Repository
    sl.registerLazySingleton<BaseChurchRepository>(() => ChurchRepository(sl()));
    /// DATA SOURCE
    sl.registerLazySingleton<BaseChurchRemoteDataSource>(() => ChurchRemoteDataSource());
  }
}