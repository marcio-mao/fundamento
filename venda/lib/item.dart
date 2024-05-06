// ignore_for_file: public_member_api_docs, sort_constructors_first
class Item {
  String nome;
  double quantidade;
  double preco;
  Item({
    required this.nome,
    required this.quantidade,
    required this.preco,
  });

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.nome == nome &&
        other.quantidade == quantidade &&
        other.preco == preco;
  }

  @override
  int get hashCode => nome.hashCode ^ quantidade.hashCode ^ preco.hashCode;
}
