import 'package:crypto_test/core/domain/pagination_app/pagination/cubit_pagination.dart';
import 'package:crypto_test/core/domain/pagination_app/pagination/pagination_controller_state.dart';
import 'package:crypto_test/core/domain/pagination_app/pagination/pagination_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitPaginatedListBuilder<
  ItemType,
  PM extends PaginationMethod,
  ErrorType
>
    extends StatelessWidget {
  final CubitPaginationController<ItemType, PM, ErrorType>? controller;
  final Widget Function(
    BuildContext context,
    DataListPCState<ItemType, PM, ErrorType> dataState,
    bool isProcessing,
  )
  dataBuilder;
  final Widget Function(
    BuildContext context,
    EmptyListPCState<ItemType, PM, ErrorType> emptyState,
    bool isProcessing,
  )
  emptyBuilder;
  final Widget Function(
    BuildContext context,
    ErrorListPCState<ItemType, PM, ErrorType> errorState,
    bool isProcessing,
  )
  errorBuilder;

  const CubitPaginatedListBuilder({
    super.key,
    this.controller,
    required this.dataBuilder,
    required this.emptyBuilder,
    required this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return _CubitPaginatedListBuilder(
      controller: controller,
      builder: (context, state, isProcessing) => switch (state) {
        DataListPCState<ItemType, PM, ErrorType>() => dataBuilder(
          context,
          state,
          isProcessing,
        ),
        EmptyListPCState<ItemType, PM, ErrorType>() => emptyBuilder(
          context,
          state,
          isProcessing,
        ),
        ErrorListPCState<ItemType, PM, ErrorType>() => errorBuilder(
          context,
          state,
          isProcessing,
        ),
      },
    );
  }
}

class _CubitPaginatedListBuilder<
  ItemType,
  PM extends PaginationMethod,
  ErrorType
>
    extends StatelessWidget {
  final CubitPaginationController<ItemType, PM, ErrorType>? controller;
  final Widget Function(
    BuildContext context,
    PaginationControllerState<ItemType, PM, ErrorType> state,
    bool isProcessing,
  )
  builder;

  const _CubitPaginatedListBuilder({
    super.key,
    this.controller,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final controller =
        this.controller ??
        context.read<CubitPaginationController<ItemType, PM, ErrorType>>();
    return ValueListenableBuilder(
      valueListenable: controller.isProcessing,
      builder: (context, isProcessing, _) =>
          BlocBuilder<
            CubitPaginationController<ItemType, PM, ErrorType>,
            PaginationControllerState<ItemType, PM, ErrorType>
          >(
            bloc: controller,
            builder: (context, state) => builder(context, state, isProcessing),
          ),
    );
  }
}
