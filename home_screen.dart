import 'package:flutter/material.dart';
import '../models/item_decoracao.dart';
import 'item_detail_screen.dart';
import 'cadastro_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ItemDecoracao> itens = [
    ItemDecoracao(
      id: 1,
      titulo: 'Poltrona Nordic Wood',
      categoria: 'Salas',
      preco: 1290.00,
      descricao: 'Poltrona com estrutura em madeira maciça e estofamento ergonómico.',
      imagemUrl: 'https://picsum.photos/300/200?random=1',
    ),
    ItemDecoracao(
      id: 2,
      titulo: 'Luminária Industrial Gold',
      categoria: 'Iluminação',
      preco: 349.90,
      descricao: 'Luminária de piso articulável com acabamento em latão escovado.',
      imagemUrl: 'https://picsum.photos/300/200?random=2',
    ),
    ItemDecoracao(
      id: 3,
      titulo: 'Mesa de Centro Rústica',
      categoria: 'Salas',
      preco: 850.00,
      descricao: 'Mesa de centro artesanal feita com madeira de demolição.',
      imagemUrl: 'https://picsum.photos/300/200?random=3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // [RC7] AppBar
      appBar: AppBar(
        title: const Text('Home Decor - Catálogo'),
      ),
      // [RC5] Responsividade com LayoutBuilder
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Exibição em Grade para ecrãs mais largos / paisagem
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: itens.length,
              itemBuilder: (context, index) => _buildCard(itens[index]),
            );
          } else {
            // Exibição em Lista para ecrãs de telemóvel normais
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: itens.length,
              itemBuilder: (context, index) => _buildCard(itens[index]),
            );
          }
        },
      ),
      // [RC7] FloatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CadastroScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      // [RC7] BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categorias'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  Widget _buildCard(ItemDecoracao item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.imagemUrl,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(item.titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${item.categoria}\nR\$ ${item.preco.toStringAsFixed(2)}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // [RC2, RC3] Navegação e Passagem de Parâmetros
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailScreen(item: item),
            ),
          );
        },
      ),
    );
  }
}