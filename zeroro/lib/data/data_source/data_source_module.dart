import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/client.dart';
import 'community/community.api.dart';

@module
abstract class DataSourceModule {
  final Dio _dio = RestClient().getDio;
  
  @singleton
  CommunityApi get communityApi => CommunityApi(_dio);
}