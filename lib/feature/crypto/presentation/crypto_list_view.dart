import 'package:crypto_test/core/domain/pagination_app/pagination/widgets/cubit_pagination.dart';
import 'package:crypto_test/core/widgets/folder_empty.dart';
import 'package:crypto_test/feature/crypto/presentation/crypto_list_vm.dart';
import 'package:crypto_test/feature/crypto/presentation/widget/crypto_item.dart';
import 'package:crypto_test/theme/text_style_app.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CryptoListView extends StatefulWidget {
  const CryptoListView({super.key});

  @override
  State<CryptoListView> createState() => _CryptoListViewState();
}

class _CryptoListViewState extends State<CryptoListView> {
  late final vm = context.read<CryptoListVm>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _listBuilder() => RefreshIndicator(
    onRefresh: () async {
      await vm.paginationController.getFirst();
    },
    child: CustomScrollView(
      controller: vm.paginationController.scrollController,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        CubitPaginatedListBuilder(
          controller: vm.paginationController,
          dataBuilder: (context, dataState, isProcessing) {
            final itemCount = isProcessing
                ? dataState.itemList.length + 1
                : dataState.itemList.length;

            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (isProcessing && index == dataState.itemList.length) {
                  return Center(
                    child: SpinKitThreeBounce(color: Colors.grey, size: 20.0),
                  );
                }

                final item = dataState.itemList[index];
                String name = item.cryptoName;
                if (name.length > 20) {
                  name = '${name.substring(0, 20)}...';
                }
                return CryptoItem(
                  cryptoName: name, // ← или подставь реальные данные
                  cryptoPrice:
                      '${NumberFormat('#,##0.00', 'en_US').format(double.parse(item.cryptoPrice))}\$',
                );
              }, childCount: itemCount),
            );
          },
          emptyBuilder: (context, emptyState, isProcessing) =>
              SliverFillRemaining(child: FolderEmptyWidget()),
          errorBuilder: (context, errorState, isProcessing) =>
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    'Error: ${errorState.description}',
                    style: TextStyleApp.textBody14.copyWith(color: Colors.red),
                  ),
                ),
              ),
        ),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(toolbarHeight: 0),
      body: SafeArea(
        child: Column(children: [Expanded(child: _listBuilder())]),
      ),
    );
  }
}
