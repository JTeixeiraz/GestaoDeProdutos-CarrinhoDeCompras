import 'dart:io';

void main(List<String> arguments) {
  Estoque admin = Estoque();
  CarrinhoDeCompras user = CarrinhoDeCompras();
  print('Bem vindo ao sistema de compra e gerenciamento de estoque.');
  bool sair = false;
  while (!sair) {
    print('Digite o numero expecifico para entrar no login expecifico.');
    print('1- Admin (manipular e gerenciar estoque)');
    print('2- Usuario (Comprar e visualizar estoque)');
    print('3- Sair');
    String escolha = stdin.readLineSync()??"";
    switch (escolha) {
      case "1":
        print('Bem vindo ao Admin, oque deseja fazer?');
        bool deslogar = false;
        while(!deslogar){
          print('1- Adicionar produto ao estoque');
          print('2- Remover produto');
          print('3- vender');
          print('4- atualizar estoque');
          print('5- Voltar para o login');
          String? escolha = stdin.readLineSync()??"";
          switch (escolha) {
            case "1":
              admin.adicionarProduto();
              break;
            case "2":
              admin.removerProduto();
              break;
            case "3":
              admin.vender();
              break;
            case "4":
              admin.reporEstoque();
              break;
            case "5":
              deslogar = true;
              break;
            default:
          }
        }
      case "2":
        print('Bem vindo usuario!');
        bool deslogar = false;
        while (!deslogar){
          print('Digite o numero corespondente a ação que deseja fazer');
          print('1- Comprar');
          print('2- Abrir o carrinho');
          print('3- Voltar para a pagina de login');
          String escolha = stdin.readLineSync()??"";
          switch (escolha) {
            case "1":
              user.addCarrinho();
              break;
            case "2":
              user.exibirCarrinho();
              break;
            case "3":
              deslogar = true;
              break;
            default:
          }
        }
      case "3":
          sair = true;
        break;
      default:
    }
  }
}

class CarrinhoDeCompras{
  late List<Map<String, dynamic>> carrinho =[];

  void exibirCarrinho(){
    print('Seu carrinho:');
    print(carrinho);
    print('Oque deseja fazer? \n 1-Comprar \n 2-Sair');
    bool sair = false;
    String escolha = stdin.readLineSync()??"";
    while (!sair) {
      switch (escolha) {
        case "1":
          carrinho = [];
          print('Compra efetuada com sucesso');
          sair = true;
          break;
        case "2":
          sair = true;
          break;
        default:
      }
    }
  }

  void addCarrinho(){
    Estoque estoque = Estoque();
    print('Oque deseja fazer? \n 1-Exibir produtos \n 2-Comprar');
    String escolha = stdin.readLineSync()??"";
    switch (escolha) {
      case "1":
        if (estoque.estoque.isEmpty){
          print('Ainda não possuimos produtos disponiveis em nosso estoque');
          print('(Entre no usuario admin para poder modificar o estoque da empresa)');
        }else{
          print('Estoque disponivel:');
          print(estoque.estoque);
          print('============================');
        }
        break;
      case "2":
        print('Informe o nome do produto que deseja comprar');
          String name = stdin.readLineSync()?.toUpperCase()??"";
          bool encontrou = false;
          for (var i = 0; i < estoque.estoque.length; i++) {
            if (estoque.estoque[i]["nome"] == name) {
              print('Produto encontrado!');
              encontrou = true;
              print('Quantas unidades deste produto deseja comprar?');
              String quanti = stdin.readLineSync()??"";
              int? valQuanti = int.tryParse(quanti);
              if (estoque.estoque[i]["quantidade"]<valQuanti) {
                print('Você não pode comprar mais produtos doque os que estão disponiveis em estoque');
              }else{
                estoque.estoque[i]["quantidade"] = estoque.estoque[i]["quantidade"] = valQuanti;
              }
              double total = estoque.estoque[i]["preco"] * valQuanti;
              bool descAchada = false;
              for (var i = 0; i < estoque.descricao.length; i++) {
                if (estoque.descricao[i]["nome"] == name){
                  String descricao = estoque.descricao[i]["desc"];
                  carrinho.add({"nome":estoque.estoque[i]["nome"], "preco":estoque.estoque[i]["preco"], "quantidade":valQuanti, "precoTotal":total, "descricao":descricao});
                  descAchada = true;
                }
              }
              if (descAchada == false) {
                carrinho.add({"nome":estoque.estoque[i]["nome"], "preco":estoque.estoque[i]["preco"], "quantidade":valQuanti, "precoTotal":total});
                print('Produto adicionado ao seu carrinho');
              }
              print('Produto adicionado ao seu carrinho');
            }
          }
          if (encontrou == false) {
            print('Produto não encontrado, confira se você digitou corretamente o nome do produto.');
          }
        break;
      default:
    }
  }
}

