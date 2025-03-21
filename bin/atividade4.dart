import 'dart:io';

void main(List<String> arguments) {


}
class Estoque{
  List<Map<String, dynamic>>estoque = [];

  void adicionarProduto(){
    print('digite o nome do produto que deseja adicionar:');
    String nome = stdin.readLineSync()??"";
    print('Digite o preco do produto:');
    String preco = stdin.readLineSync()??"";
    double? precoval = double.tryParse(preco);
    Produto produto = Produto(nome, precoval);
    print('Deseja adicionar uma descrição no produto?');
    print('y/n');
    String? escolha = stdin.readLineSync()?.toUpperCase()??"";
    switch (escolha) {
      case "Y":
            
        break;
      default:
      print('Adicione a quantidade desse produto em estoque:');
      String? quant = stdin.readLineSync()??"";
      int? quantVal = int.tryParse(quant);
      produto.setQuantidade = quantVal;
      print('Produto ${produto.nome} adicionado com o preço de \n${produto.preco} \nValor do produto em estoque: \n${produto.getQuantidade}');
      break;
    }
  }

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
    print('Oque deseja fazer?: \n 1-Atualizar estoque inteiro \n 2-Adicionar ao estoque atual \n 3-diminuir estoque');
    String escolha = stdin.readLineSync()??"";
    switch (escolha) {
      case "1":
        print('Digite o novo valor do estoque: ');
        String novo = stdin.readLineSync()??"";
        int? novoValor = int.tryParse(novo);
        setQuantidade = novoValor;
        print('Valor de estoque alterado para: $getQuantidade');
        break;
      case "2":
        print('Adicione o valor que deseja adicionar ao estoque atual: ');
        String novo = stdin.readLineSync()??"";
        int? novoValor = int.tryParse(novo);
        setQuantidade = getQuantidade + novoValor;
        print('Valor do estoque alterado para: $getQuantidade');
      break;
      case "3":
        print('Digite o valor que deseja diminuir do estoque:');
        String menos = stdin.readLineSync()??"";
        int? menosValor = int.tryParse(menos);
        setQuantidade = getQuantidade - menosValor;
      break;
      default:
    }
  }
}
