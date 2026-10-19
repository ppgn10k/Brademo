/// Atividade 1: Variáveis e Tipagem Dinâmica
/// 
/// Explicação sobre os tipos em Dart:
/// 
/// - 'patrimonio' foi declarada como 'dynamic', permitindo que o tipo da variável 
///   mudar tempo de execução (inicialmente 'int', depois atribuída com 'String').
/// - 'local' foi declarada com o tipo explícito 'String' (tipagem estática). O Dart 
///   garante que ela só aceite valores do tipo String durante toda a sua execução.

void main() {
  // Declarado com var 
  var equipamento = "Impressora 3D";
  
  // Declarado explicitamente como String
  String local = "Lab de Protótipos";
  
  // Declarado como dynamic 
  dynamic patrimonio = 12345;
  
  // Altera o valor e o tipo de int para String
  patrimonio = "12345-A";

  // Exibição dos valores
  print("Equipamento: $equipamento");
  print("Local: $local");
  print("Patrimônio: $patrimonio");

  // Verificação de tipos usando a palavra-chave 'is'
  print("equipamento é String? ${equipamento is String}");
  print("local é String? ${local is String}");
  print("patrimonio é String? ${patrimonio is String}");
}