import 'dart:developer';
import 'dart:io';

import 'package:barbershop/src/core/exceptions/auth_exceptions.dart';
import 'package:barbershop/src/core/exceptions/repository_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/rest_client/rest_client.dart';
import 'package:barbershop/src/model/user_model.dart';
import 'package:barbershop/src/repositories/user/user_repository.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({required this.restClient});

  @override
  Future<Either<AuthException, String>> login(String email, String password) async {
    // O :data é a mesma coisa que `Response(data: data) = await ...`
    try {
      final Response(:data) = await restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
      });

      return Success(data['access_token']);
    } on DioException catch (e, s) {
      final Response(:statusCode) = e.response!;
      if (statusCode == HttpStatus.forbidden) {
        log('Login ou senha inválidos', error: e, stackTrace: s);
        return Failure(const AuthUnauthorizedException());
      }
      log('Erro ao fazer login', error: e, stackTrace: s);
      return Failure(const AuthError(message: 'Erro ao fazer login'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');
      return Success(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao buscar usuário'));
    } on ArgumentError catch (e, s) {
      log('Invalid json', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }
}
