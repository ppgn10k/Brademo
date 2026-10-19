import 'package:flutter/material.dart';

// ===== Funções "fornecidas" (no codelab elas já vêm prontas no DartPad) =====
Future<String> fetchRole() =>
    Future.delayed(const Duration(seconds: 1), () => 'administrator');

Future<int> fetchLoginAmount() =>
    Future.delayed(const Duration(seconds: 1), () => 42);

// ===== SOLUÇÕES =====

// Parte 1: usar async + await para obter o papel do usuário.
Future<String> reportUserRole() async {
  final role = await fetchRole(); // pausa aqui até o Future completar
  return 'User role: $role';
}

// Parte 2: mesma ideia, com um Future<int>.
Future<String> reportLogins() async {
  final logins = await fetchLoginAmount();
  return 'Total number of logins: $logins';
}

// ===== Interface para mostrar os resultados =====
void main() => runApp(const MaterialApp(home: Atividade1()));

class Atividade1 extends StatefulWidget {
  const Atividade1({super.key});
  @override
  State<Atividade1> createState() => _Atividade1State();
}

class _Atividade1State extends State<Atividade1> {
  // Futures criados uma única vez (initState), nunca dentro do build().
  late final Future<String> _role;
  late final Future<String> _logins;

  @override
  void initState() {
    super.initState();
    _role = reportUserRole();
    _logins = reportLogins();
  }

  Widget _tile(String titulo, Future<String> future) => FutureBuilder<String>(
        future: future,
        builder: (context, snap) => ListTile(
          title: Text(titulo),
          subtitle: Text(snap.connectionState != ConnectionState.done
              ? 'Carregando...'
              : snap.hasError
                  ? 'Erro: ${snap.error}'
                  : snap.data!),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Atividade 1 - async/await')),
        body: ListView(children: [
          _tile('Parte 1: reportUserRole()', _role),
          _tile('Parte 2: reportLogins()', _logins),
        ]),
      );
}
