import 'dart:convert';
import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  late Map<String, String> headers;
  late Response resposta;
  late Map userMap;
  late String resultado;
  late Map resultadoEsperado;

  setUp(() {
    headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
  });

  Map montarMapUsuario(
      int? id, String nome, String login, String? senha, String email) {
    Map mapUsuario = {
      'id': id,
      'nome': nome,
      'login': login,
      'senha': senha,
      'email': email
    };
    return mapUsuario;
  }

  Map montarMensagemRetorno(int? id, int status, String message) {
    Map mensagem = {'id': id, 'status': status, 'message': message};
    return mensagem;
  }

  group('Deve testar todos os serviços da API Usuário.', () {
    {
/*
      test('Deve testar a inclusão de usuário.', () async {
        //Arrange
        userMap = montarMapUsuario(
            null, 'Marcio Amoedo', 'amoedo', '1234', '2023204776@ifam.edu.br');
      
        resultadoEsperado =
            montarMensagemRetorno(18, 1, 'Usuário incluído com sucesso...');
      
        //Act
        resposta = (await post(Uri.parse('http://10.0.0.103:8080/user'),
            body: json.encode(userMap), headers: headers));
      
        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);
      
        //Assert
        expect(resultadoEsperado, resultadoData as Map);
      });
*/
      test('Deve testar a alteração de usuário.', () async {
        //Arrange
        userMap = montarMapUsuario(
            18, 'Marcio Amoedo', 'marcio', '1234', '2023204776@ifam.edu.br');

        resultadoEsperado =
            montarMensagemRetorno(18, 1, 'Usuário alterado com sucesso...');

        //Act
        resposta = (await put(Uri.parse('http://10.0.0.103:8080/user'),
            body: json.encode(userMap), headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoEsperado, resultadoData as Map);
      });

      test('Deve verificar usuário pelo ID.', () async {
        //Arrange
        Map resultadoEsperado = {
          'id': 18,
          'nome': 'Marcio Amoedo',
          'login': 'marcio',
          'email': '2023204776@ifam.edu.br'
        };
        //Act
        resposta = (await get(Uri.parse('http://10.0.0.103:8080/user/18'),
            headers: headers));
        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoEsperado, resultadoData as Map);
      });

      test('Deve verificar usuário de ID inválido', () async {
        //Arrange
        final myid = 19999; // ID invalido
        //Act
        resposta = (await get(Uri.parse('http://10.0.0.103:8080/user/$myid'),
            headers: headers));
        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData['status'], 400);
      });

      test('Deve verificar usuário login é valido', () async {
        //Arrange
        final login = 'marcio'; // login válido
        final senha = '1234'; // senha valida
        //Act
        resposta = (await post(
            Uri.parse('http://10.0.0.103:8080/user/validarLogin/$login/$senha'),
            headers: headers));
        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData['login'], login);
      });

      test('Deve verificar usuário de ID foi deletado', () async {
        //Arrange
        final delId = 42; // ID invalido

        //Act
        resposta = (await delete(
            Uri.parse('http://10.0.0.103:8080/user/$delId'),
            headers: headers));
        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData['status'], 1);
      });
    }
  });
}
