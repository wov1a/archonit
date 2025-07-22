import 'package:crypto_test/core/domain/result.dart';
import 'package:crypto_test/feature/crypto/data/models/crypto_data_model.dart';
import 'package:crypto_test/feature/crypto/presentation/widget/crypto_item.dart';

abstract class CryptoRepo {
  Future<Result<List<CryptoItem>>> getCryptoList(CryptoDataModel filter);
}
