import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class Lugar {
  final String cidade;
  final String nome;
  final String imagem;
  const Lugar(this.cidade, this.nome, this.imagem);
}

const lugares = <Lugar>[
  Lugar('Chennai', 'Flower Market', 'https://picsum.photos/seed/flower/400/400'),
  Lugar('Tanjore', 'Bronze Works', 'https://picsum.photos/seed/bronze/400/400'),
  Lugar('Tanjore', 'Market', 'https://picsum.photos/seed/market/400/400'),
  Lugar('Tanjore', 'Thanjavur Temple', 'https://picsum.photos/seed/temple/400/400'),
  Lugar('Tanjore', 'Thanjavur Temple', 'https://picsum.photos/seed/temple2/400/400'),
  Lugar('Pondicherry', 'Salt Farm', 'https://picsum.photos/seed/salt/400/400'),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercício 1 - GridView',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const GaleriaPage(),
    );
  }
}

class GaleriaPage extends StatelessWidget {
  const GaleriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galeria')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: lugares.length,
        itemBuilder: (context, index) => LugarTile(lugar: lugares[index]),
      ),
    );
  }
}

class LugarTile extends StatelessWidget {
  final Lugar lugar;
  const LugarTile({super.key, required this.lugar});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            lugar.imagem,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stack) => Container(
              color: Colors.grey.shade300,
              child: const Icon(Icons.broken_image, size: 40),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.black45,
              padding: const EdgeInsets.all(8),
              child: Text(
                '${lugar.cidade}\n${lugar.nome}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
