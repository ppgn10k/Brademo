/// Atividade 5: Cadastro de Residências e Operador em Cascata 

import 'dart:io';

class House {
  int id;
  String name;
  double price;

  House(this.id, this.name, this.price);

  void exibirDetalhes() {
    print("ID: $id | Nome: $name | Preço: R\$ ${price.toStringAsFixed(2)}");
  }
}

void main() {
  List<House> casas = [];

  for (int i = 1; i <= 3; i++) {
    print("--- Cadastro da Casa $i ---");
    
    stdout.write("Digite o ID: ");
    int id = int.parse(stdin.readLineSync()!);

    stdout.write("Digite o Nome da casa: ");
    String name = stdin.readLineSync()!;

    stdout.write("Digite o Preço: ");
    double price = double.parse(stdin.readLineSync()!);

    casas.add(House(id, name, price));
    print("");
  }

  // Aplicação da notação em cascata, para alterar uma propriedade de cada casa
  for (var casa in casas) {
    casa..name = "${casa.name} (Cadastrada)";
  }

  print("=== Lista de Casas Cadastradas ===");
  // Exibição utilizando a estrutura for-in
  for (var casa in casas) {
    casa.exibirDetalhes();
  }
}