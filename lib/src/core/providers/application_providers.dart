import 'package:barbershop/src/core/rest_client/rest_client.dart';
import 'package:barbershop/src/repositories/user/user_repository.dart';
import 'package:barbershop/src/repositories/user/user_repository_impl.dart';
import 'package:barbershop/src/services/user_login/user_login_service.dart';
import 'package:barbershop/src/services/user_login/user_login_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

// O provider acima é injetado neste provider abaixo por meio do ref.read
@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) => UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));
