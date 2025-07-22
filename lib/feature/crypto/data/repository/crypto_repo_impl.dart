import 'package:crypto_test/core/domain/app_error/app_error.dart';
import 'package:crypto_test/core/domain/result.dart';
import 'package:crypto_test/feature/crypto/data/models/crypto_data_model.dart';
import 'package:crypto_test/feature/crypto/data/source/crypto_source.dart';
import 'package:crypto_test/feature/crypto/domain/repository/crypto_repo.dart';
import 'package:crypto_test/feature/crypto/presentation/widget/crypto_item.dart';

class CryptoRepoImpl implements CryptoRepo {
  final CryptoSource _cryptoSource;
  CryptoRepoImpl(this._cryptoSource);
  @override
  Future<Result<List<CryptoItem>>> getCryptoList(CryptoDataModel filter) async {
    try {
      final result = await _cryptoSource.getCryptoList(
        filter.offset,
        filter.limit,
      );
      final convertedList = result.data
          .map((e) => CryptoItem(cryptoName: e.name, cryptoPrice: e.priceUsd))
          .toList();
      return Result.data(convertedList);
    } catch (e) {
      return Result.error(specificError: SpecificError(e.toString()));
    }
  }
}
