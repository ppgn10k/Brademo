import 'package:flutter/material.dart';

// Exercício 3 - Restrições de layout ("Constraints go down. Sizes go up.
// Parent sets position."). Baseado nos exemplos de:
// https://docs.flutter.dev/ui/layout/constraints
// Toque em cada item da lista para ver o exemplo e a explicação.

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercício 3 - Constraints',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const ListaExemplos(),
    );
  }
}

class Exemplo {
  final String titulo;
  final String explicacao;
  final Widget Function() construir;
  const Exemplo(this.titulo, this.explicacao, this.construir);
}

Widget caixa({double? w, double? h, Color cor = Colors.red, Widget? filho}) =>
    Container(width: w, height: h, color: cor, child: filho);

const restricoes = BoxConstraints(minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150);

final exemplos = <Exemplo>[
  Exemplo(
    'Container vermelho simples',
    'O Container não tem filho nem tamanho, então se expande ao máximo permitido. '
        'A tela (body) impõe restrições "tight", logo ele preenche tudo.',
    () => Container(color: Colors.red),
  ),
  Exemplo(
    'Container 100x100 direto no body',
    'O pai (tela) força o tamanho exato. O Container pede 100x100, mas é ignorado: '
        'o filho DEVE obedecer às restrições do pai.',
    () => caixa(w: 100, h: 100),
  ),
  Exemplo(
    'Center + Container 100x100',
    'O Center "afrouxa" as restrições (min = 0). Agora o Container pode ter 100x100 '
        'e o Center o posiciona no meio.',
    () => Center(child: caixa(w: 100, h: 100)),
  ),
  Exemplo(
    'Align (bottomRight) + Container 100x100',
    'Align também afrouxa as restrições, mas quem define a posição é o pai (Align): '
        'aqui, canto inferior direito.',
    () => Align(alignment: Alignment.bottomRight, child: caixa(w: 100, h: 100)),
  ),
  Exemplo(
    'Center + Container infinito',
    'width/height = double.infinity pedem o máximo; o Container recebe o máximo '
        'permitido pelo Center, que é a tela inteira.',
    () => Center(child: caixa(w: double.infinity, h: double.infinity)),
  ),
  Exemplo(
    'Center + Container sem tamanho e sem filho',
    'Sem filho e sem tamanho, o Container se expande ao máximo permitido (a tela toda).',
    () => Center(child: caixa()),
  ),
  Exemplo(
    'Center + Container com filho 30x30',
    'Com filho, o Container se ajusta ao tamanho do filho (30x30).',
    () => Center(child: caixa(filho: caixa(w: 30, h: 30, cor: Colors.green))),
  ),
  Exemplo(
    'Container com padding 20 e filho 30x30',
    'O padding soma ao tamanho do filho: 20 + 30 + 20 = 70x70.',
    () => Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.red,
        child: caixa(w: 30, h: 30, cor: Colors.green),
      ),
    ),
  ),
  Exemplo(
    'ConstrainedBox direto no body',
    'As restrições do pai são "tight" e prevalecem sobre as do ConstrainedBox: '
        'o resultado preenche a tela.',
    () => ConstrainedBox(constraints: restricoes, child: caixa(w: 10, h: 10)),
  ),
  Exemplo(
    'Center + ConstrainedBox (filho 10x10)',
    'Restrições min 70 / max 150. O filho pede 10x10, mas o mínimo é 70: fica 70x70.',
    () => Center(child: ConstrainedBox(constraints: restricoes, child: caixa(w: 10, h: 10))),
  ),
  Exemplo(
    'Center + ConstrainedBox (filho 1000x1000)',
    'O filho pede 1000x1000, mas o máximo é 150: fica 150x150.',
    () => Center(child: ConstrainedBox(constraints: restricoes, child: caixa(w: 1000, h: 1000))),
  ),
  Exemplo(
    'Center + ConstrainedBox (filho 100x100)',
    '100 está entre o mínimo (70) e o máximo (150): o filho fica 100x100.',
    () => Center(child: ConstrainedBox(constraints: restricoes, child: caixa(w: 100, h: 100))),
  ),
  Exemplo(
    'UnconstrainedBox',
    'Remove as restrições do pai: o filho assume o tamanho que quiser (20x50).',
    () => UnconstrainedBox(child: caixa(w: 20, h: 50)),
  ),
  Exemplo(
    'Row com overflow',
    'A Row dá largura ilimitada para os filhos, mas a soma (600) é maior que a tela. '
        'O Flutter mostra a faixa amarela/preta de overflow (modo debug).',
    () => Row(children: [caixa(w: 300, h: 50), caixa(w: 300, h: 50, cor: Colors.green)]),
  ),
  Exemplo(
    'Row com Expanded',
    'Expanded divide o espaço restante proporcionalmente ao flex (2 : 1); '
        'o último filho tem largura fixa de 50.',
    () => Row(children: [
      Expanded(flex: 2, child: caixa()),
      Expanded(child: caixa(cor: Colors.green)),
      caixa(w: 50, cor: Colors.blue),
    ]),
  ),
  Exemplo(
    'Column + ListView com Expanded',
    'Solução 1: Expanded dá ao ListView uma altura finita (o espaço que sobra na Column).',
    () => Column(children: [
      const Text('My name'),
      const Text('My surname'),
      Expanded(child: ListView(children: const [Text('Skill 1'), Text('Skill 2')])),
    ]),
  ),
  Exemplo(
    'Column + ListView com shrinkWrap',
    'Solução 2: shrinkWrap: true reduz o ListView ao tamanho do conteúdo '
        '(mais custoso computacionalmente).',
    () => Column(children: [
      const Text('My name'),
      const Text('My surname'),
      ListView(shrinkWrap: true, children: const [Text('Skill 1'), Text('Skill 2')]),
    ]),
  ),
  Exemplo(
    'Column + ListView com SizedBox',
    'Solução 3: SizedBox com height fixa fornece a altura finita ao ListView.',
    () => Column(children: [
      const Text('My name'),
      const Text('My surname'),
      SizedBox(
        height: 200,
        child: ListView(children: const [Text('Skill 1'), Text('Skill 2')]),
      ),
    ]),
  ),
];

class ListaExemplos extends StatelessWidget {
  const ListaExemplos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layout Constraints')),
      body: ListView.builder(
        itemCount: exemplos.length,
        itemBuilder: (context, i) => ListTile(
          leading: CircleAvatar(child: Text('${i + 1}')),
          title: Text(exemplos[i].titulo),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => TelaExemplo(numero: i + 1, exemplo: exemplos[i])),
          ),
        ),
      ),
    );
  }
}

class TelaExemplo extends StatelessWidget {
  final int numero;
  final Exemplo exemplo;
  const TelaExemplo({super.key, required this.numero, required this.exemplo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exemplo $numero')),
      body: Column(
        children: [
          // O Expanded dá restrições "tight" ao exemplo, simulando o body da tela
          Expanded(child: exemplo.construir()),
          Container(
            width: double.infinity,
            color: Colors.blueGrey.shade50,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${exemplo.titulo}\n\n${exemplo.explicacao}',
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
