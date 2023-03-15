

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../data/api_client.dart';

final GetIt getIt = GetIt.instance;
Future<void> setup()async{
getIt.registerLazySingleton(() => Dio());
getIt.registerLazySingleton(() => NewsClient(Dio()));
}