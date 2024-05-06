import 'package:venda/item.dart';

abstract class IItemRepository {
  Future<List<Item>> buscarTodos();
  List<Item> buscarTodosSync();
  Item buscarPorId(int id);
}

class ItemRepository implements IItemRepository {
  @override
  Item buscarPorId(int id) {
    return Item(nome: 'Arroz', quantidade: 3, preco: 6.30);
  }

  @override
  Future<List<Item>> buscarTodos() async {
    final itens = [
      Item(nome: 'Arroz', quantidade: 3, preco: 6.30),
      Item(nome: 'Feijão', quantidade: 2, preco: 7.50),
      Item(nome: 'Farinha Uarini', quantidade: 3, preco: 14.00)
    ];
    await Future.delayed(Duration(seconds: 1));
    return itens;
  }

  @override
  List<Item> buscarTodosSync() {
    final itens = [
      Item(nome: 'Arroz', quantidade: 3, preco: 6.30),
      Item(nome: 'Feijão', quantidade: 2, preco: 7.50),
      Item(nome: 'Farinha Uarini', quantidade: 3, preco: 14.00)
    ];
    return itens;
  }
}
