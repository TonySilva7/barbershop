import 'package:asyncstate/asyncstate.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/features/auth/login/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandler = AsyncLoaderHandler()..start();
    final loginService = ref.watch(userLoginServiceProvider);
    final loginResult = await loginService.execute(email, password);

    switch (loginResult) {
      case Success():
        // buscar dados do usuário logado
        // fazer uma análise para qual o tipo do login
        break;
      case Failure(:final error):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => error.message,
        );
    }

    loaderHandler.close();
  }
}
