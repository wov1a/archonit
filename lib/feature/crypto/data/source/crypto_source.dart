import 'package:crypto_test/feature/crypto/data/models/crypto_list_response_model.dart';
import 'package:crypto_test/feature/crypto/data/source/crypto_source_urls.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'crypto_source.g.dart';

@RestApi(baseUrl: "https://rest.coincap.io/v3/")
abstract class CryptoSource {
  factory CryptoSource(Dio dio) = _CryptoSource;
  @GET(CryptoSourceUrls.getCryptoList)
  Future<CryptoListResponse> getCryptoList(
    @Query("offset") int offset,
    @Query("limit") int limit,
  );
}
