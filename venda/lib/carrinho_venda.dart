import 'package:venda/item.dart';

class CarrinhoVenda {
  final List<Item> listaItems;

  // Construtor
  CarrinhoVenda({required this.listaItems});

  // Calcular preço total do carrinho de venda
  double totalCarrinho([double valorDesconto = 0]) {
    double total = 0.0;

    for (var i = 0; i < listaItems.length; i++) {
      // Verificar as Exception
      if (listaItems[i].nome.isEmpty) {
        throw CarrinhoItemNomeVazio();
      }

      if (listaItems[i].quantidade == 0) {
        throw CarrinhoItemQuantidadeZero();
      }

      if (listaItems[i].preco == 0) {
        throw CarrinhoItemPrecoZero();
      }

      if (listaItems[i].quantidade < 0) {
        throw CarrinhoItemQuantidadeNegativo();
      }

      if (listaItems[i].preco < 0) {
        throw CarrinhoItemPrecoNegativo();
      }

      // Calcular o preço total do carrinho
      total += (listaItems[i].preco * listaItems[i].quantidade);
    }

    // Verificar e Calcular o desconto
    if (valorDesconto > 0) {
      if (valorDesconto == 5) {
        // calcular desconto de 5%
        total = total - (5 / 100 * total);
      }

      if (valorDesconto == 10) {
        // calcular desconto de 10%
        total = total - (10 / 100 * total);
      }

      if (valorDesconto == 15) {
        // calcular desconto de 15%
        total = total - (15 / 100 * total);
      }
    }

    return total;
  }
}

// Customizar as Exception

// Exception: Se o nome do item for vazio
class CarrinhoItemNomeVazio implements Exception {}

// Exception: Se a quantiddade do item for Zero
class CarrinhoItemQuantidadeZero implements Exception {}

// Exception: Se o preço do item for Zero
class CarrinhoItemPrecoZero implements Exception {}

// Exception: Se o preço do item for Zero
class CarrinhoItemPrecoNegativo implements Exception {}

// Exception: Se a quantiddade do item for Zero
class CarrinhoItemQuantidadeNegativo implements Exception {}
