import 'dart:convert';
import 'package:venda/acesso_api_usuario.dart';

void main() async {
  var usuarioController = AcessoApiUsuario();
  //var cep = AcessoApiCep();
  // Atenção: Montar a estrutura JSON
  // sem espaço em branco, no início ou fim,
  // por isso que a estrutura inicia na coluna 1,
  // sem espaço em branco no final.
  final String usuario = '''
{
"nome": "Nícolas Gonçalves",
"login": "nicolas",
"senha": "123456",
"email": "nicolas@gmail.com"
}''';
  final String usuarioUpdade = '''
{
"id":4,
"nome": "Maria Goncalves",
"login": "maria",
"senha": "999999",
"email": "maria@gmail.com"
}''';

  //final cepResultado = cep.obterEndereco('69037000');
  //print(cepResultado);

  // Inserir Dados
  print('Entrou 0');
  String resultado = await usuarioController.saveUser(usuario);
  print(resultado);
  print('Entrou 0.1');
  var resultadoData = json.decode(resultado);
  print(resultadoData['id']);
  print(resultadoData['status']);
  print(resultadoData['message']);

  // Listar Todos
  resultado = await usuarioController.getAllUser();
  resultadoData = json.decode(resultado);
  print(resultadoData);
  // Listar por ID
  resultado = await usuarioController.getUserById(4);
  resultadoData = json.decode(resultado);
  print(resultadoData['id']);
  print(resultadoData['nome']);
  print(resultadoData['login']);
  print(resultadoData['email']);
  // Atualizar Usuário
  resultado = await usuarioController.updateUser(usuarioUpdade);
  resultadoData = json.decode(resultado);
  print(resultadoData['id']);
  print(resultadoData['status']);
  print(resultadoData['message']);
  // Deletar Usuário
  resultado = await usuarioController.deleteUser(4);
  resultadoData = json.decode(resultado);
  print(resultadoData['id']);
  print(resultadoData['status']);
  print(resultadoData['message']);
  // Validar Login
  resultado = await usuarioController.validateLogin('admin', '123123');
  resultadoData = json.decode(resultado);
  print(resultadoData['id']);
  print(resultadoData['nome']);
  print(resultadoData['login']);
  print(resultadoData['email']);
}
