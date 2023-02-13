import 'package:chruch/church/presentation/controller/sign_up/sign_up_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../church/data/datasource/church_remote_data_source.dart';
import '../../church/data/repository/church_repository.dart';
import '../../church/domain/repository/base_movies_repository.dart';
import '../../church/domain/usecases/sign_in_usecase.dart';
import '../../church/domain/usecases/sign_up_usecase.dart';
import '../../church/presentation/controller/sign_in/sign_in_bloc.dart';


final sl = GetIt.instance;


class ServicesLocator {
  void init (){
    /// Bloc
    sl.registerFactory(() => SignUpBloc(sl()));
    sl.registerFactory(() => SignInBloc(sl()));
    // sl.registerFactory(() => MovieDetailBloc(sl(), sl()));
    // sl.registerFactory(() => LoginBloc(sl(), sl()));
    /// USE CASES
    sl.registerLazySingleton(() => SignUpUseCase(sl()));
    sl.registerLazySingleton(() => SignInUseCase(sl()));
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