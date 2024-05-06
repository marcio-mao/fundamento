import 'package:test/test.dart';
import 'package:venda/carrinho_venda.dart';
import 'package:venda/item.dart';

void main() {
  //
  List<Item> itens = [];
  // Sempre executado antes de qualquer teste
  setUp(() {
    // Preparação para todos os testes
    itens = [
      Item(nome: 'Arroz', quantidade: 3, preco: 6.30),
      Item(nome: 'Feijão', quantidade: 2, preco: 7.50),
      Item(nome: 'Farinha Uarini', quantidade: 3, preco: 14.00)
    ];
  });
  group('Teste do cálculo do valor total do carrinho', () {
    test('Deve calcular o valor total do carrinho quando tiver vazio', () {
      // Preparação
      // Nenhum Item no carrinho
      final itens = <Item>[];
      final carrinho = CarrinhoVenda(listaItems: itens);
      // Execução
      var total = carrinho.totalCarrinho();
      // Verificação
      expect(total, 0.0);
    });
    test('Deve calcular o valor total do carrrinho com itens, sem desconto',
        () {
      // Preparação
      // Inserir elementos no carrinho
      final carrinho = CarrinhoVenda(listaItems: itens);
      double valorEsperado = 75.90;
      // Execução
      var total = carrinho.totalCarrinho();
      // Verificação
      expect(total.toStringAsFixed(2), valorEsperado.toStringAsFixed(2));
    });
  });
  group('Deve calcular o valor total do carrrinho com itens, com desconto', () {
    test('Deve calcular o valor total do carrrinho com itens, desconto 5%', () {
      // Preparação
      // Inserir elementos no carrinho
      final carrinho = CarrinhoVenda(listaItems: itens);
      double valorEsperado = 72.11;
      // Execução
      var total = carrinho.totalCarrinho(5);
      // Verificação
      expect(total.toStringAsFixed(2), valorEsperado.toStringAsFixed(2));
    });
    test('Deve calcular o valor total do carrrinho com itens, desconto 10%',
        () {
      // Preparação
      // Inserir elementos no carrinho
      final carrinho = CarrinhoVenda(listaItems: itens);
      double valorEsperado = 68.31;
      // Execução
      var total = carrinho.totalCarrinho(10);
      // Verificação
      expect(total.toStringAsFixed(2), valorEsperado.toStringAsFixed(2));
    });
    test('Deve calcular o valor total do carrrinho com itens, desconto 15%',
        () {
      // Preparação
      // Inserir elementos no carrinho
      final carrinho = CarrinhoVenda(listaItems: itens);
      double valorEsperado = 64.52;
      // Execução
      var total = carrinho.totalCarrinho(15);
      // Verificação
      expect(total.toStringAsFixed(2), valorEsperado.toStringAsFixed(2));
    });
  });
  group('Novos recursos para fazer testes', () {
    test('Deve verificar a quantidade de itens do carrinho', () {
      // Preparação
      // Execução
      final carrinho = CarrinhoVenda(listaItems: itens);
      // Verificação
      expect(carrinho.listaItems.length, 3);
    });
    test('Deve verificar se os elementos do carrinho são do tipo Item', () {
      // Preparação
      // Execução
      final carrinho = CarrinhoVenda(listaItems: itens);
      // Verificação
      expect(carrinho.listaItems, isA<List<Item>>());
    });
    test('Deve verificar se um determinado item está inserido no carrinho', () {
      // Preparação
      // Execução
      final carrinho = CarrinhoVenda(listaItems: itens);
      // Verificação
      expect(carrinho.listaItems,
          contains(Item(nome: 'Feijão', quantidade: 2, preco: 7.50)));
    });
  });
  group('Deve verifica as exceções customizadas.', () {
    test('Deve verificar as exceções customizada referente Item nome Vazio',
        () {
      // Preparação
      final itens = [
        Item(nome: 'Arroz', quantidade: 3, preco: 6.30),
        Item(nome: '', quantidade: 2, preco: 7.50),
        Item(nome: 'Farinha Uarini', quantidade: 3, preco: 14.00)
      ];
      final carrinho = CarrinhoVenda(listaItems: itens);
      // Execução
      call() => carrinho.totalCarrinho();
      // Verificação
      expect(
          () => call(), throwsA(predicate((e) => e is CarrinhoItemNomeVazio)));
    });
    test('Deve verificar as exceções customizada referente Qtde zero item', () {
      // Preparação
      final itens = [
        Item(nome: 'Arroz', quantidade: 3, preco: 6.30),
        Item(nome: 'Feijão', quantidade: 2, preco: 7.50),
        Item(nome: 'Farinha Uarini', quantidade: 0, preco: 14.00)
      ];
      final carrinho = CarrinhoVenda(listaItems: itens);
      // Execução
      call() => carrinho.totalCarrinho();
      // Verificação
      expect(() => call(),
          throwsA(predicate((e) => e is CarrinhoItemQuantidadeZero)));
    });
    test('Deve verificar as exceções customizada referente Preço zero item',
        () {
      // Preparação
      final itens = [
        Item(nome: 'Arroz', quantidade: 3, preco: 6.30),
        Item(nome: 'Feijão', quantidade: 2, preco: 7.50),
        Item(nome: 'Farinha Uarini', quantidade: 3, preco: 0)
      ];
      final carrinho = CarrinhoVenda(listaItems: itens);
      // Execução
      // Atibui a função carrinho.totalCarrinho para a variável call
      call() => carrinho.totalCarrinho();
      // Verificação
      expect(
          () => call(), throwsA(predicate((e) => e is CarrinhoItemPrecoZero)));
    });
    test('Deve verificar as exceções customizada referente Qtde Negativa', () {
      // Preparação
      final itens = [
        Item(nome: 'Arroz', quantidade: 3, preco: 6.30),
        Item(nome: 'Feijão', quantidade: 2, preco: 7.50),
        Item(nome: 'Farinha Uarini', quantidade: -3, preco: 14)
      ];
      final carrinho = CarrinhoVenda(listaItems: itens);
      // Execução
      // Atibui a função carrinho.totalCarrinho para a variável call
      call() => carrinho.totalCarrinho();
      // Verificação
      expect(() => call(),
          throwsA(predicate((e) => e is CarrinhoItemQuantidadeNegativo)));
    });
    test('Deve verificar as exceções customizada referente Preço Negativa', () {
      // Preparação
      final itens = [
        Item(nome: 'Arroz', quantidade: 3, preco: 6.30),
        Item(nome: 'Feijão', quantidade: 2, preco: 7.50),
        Item(nome: 'Farinha Uarini', quantidade: 3, preco: -2)
      ];
      final carrinho = CarrinhoVenda(listaItems: itens);
      // Execução
      // Atibui a função carrinho.totalCarrinho para a variável call
      call() => carrinho.totalCarrinho();
      // Verificação
      expect(() => call(),
          throwsA(predicate((e) => e is CarrinhoItemPrecoNegativo)));
    });
  });
}
