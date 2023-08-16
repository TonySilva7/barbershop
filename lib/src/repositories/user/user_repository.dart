import 'package:barbershop/src/core/exceptions/auth_exceptions.dart';
import 'package:barbershop/src/core/fp/either.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
}
