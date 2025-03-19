import 'dart:io';

void main(List<String> arguments) {
  
}

class Produto{
  final String? nome;
  final double? preco;
  late int? _quantidadeEmEstoque;
  late String? _descricao;

  Produto(this.nome, this.preco);

  get getDescricao => _descricao;
  set setDescricao(String? descricao){
    _descricao = descricao;
  }

  get getQuantidade => _quantidadeEmEstoque;
  set setQuantidade(int? quant){
    _quantidadeEmEstoque = quant;
  }

  void vender(){
    print('Quanto deseja vender/reduzir do estoque');
    String? valVenda = stdin.readLineSync()??"";
    int valIntVenda = int.parse(valVenda);
    if(valIntVenda > getQuantidade){
      print('valor maior que o estoque atual');
    }else{
      setQuantidade = getQuantidade - valIntVenda;
    }
  }

  void reporEstoque(){
    
  }
}
