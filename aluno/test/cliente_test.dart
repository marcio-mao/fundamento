import 'dart:convert';
import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  late Map<String, String> headers;
  late Response resposta;
  late String resultado;

  setUp(() {
    headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
  });

  group('Deve testar todos os serviços da API Cliente.', () {
    {
      test('01- Inserir Cliente com CPF válido', () async {
        //Arrange

        Map clienteMap = {
          "id": "2023204776_001",
          "nome": "Márcio Amoêdo",
          "cpf": "41856961249",
          "email": "2023204776@ifam.edu.br"
        };

        Map resultadoEsperado = {
          "id": "2023204776_001",
          "status": 1,
          "message": "Cliente incluído com sucesso."
        };

        //Act
        resposta = (await post(Uri.parse('http://10.0.0.103:8080/cliente'),
            body: json.encode(clienteMap), headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData, resultadoEsperado);
      });
      test('02-Deve invalidar a inclusão de Cliente com o mesmo Id', () async {
        //Arrange

        Map clienteMap = {
          "id": "2023204776_001",
          "nome": "Márcio Amoêdo",
          "cpf": "41856961249",
          "email": "2023204776@ifam.edu.br"
        };

        Map resultadoEsperado = {
          "id": "2023204776_001",
          "status": 3,
          "message": "Cliente já cadastrado."
        };
        //Act
        resposta = (await post(Uri.parse('http://10.0.0.103:8080/cliente'),
            body: json.encode(clienteMap), headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData, resultadoEsperado);
      });
      test('03-Invalidar a inclusão de um NOVO Cliente com CPF Inválido.',
          () async {
        //Arrange
        Map clienteMap = {
          "id": "2023204776_002",
          "nome": "Márcio Amoêdo",
          "cpf": "41856961250",
          "email": "2023204776@ifam.edu.br"
        };
        Map resultadoEsperado = {
          "id": "2023204776_002",
          "status": 3,
          "message": "Falha na inclusão: CPF inválido."
        };

        //Act
        resposta = (await post(Uri.parse('http://10.0.0.103:8080/cliente'),
            body: json.encode(clienteMap), headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData, resultadoEsperado);
      });
      test(
          '04-Deve invalidar na inclusão, um NOVO Cliente com todos os campos nulos.',
          () async {
        //Arrange
        Map alunoMap = {"id": null, "nome": null, "cpf": null, "email": null};

        Map resultadoEsperado = {
          "id": null,
          "status": 3,
          "message": "Todos os campos são obrigatórios."
        };

        //Act
        resposta = (await post(Uri.parse('http://10.0.0.103:8080/cliente'),
            body: json.encode(alunoMap), headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData, resultadoEsperado);
      });
      test('05-Deve obter Cliente existente pelo Id', () async {
        //Arrange
        final matrCliente = "2023204776_001";

        Map resultadoEsperado = {
          "id": "2023204776_001",
          "nome": "Márcio Amoêdo",
          "cpf": "41856961249",
          "email": "2023204776@ifam.edu.br"
        };

        //Act
        resposta = (await get(
            Uri.parse('http://10.0.0.103:8080/cliente/$matrCliente'),
            headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData, resultadoEsperado);
      });
      test('06-Deve verificar Cliente inexistente pelo Id', () async {
        //Arrange
        final matrCliente = "2023204776_200";
        Map resultadoEsperado = {
          "id": null,
          "nome": null,
          "cpf": null,
          "email": null
        };

        //Act
        resposta = (await get(
            Uri.parse('http://10.0.0.103:8080/cliente/$matrCliente'),
            headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData, resultadoEsperado);
      });
      test('07-Deve atualizar Cliente existente com CPF válido.', () async {
        //Arrange
        Map alunoMap = {
          "id": "2023204776_001",
          "nome": "Márcio Amoêdo",
          "cpf": "00000000191",
          "email": "2023204776@ifam.edu.br"
        };

        Map resultadoEsperado = {
          "id": "2023204776_001",
          "status": 1,
          "message": "Cliente alterado com sucesso."
        };

        //Act
        resposta = (await put(Uri.parse('http://10.0.0.103:8080/cliente'),
            body: json.encode(alunoMap), headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData, resultadoEsperado);
      });
      test(
          '08-Deve invalidar atualização de Cliente inexistente com CPF válido',
          () async {
        //Arrange
        Map alunoMap = {
          "id": "2024123456_200",
          "nome": "Maria Clara",
          "cpf": "57014540297",
          "email": "maria@gmail.com"
        };

        Map resultadoEsperado = {
          "id": "2024123456_200",
          "status": 3,
          "message": "Falha na alteração: cliente não existe."
        };

        //Act
        resposta = (await put(Uri.parse('http://10.0.0.103:8080/cliente'),
            body: json.encode(alunoMap), headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData, resultadoEsperado);
      });
      test('09-Deve invalidar exclusão de Cliente inexistente', () async {
        //Arrange
        final matrCliente = "2023204776_200";

        Map resultadoEsperado = {
          "id": "2023204776_200",
          "status": 3,
          "message": "Falha na deleção: cliente não existe."
        };

        //Act
        resposta = (await delete(
            Uri.parse('http://10.0.0.103:8080/cliente/$matrCliente'),
            headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData, resultadoEsperado);
      });

      test('10-Deve verificar a exclusão do Cliente existente', () async {
        //Arrange
        final matrCliente = "2023204776_001";

        Map resultadoEsperado = {
          "id": "2023204776_001",
          "status": 1,
          "message": "Cliente deletado com sucesso."
        };

        //Act
        resposta = (await delete(
            Uri.parse('http://10.0.0.103:8080/cliente/$matrCliente'),
            headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData, resultadoEsperado);
      });
    }
  });
}
