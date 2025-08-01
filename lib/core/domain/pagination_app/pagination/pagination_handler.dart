import 'package:flutter/foundation.dart';
import 'pagination_controller.dart';
import 'pagination_controller_result.dart';
import 'pagination_controller_state.dart';
import 'pagination_method.dart';

mixin PaginationHandler<ItemType, PM extends PaginationMethod, ErrorType>
    implements PaginationController<ItemType, PM, ErrorType> {
  @protected
  Future<PaginationControllerState<ItemType, PM, ErrorType>> handlePagination(
    PaginationMethod pagination, [
    bool replaceOldList = false,
  ]) async {
    switch (state) {
      case DataListPCState<ItemType, PM, ErrorType>(:final itemList):
        final getPageResult = await getPageFunc(pagination as PM);

        switch (getPageResult) {
          case SuccessPaginationResult<ItemType, PM, ErrorType>(
            :final isLastItemList,
            itemList: final newItemList,
            :final pagination,
          ):
            if (newItemList.isEmpty) {
              if (pagination == firstPagePointer) {
                return EmptyListPCState(lastPagination: pagination);
              } else {
                return DataListPCState(
                  itemList: itemList,
                  lastPagination: pagination,
                  isLastItems: true,
                );
              }
            }

            return DataListPCState(
              itemList: replaceOldList
                  ? newItemList
                  : [...itemList, ...newItemList],
              lastPagination: pagination,
              isLastItems: isLastItemList,
            );
          case ErrorPaginationResult<ItemType, PM, ErrorType>(
            :final pagination,
          ):
            return ErrorListPCState(lastPagination: pagination);
        }
      case ErrorListPCState<ItemType, PM, ErrorType>():
      case EmptyListPCState<ItemType, PM, ErrorType>():
        final getPageResult = await getPageFunc(pagination as PM);

        switch (getPageResult) {
          case SuccessPaginationResult<ItemType, PM, ErrorType>(
            :final isLastItemList,
            :final itemList,
            :final pagination,
          ):
            if (itemList.isEmpty) {
              if (pagination == firstPagePointer) {
                return EmptyListPCState(lastPagination: pagination);
              } else {
                return DataListPCState(
                  itemList: itemList,
                  lastPagination: pagination,
                  isLastItems: true,
                );
              }
            }

            return DataListPCState(
              itemList: itemList,
              lastPagination: pagination,
              isLastItems: isLastItemList,
            );
          case ErrorPaginationResult<ItemType, PM, ErrorType>(
            :final pagination,
          ):
            return ErrorListPCState(lastPagination: pagination);
        }
    }
  }

  @override
  Future<void> getFirst() async {
    isProcessing.value = true;
    state = await handlePagination(firstPagePointer, true);
    isProcessing.value = false;
  }

  @override
  Future<void> getNext() async {
    isProcessing.value = true;
    switch (state) {
      case DataListPCState<ItemType, PM, ErrorType>(:final lastPagination):
        state = await handlePagination(lastPagination.next());
        break;
      case EmptyListPCState<ItemType, PM, ErrorType>():
      case ErrorListPCState<ItemType, PM, ErrorType>():
        state = await handlePagination(firstPagePointer);
        break;
    }
    isProcessing.value = false;
  }

  @override
  Future<void> refreshCurrent() async {
    isProcessing.value = true;
    switch (state) {
      case DataListPCState<ItemType, PM, ErrorType>(:final lastPagination):
        state = (await handlePagination(
          lastPagination.allCurrent(),
          true,
        )).copyWithPagination(lastPagination);
        break;
      case EmptyListPCState<ItemType, PM, ErrorType>(:final lastPagination):
      case ErrorListPCState<ItemType, PM, ErrorType>(:final lastPagination):
        state = (await handlePagination(
          firstPagePointer,
          true,
        )).copyWithPagination(lastPagination);
        break;
    }
    isProcessing.value = false;
  }
}
