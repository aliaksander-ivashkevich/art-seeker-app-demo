import 'package:dio/dio.dart';

import '../src/data/repositories/art_repository.dart';
import '../src/data/repositories/art_repository_impl.dart';
import '../src/navigation/router.dart';

final AppRouter router = AppRouter();

final Dio dio = Dio(
  BaseOptions(
    followRedirects: false,
    baseUrl: 'https://api.artic.edu/api/v1',
  ),
)..interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
    ),
  );

final ArtRepository artRepository = ArtRepositoryImpl(
  dio,
);
