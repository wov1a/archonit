import 'dart:async';

import 'package:flutter/material.dart';
import 'pagination_controller_result.dart';
import 'pagination_controller_state.dart';
import 'pagination_method.dart';

abstract interface class PaginationController<
  ItemType,
  PM extends PaginationMethod,
  ErrorType
> {
  abstract final ScrollController scrollController;

  abstract final Future<PaginationResult<ItemType, PM, ErrorType>> Function(
    PM pagination,
  )
  getPageFunc;

  abstract final PM firstPagePointer;

  abstract final ValueNotifier<bool> isProcessing;

  PaginationControllerState<ItemType, PM, ErrorType> get state;

  @protected
  set state(PaginationControllerState<ItemType, PM, ErrorType> newState);

  Future<void> getFirst();

  Future<void> getNext();

  Future<void> refreshCurrent();
}