class Estoque{
  List<Map<String, dynamic>>estoque = [];
  List<Map<String, dynamic>>descricao = [];
  int id = 0;

  void adicionarProduto(){
    print('digite o nome do produto que deseja adicionar:');
    String nome = stdin.readLineSync()?.toUpperCase()??"";
    for (var i = 0; i < estoque.length; i++) {
      if (estoque[i]["nome"] == nome) {
        print('Este produto já existe no estoque!');
      }else{
         print('Digite o preco do produto:');
          String preco = stdin.readLineSync()??"";
          double? precoval = double.tryParse(preco);
          Produto produto = Produto(nome, precoval);
          print('Deseja adicionar uma descrição no produto?');
          print('y/n');
          String? escolha = stdin.readLineSync()?.toUpperCase()??"";
          switch (escolha) {
            case "Y":
                print('Adicione a descrição do produto:');
                String desc = stdin.readLineSync()??"";
                print('Descrição adicionada ao produto ${produto.nome}');
                produto.setDescricao = desc;
                descricao.add({"nome":produto.nome, "desc": produto.getDescricao});
                print('Adicione a quantidade desse produto em estoque:');
                String? quant = stdin.readLineSync()??"";
                int? quantVal = int.tryParse(quant);
                produto.setQuantidade = quantVal;
              break;
            default:
            print('Adicione a quantidade desse produto em estoque:');
            String? quant = stdin.readLineSync()??"";
            int? quantVal = int.tryParse(quant);
            produto.setQuantidade = quantVal;
            break;
          }
          id++;
          print('Produto ${produto.nome} adicionado com o preço de \n${produto.preco} \nValor do produto em estoque: \n${produto.getQuantidade} \nId do produto: \n$id');
          estoque.add({"nome":produto.nome, "preco":produto.preco, "quantidade":produto.getQuantidade, "id":id});
      }
    }
  }

  void removerProduto(){
    print('Digite o nome do produto que deseja remover');
    String? name = stdin.readLineSync()?.toUpperCase()??"";
    bool encontrado = false;
    for (var i = 0; i < estoque.length; i++) {
      if (estoque[i]["nome"] == name) {
        encontrado =true;
        estoque.removeAt(i);
        print('Produto encontrado e removido com sucesso');
      }
    }
    if (encontrado == false) {
      print('Produto não encontrado');
    }
  }

  void vender(){
    print('Insira o nome do produto que deseja vender: \n(Não pode aver falhas de digitação)');
    String nome = stdin.readLineSync()?.toUpperCase()??"";
    bool encontrou = false;
    for (var i = 0; i < estoque.length; i++){
      if (estoque[i]["nome"] == nome) {
        print('Produto $nome encontrado');
        encontrou = true;
        print('Quantas unidades deste produto foram vendidas:');
        String vend = stdin.readLineSync()??"";
        int? valVend = int.tryParse(vend);
        if (estoque[i]["quantidade"] < valVend) {
          print('Excedendo o estoque!, não é possivel efetuar a venda de produtos alem dos que estão em estoque disponiveis!');
        }else{
          estoque[i]["quantidade"] = estoque[i]["quantidade"] - valVend;
          print('Venda efetuada com sucesso');
        }
      }
    }
    if (encontrou == false) {
      print("!Produto não encontrado, verifique se ele existe no estoque ou se a digitação foi correta!");
    }
  }

