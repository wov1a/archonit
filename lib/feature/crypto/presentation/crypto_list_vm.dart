import 'dart:async';

import 'package:crypto_test/core/domain/app_error/app_error.dart';
import 'package:crypto_test/core/domain/pagination_app/pagination/cubit_pagination.dart';
import 'package:crypto_test/core/domain/pagination_app/pagination/pagination_method.dart';

import 'package:crypto_test/core/domain/result.dart';
import 'package:crypto_test/feature/crypto/domain/crypto_hanlers/crypto_pagination_handler.dart';
import 'package:crypto_test/feature/crypto/data/models/crypto_data_model.dart';
import 'package:crypto_test/feature/crypto/domain/repository/crypto_repo.dart';
import 'package:crypto_test/feature/crypto/presentation/widget/crypto_item.dart';

class CryptoListVm with CryptoPaginationHandler {
  final CryptoRepo _cryptoRepo;

  // late final paginationController =
  //     CubitPaginationController<CryptoItem, OffsetPagination, SpecificError>(
  //       firstPagePointer: const OffsetPagination(offset: 0),
  //       getPageFunc: (pagination) => getCryptoListFunc(pagination),
  //     );

  CryptoListVm(this._cryptoRepo);

  Future<Result<List<CryptoItem>>> getCryptoList(CryptoDataModel filter) {
    return _cryptoRepo.getCryptoList(filter);
  }

  @override
  CubitPaginationController<CryptoItem, OffsetPagination, SpecificError>
  get paginationController => super.paginationController;

  Future<Result<List<CryptoItem>>> getCryptoListFunc(
    CryptoDataModel pagination,
  ) {
    print(
      'Fetching page with offset: ${pagination.offset}, limit: ${pagination.limit}',
    );
    return getCryptoList(pagination);
  }
}
