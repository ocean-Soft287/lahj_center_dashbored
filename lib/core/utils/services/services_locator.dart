import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/repo/currency_repo_imp.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/repo/government_repo.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/repo/government_repo_imp.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/presentation/manger/currency_cubit/currency_cubit.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/presentation/manger/governmentcubit/government_cubit.dart';

import '../../../feature/Auth/data/repo/repo.dart';
import '../../../feature/Auth/data/repo/repoimp.dart';
import '../../../feature/Auth/presentation/cubit/auth_cubit.dart';
import '../../../feature/addcurrencyandcategory/data/repo/currency_repo.dart';
import '../api/api_consumer.dart';
import '../api/dio_consumer.dart';
import '../api/endpoint.dart';

final sl = GetIt.instance;
void setup() {
  // Dio instance registration
  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: EndPoint.baseUrl))
      ..interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ),
      ),
  );

  /// Register DioConsumer
  sl.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: sl<Dio>()));
  sl.registerLazySingleton<ApiConsumer>(() => sl<DioConsumer>());

  /// Registering login
  sl.registerLazySingleton<LoginRepo>(
    () => Loginrepoimp(dioConsumer: sl<DioConsumer>()),
  );
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl<LoginRepo>()));


  sl.registerLazySingleton<Currencyrepo>(() => CurrencyRepoImp(dioConsumer: sl<DioConsumer>()));
  sl.registerFactory<CurrencyCubit>(() => CurrencyCubit(sl<Currencyrepo>()));


  sl.registerLazySingleton<Governmentrepo>(() => Governmentrepoimp(dioConsumer: sl<DioConsumer>()));
  sl.registerFactory<GovernmentCubit>(() => GovernmentCubit(sl<Governmentrepo>()));


}
