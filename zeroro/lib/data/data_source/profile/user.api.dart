import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../dto/profile/user.dto.dart';

part 'user.api.g.dart';

@RestApi(baseUrl: 'http://10.0.2.2:8000/api/v1/users')
abstract class UserApi {
  factory UserApi(Dio dio, {String? baseUrl}) = _UserApi;

  @GET('/{user_id}')
  Future<UserDto> getUser(@Path('user_id') String userId);

  @POST('/{user_id}')
  Future<CreateUserResponse> createUser(@Body() CreateUserRequest user);

  @PUT('/{user_id}')
  Future<UpdateUserResponse> updateUser(
    @Path('user_id') String userId,
    @Body() UpdateUserRequest user,
  );

  @DELETE('/{user_id}')
  Future<void> deleteUser(@Path('user_id') String userId);
}
