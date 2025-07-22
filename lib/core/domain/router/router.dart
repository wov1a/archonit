import 'package:crypto_test/core/domain/di/di_container.dart';
import 'package:crypto_test/core/domain/router/router_observer.dart';
import 'package:crypto_test/feature/crypto/data/repository/crypto_repo_impl.dart';

import 'package:crypto_test/feature/crypto/presentation/crypto_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter() {
  return GoRouter(
    observers: [RouterObserver()],
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return CryptoListProvider(
            repo: DiContainer.instance.get<CryptoRepoImpl>(),
          );
        },
      ),
    ],
  );
}
