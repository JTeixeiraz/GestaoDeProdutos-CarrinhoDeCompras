import 'dart:io';

void main(List<String> arguments) {
  print('Hello world: !');
}

class Produto{
  late final String? nome;
  late final double? preco;
  late final int? quantidadeEmEstoque;
  late String descricao;

  Produto(this.nome, this.preco, this.quantidadeEmEstoque);

  void vender(int quantidade){
    
  }
}