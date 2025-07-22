import 'dart:developer';

import 'package:crypto_test/core/domain/di/di_registrar.dart';
import 'package:crypto_test/feature/crypto/data/repository/crypto_repo_impl.dart';
import 'package:crypto_test/feature/crypto/data/source/crypto_source.dart';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

class DiContainer implements Registry {
  static final instance = DiContainer._();
  DiContainer._();

  Future<void> init() async {
    try {
      final apiKey = dotenv.env['API_KEY'];
      final Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $apiKey';

      final cryptoSource = CryptoSource(dio);
      put(SingletonRegistrar(cryptoSource));
      final cryptoRepo = CryptoRepoImpl(get());
      put(SingletonRegistrar(cryptoRepo));
    } catch (e, st) {
      log('App Container has not been initialized', error: e, stackTrace: st);
    }
  }

  @override
  void drop<T>() {
    final droppingInstance = GetIt.instance<Registrar<T>>();
    droppingInstance.dispose();
    GetIt.instance.unregister<Registrar<T>>();
  }

  @override
  T get<T>() {
    try {
      return GetIt.instance.get<Registrar<T>>().instance;
    } catch (e, st) {
      log(get.toString(), error: e, stackTrace: st);
      rethrow;
    }
  }

  @override
  void put<T>(Registrar<T> registrar) =>
      GetIt.instance.registerSingleton<Registrar<T>>(registrar);

  bool isExists<T>() => GetIt.instance.isRegistered<Registrar<T>>();
}
