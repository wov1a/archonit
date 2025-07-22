import 'package:bloc/bloc.dart';
import 'package:crypto_test/core/domain/pagination_app/pagination/cubit_pagination.dart';
import 'package:crypto_test/core/domain/pagination_app/pagination/pagination_controller_result.dart';
import 'package:crypto_test/core/domain/pagination_app/pagination/pagination_controller_state.dart';
import 'package:crypto_test/core/domain/pagination_app/pagination/pagination_handler.dart';
import 'package:crypto_test/core/domain/pagination_app/pagination/pagination_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ModdedCubitPagingController<
  ItemType,
  PM extends PaginationMethod,
  ErrorType
>
    extends Cubit<PaginationControllerState<ItemType, PM, ErrorType>>
    with PaginationHandler<ItemType, PM, ErrorType>
    implements CubitPaginationController<ItemType, PM, ErrorType> {
  @override
  late final ScrollController scrollController;

  @override
  final Future<PaginationResult<ItemType, PM, ErrorType>> Function(
    PM pagination,
  )
  getPageFunc;

  @override
  final PM firstPagePointer;

  ModdedCubitPagingController({
    required this.firstPagePointer,
    final ScrollController? scrollController,
    final bool loadFirstPageOnInit = true,
    required this.getPageFunc,
    final List<ItemType>? initialList,
  }) : super(
         initialList != null && initialList.isNotEmpty
             ? DataListPCState(
                 lastPagination: firstPagePointer,
                 itemList: initialList,
                 isLastItems: firstPagePointer.isLastElementList(
                   initialList.length,
                 ),
               )
             : EmptyListPCState(lastPagination: firstPagePointer),
       ) {
    this.scrollController = scrollController ?? ScrollController();
    this.scrollController.addListener(_scrollListener);

    if (loadFirstPageOnInit) getFirst();
  }

  bool _hasAlreadyInvokedByScrollController = false;

  @override
  set state(PaginationControllerState<ItemType, PM, ErrorType> newState) =>
      emit(newState);

  @override
  final ValueNotifier<bool> isProcessing = ValueNotifier(false);

  void _scrollListener() async {
    if (_hasAlreadyInvokedByScrollController) return;
    if (this.scrollController.position.extentAfter < 200 &&
        this.scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      print('ScrollController: Invoking getNext()');
      switch (state) {
        case DataListPCState<ItemType, PM, ErrorType>(
          isLastItems: final isLastPage,
        ):
          if (!isLastPage) {
            _hasAlreadyInvokedByScrollController = true;
            await getNext();
            _hasAlreadyInvokedByScrollController = false;
          }
          break;
        case EmptyListPCState<ItemType, PM, ErrorType>():
        case ErrorListPCState<ItemType, PM, ErrorType>():
          break;
      }
    }
  }

  void appendListItems(List<ItemType> additionalItemList) {
    switch (state) {
      case DataListPCState<ItemType, PM, ErrorType>(
        :final itemList,
        :final lastPagination,
        :final isLastItems,
      ):
        emit(
          DataListPCState(
            itemList: [...itemList, ...additionalItemList],
            lastPagination:
                lastPagination.next(additionalItemList.length) as PM,
            isLastItems: isLastItems,
          ),
        );
        return;
      case EmptyListPCState<ItemType, PM, ErrorType>():
      case ErrorListPCState<ItemType, PM, ErrorType>():
        emit(
          DataListPCState(
            itemList: additionalItemList,
            lastPagination: firstPagePointer,
            isLastItems: false,
          ),
        );
        return;
    }
  }
}
