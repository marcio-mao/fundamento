import 'dart:convert';

import 'package:http/http.dart';
import 'package:venda/interface/user_controller.dart';

class AcessoApiUsuario implements UserController {
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Future<String> deleteUser(int id) async {
    var resultUser = await delete(Uri.parse('http://localhost:8080/user/$id'),
        headers: headers);
    return utf8.decode(resultUser.bodyBytes).toString();
  }

  @override
  Future<String> getAllUser() async {
    var resultUser = await get(Uri.parse('http://localhost:8080/user/list'),
        headers: headers);
    return utf8.decode(resultUser.bodyBytes).toString();
  }

  @override
  Future<String> getUserById(int id) async {
    var resultUser = await get(Uri.parse('http://localhost:8080/user/$id'),
        headers: headers);
    return utf8.decode(resultUser.bodyBytes).toString();
  }

  @override
  Future<String> saveUser(String requestBodyJSON) async {
    final String retorno;
    final userMap = json.decode(requestBodyJSON);
    final resultUser = await post(Uri.parse('http://localhost:8080/user'),
        body: json.encode(userMap), headers: headers);
    retorno = utf8.decode(resultUser.bodyBytes);
    return retorno; //utf8.decode(resultUser.bodyBytes);
  }

  Future<String> saveUserAsync(String requestBodyJSON) async {
    print('Entrou 2');
    final String retorno;
    final userMap = json.decode(requestBodyJSON);
    final resultUser = await post(Uri.parse('http://localhost:8080/user'),
        body: json.encode(userMap), headers: headers);
    retorno = resultUser.body;
    print('retorno: $retorno');
    return retorno; //utf8.decode(resultUser.bodyBytes);
  }

  @override
  Future<String> updateUser(String requestBodyJSON) async {
    final userMap = json.decode(requestBodyJSON);
    var resultUser = await put(Uri.parse('http://localhost:8080/user'),
        body: json.encode(userMap), headers: headers);
    return utf8.decode(resultUser.bodyBytes).toString();
  }

  @override
  Future<String> validateLogin(String login, String password) async {
    var resultUser = await post(
        Uri.parse('http://localhost:8080/user/validarLogin/$login/$password'),
        headers: headers);
    return utf8.decode(resultUser.bodyBytes).toString();
  }
}
