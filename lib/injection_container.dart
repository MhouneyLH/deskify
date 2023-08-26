import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/core.dart';
import 'features/data/data_sources/desk_remote_data_source.dart';
import 'features/data/repository/desk_repository_impl.dart';
import 'features/domain/repository/desk_repository.dart';
import 'features/domain/usecases/create_desk_usecase.dart';
import 'features/domain/usecases/delete_desk_usecase.dart';
import 'features/domain/usecases/get_all_desks_usecase.dart';
import 'features/domain/usecases/get_desk_by_id_usecase.dart';
import 'features/domain/usecases/update_desk_usecase.dart';
import 'features/presentation/bloc/desk/desk_bloc.dart';

// sl = service locator
// using sl() is short for sl.call()
// the value of sl() gets automatically resolved at runtime with the correct registered type
final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc
  sl.registerFactory(() => DeskBloc(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ));

  // Usecases
  sl.registerLazySingleton(() => CreateDeskUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetAllDesksUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetDeskByIdUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateDeskUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeleteDeskUsecase(repository: sl()));

  // Repository
  sl.registerLazySingleton<DeskRepository>(() => DeskRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<DeskRemoteDataSource>(
      () => DeskRemoteDataSourceImpl(instance: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
