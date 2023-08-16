import 'dart:math';

import 'package:barbershop/src/core/ui/constants.dart';
import 'package:barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:barbershop/src/features/auth/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.backgroundChair),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstants.imageLogo,
                            width: 200,
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: Validatorless.multiple([
                              Validatorless.required('E-mail obrigatório'),
                              Validatorless.email('E-mail inválido'),
                            ]),
                            onTapOutside: (value) => context.unFocus(), // context personalizado
                            decoration: const InputDecoration(
                              label: Text('E-mail'),
                              hintText: 'E-mail',
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: passwordController,
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha é obrigatório'),
                              Validatorless.min(6, 'Senha deve ter no mínimo 6 caracteres')
                            ]),
                            onTapOutside: (value) => context.unFocus(), // context personalizado
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text('Senha'),
                              hintText: 'Senha',
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Esqueceu a senha?',
                              style: TextStyle(color: ColorsTheme.brow),
                            ),
                          ),
                          const SizedBox(height: 25),
                          ElevatedButton(
                              onPressed: () {
                                switch (formKey.currentState?.validate()) {
                                  case (false || null):
                                    // mostrar uma mensagem de erro
                                    break;
                                  case true:
                                    login(emailController.text, passwordController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text('Entrar')),
                        ],
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Criar conta',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
