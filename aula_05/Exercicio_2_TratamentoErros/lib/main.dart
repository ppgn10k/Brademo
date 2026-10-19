import 'package:flutter/material.dart';

// ===== Funções "fornecidas" (simulam as do codelab) =====
// Esta falha de propósito, para exercitar o try-catch.
Future<String> fetchNewUsername() => Future.delayed(
    const Duration(seconds: 1), () => throw UnsupportedError('Network error'));

// Esta funciona normalmente.
Future<void> logout(String username) =>
    Future.delayed(const Duration(seconds: 1));

// ===== SOLUÇÕES =====

// Parte 1: capturar o erro e devolver a mensagem dele como String.
Future<String> changeUsername() async {
  try {
    return await fetchNewUsername();
  } catch (err) {
    return err.toString();
  }
}

// Parte 2: try-catch-finally. O finally roda sempre, com ou sem erro.
Future<String> logoutUser() async {
  var resultado = '';
  try {
    await logout('Ana');
    resultado = 'Logout realizado com sucesso';
  } catch (err) {
    resultado = 'Falha no logout: $err';
  } finally {
    resultado += ' (finally executado)';
  }
  return resultado;
}

void main() => runApp(const MaterialApp(home: Atividade2()));

class Atividade2 extends StatefulWidget {
  const Atividade2({super.key});
  @override
  State<Atividade2> createState() => _Atividade2State();
}

class _Atividade2State extends State<Atividade2> {
  late final Future<String> _username;
  late final Future<String> _logout;

  @override
  void initState() {
    super.initState();
    _username = changeUsername();
    _logout = logoutUser();
  }

  Widget _tile(String titulo, Future<String> future) => FutureBuilder<String>(
        future: future,
        builder: (context, snap) => ListTile(
          title: Text(titulo),
          subtitle: Text(snap.connectionState != ConnectionState.done
              ? 'Carregando...'
              : snap.hasError
                  ? 'Erro não tratado: ${snap.error}'
                  : snap.data!),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Atividade 2 - tratamento de erros')),
        body: ListView(children: [
          _tile('Parte 1: changeUsername()', _username),
          _tile('Parte 2: logoutUser()', _logout),
        ]),
      );
}
