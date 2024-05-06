// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:venda/item.dart';
import 'package:venda/item_repository.dart';

class ItemService {
  IItemRepository repository;
  ItemService({
    required this.repository,
  });
  Future<List<Item>> buscarTodos() => repository.buscarTodos();
  List<Item> buscarTodosSync() => repository.buscarTodosSync();
  Item buscarPorId(int id) => repository.buscarPorId(id);
}
