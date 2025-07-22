import 'package:crypto_test/core/domain/app_error/app_error.dart';
import 'package:crypto_test/core/domain/pagination_app/pagination/cubit_pagination.dart';
import 'package:crypto_test/core/domain/pagination_app/pagination/pagination_controller_result.dart';
import 'package:crypto_test/core/domain/pagination_app/pagination/pagination_method.dart';

import 'package:crypto_test/core/domain/result.dart';
import 'package:crypto_test/feature/crypto/data/models/crypto_data_model.dart';
import 'package:crypto_test/feature/crypto/presentation/widget/crypto_item.dart';
import 'package:flutter/material.dart';

mixin CryptoPaginationHandler {
  late final paginationController =
      CubitPaginationController<CryptoItem, OffsetPagination, SpecificError>(
        firstPagePointer: const OffsetPagination(offset: 0),
        getPageFunc: getPageFunc,
      );

  @protected
  Future<Result<List<CryptoItem>>> getCryptoList(CryptoDataModel filter);

  Future<PaginationResult<CryptoItem, OffsetPagination, SpecificError>>
  getPageFunc(OffsetPagination pagination) async {
    final getResult = await getCryptoList(
      CryptoDataModel(limit: pagination.limit, offset: pagination.offset),
    );

    switch (getResult) {
      case DataResult<List<CryptoItem>>(:final data):
        return SuccessPaginationResult(itemList: data, pagination: pagination);
      case ErrorResult<List<CryptoItem>>(:final specificError):
        return ErrorPaginationResult(
          data: specificError,
          pagination: pagination,
        );
    }
  }
}
