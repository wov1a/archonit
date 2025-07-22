import 'package:crypto_test/feature/crypto/domain/repository/crypto_repo.dart';
import 'package:crypto_test/feature/crypto/presentation/crypto_list_view.dart';
import 'package:crypto_test/feature/crypto/presentation/crypto_list_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoListProvider extends StatefulWidget {
  final CryptoRepo _repo;
  const CryptoListProvider({super.key, required CryptoRepo repo})
    : _repo = repo;

  @override
  State<CryptoListProvider> createState() => _CryptoListProviderState();
}

class _CryptoListProviderState extends State<CryptoListProvider> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => CryptoListVm(widget._repo),
      child: const CryptoListView(),
    );
  }
}
