import 'package:flutter/material.dart';

import '../models/login.dart';
import '../widgets/login_form.dart';
import 'home_screen.dart';

/// Tela de login: o usuário digita as credenciais.
/// Se forem "admin" / "1234" vai para a HomeScreen; caso contrário,
/// mostra uma SnackBar de falha.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _handleLogin(BuildContext context, Login login) {
    if (login.isValid) {
      // pushReplacement: o usuário não volta para o login com o botão
      // "voltar" depois de autenticado.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Falha no login: usuário ou senha incorretos.')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/logo.png', height: 100),
                      const SizedBox(height: 32),
                      LoginForm(
                        onSubmit: (login) => _handleLogin(context, login),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextButton(
                onPressed: () {},
                child: const Text('New User? Create Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