  void reporEstoque(){
    print('Oque deseja fazer?: \n 1-Atualizar estoque inteiro \n 2-Adicionar ao estoque atual \n 3-diminuir estoque \n 4-sair');
    String escolha = stdin.readLineSync()??"";
    switch (escolha) {
      case "1":
        print('Adicione o nome do produto que deseja atualizar o estoque: \n(Atenção, não pode haver erros de digitação)');
        String nomeatt = stdin.readLineSync()?.toUpperCase()??"";
        bool encontrou = false;
        for (var i = 0; i < estoque.length; i++){
          if(estoque[i]["nome"] == nomeatt){
            print('Produto encontrado');
            encontrou = true;
            print('O estoque atual do produto é: ${estoque[i]["quantidade"]}');
            print('Digite o valor que deseja atualizar');
            String estqe = stdin.readLineSync()??"";
            int? valEstoque = int.tryParse(estqe);
            if (valEstoque == null) {
              print('Digite um valor valido');
            }else{
              if (valEstoque < 0) {
                print('O valor do produto em estoque não pode ser negativo');
              }else{
                estoque[i]["quantidade"]=valEstoque;
              }
            }
          }
        }
        if(encontrou == false){
          print('Produto não encontrado');
        }
        break;
      case "2":
        print('Adicione o nome do produto que deseja incrementar ao estoque');
        String name = stdin.readLineSync()?.toUpperCase()??"";
        bool encontrou = false;
        for (var i = 0; i<estoque.length; i++){
          if (estoque[i]["nome"] == name) {
            print('produto encontrado');
            encontrou = true;
            print('O valor do estoque atual desse produto é: ${estoque[i]["quantidade"]}');
            print('Informe quanto deseja adicionar ao estoque do produto ${estoque[i]["nome"]}');
            String valoradd = stdin.readLineSync()??"";
            int? valValoradd = int.tryParse(valoradd);
            estoque[i]["quantidade"] = estoque[i]["quantidade"]+valValoradd;
            print('Produto ${estoque[i]["nome"]} alterado com sucesso, valor atual do estoque: ${estoque[i]["quantidade"]}'); 
          }
        }
        if(encontrou == false){
          print('produto não encontrado');
        }
        break;
      case "3":
        print('Informe o nome do produto que deseja subtrair o estoque');
        print('(Atenção, não pode haver erros de digitação)');
        String name = stdin.readLineSync()?.toUpperCase()??"";
        bool encontrou = false;
        for (var i =0; i<estoque.length; i++){
          if (estoque[i]["nome"] == name) {
            print('Produto encontrado no esotuqe');
            encontrou = true;
            print('Informe o valor que deseja subtrair do estoque atual do(a) ${estoque[i]["nome"]}');
            String estoquesub = stdin.readLineSync()??"";
            int? valEstoquesub = int.tryParse(estoquesub);
            if (valEstoquesub == null) {
              print('O valor não pode ser nulo');
            }else{
              if (valEstoquesub > estoque[i]["quantidade"]) {
                print('O valor inserido é maior que o que você possui em estoque, insira um valor que não deixe o estoque negativo!');
              }else{
                estoque[i]["quantidade"] = estoque[i]["quantidade"] - valEstoquesub;
              }
            }
          }
        }
        if(encontrou == false){
          print('Produto não encontrado no estoque');
        }
        break;
      case "4":
        print('');
        break;
      default:
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
}
