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

  group('Deve testar todos os serviços da API Aluno.', () {
    {
      test('01-Deve testar a inclusão de aluno.', () async {
        //Arrange

        Map alunoMap = {
          "id": "2023204776_008",
          "nome": "Márcio Amoêdo",
          "cpf": "41856961249",
          "email": "2023204776@ifam.edu.br"
        };

        final resultadoEsperado = "Aluno incluído com sucesso.";

        //Act
        resposta = (await post(Uri.parse('http://10.0.0.103:8080/aluno'),
            body: json.encode(alunoMap), headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData['message'], resultadoEsperado);
      });
      test('02-Deve invalidar a inclusão de aluno com o mesmo Id', () async {
        //Arrange

        Map alunoMap = {
          "id": "2023204776_008",
          "nome": "Márcio Amoêdo",
          "cpf": "41856961249",
          "email": "2023204776@ifam.edu.br"
        };

        final resultadoEsperado = "Aluno já cadastrado.";

        //Act
        resposta = (await post(Uri.parse('http://10.0.0.103:8080/aluno'),
            body: json.encode(alunoMap), headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData['message'], resultadoEsperado);
      });
      test('03-Invalidar a inclusão de um NOVO Aluno com CPF Inválido',
          () async {
        //Arrange
        Map alunoMap = {
          "id": "2023204776_009",
          "nome": null,
          "cpf": "41856961250",
          "email": null
        };

        final resultadoEsperado = "Falha na inclusão: CPF inválido.";

        //Act
        resposta = (await post(Uri.parse('http://10.0.0.103:8080/aluno'),
            body: json.encode(alunoMap), headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData['message'], resultadoEsperado);
      });

      test(
          '04-invalidar na inclusão, um NOVO aluno com CPF válido com os campos nulos',
          () async {
        //Arrange
        Map alunoMap = {
          "id": "2023204776_009",
          "nome": null,
          "cpf": "41856961249",
          "email": null
        };

        final resultadoEsperado = "Os campos nome ou email são obrigatórios.";

        //Act
        resposta = (await post(Uri.parse('http://10.0.0.103:8080/aluno'),
            body: json.encode(alunoMap), headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData['message'], resultadoEsperado);
      });
      test('05-Deve obter Aluno existente pelo Id', () async {
        //Arrange
        final matrAluno = "2023204776_001";

        final resultadoEsperado = "2023204776_001";

        //Act
        resposta = (await get(
            Uri.parse('http://10.0.0.103:8080/aluno/$matrAluno'),
            headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData['id'], resultadoEsperado);
      });
      test('06-Deve verificar Aluno inexistente pelo Id', () async {
        //Arrange
        final matrAluno = "2023204776_666";

        //Act
        resposta = (await get(
            Uri.parse('http://10.0.0.103:8080/aluno/$matrAluno'),
            headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData['id'], null);
      });
      test('07-Deve atualizar aluno existente com CPF válido.', () async {
        //Arrange
        Map alunoMap = {
          "id": "2023204776_002",
          "nome": "Márcio Amoêdo",
          "cpf": "00000000191",
          "email": "2023204776@ifam.edu.br"
        };

        final resultadoEsperado = "Aluno alterado com sucesso.";

        //Act
        resposta = (await put(Uri.parse('http://10.0.0.103:8080/aluno'),
            body: json.encode(alunoMap), headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData['message'], resultadoEsperado);
      });
      test('08-Deve invalidar atualização de aluno inexistente com CPF válido',
          () async {
        //Arrange
        Map alunoMap = {
          "id": "2024123456_200",
          "nome": "Maria Clara",
          "cpf": "57014540297",
          "email": "maria@gmail.com"
        };

        final resultadoEsperado = "Falha na alteração: aluno não existe.";

        //Act
        resposta = (await put(Uri.parse('http://10.0.0.103:8080/aluno'),
            body: json.encode(alunoMap), headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData['message'], resultadoEsperado);
      });
      test('09-Deve invalidar exclusão de aluno inexistente', () async {
        //Arrange
        final matrAluno = "2023204776_666";

        final resultadoEsperado = "Falha na deleção: aluno não existe.";

        //Act
        resposta = (await delete(
            Uri.parse('http://10.0.0.103:8080/aluno/$matrAluno'),
            headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData['message'], resultadoEsperado);
      });

      test('10-Deve verificar a exclusão do Aluno existente', () async {
        //Arrange
        final matrAluno = "2023204776_008";

        final resultadoEsperado = "Aluno deletado com sucesso.";

        //Act
        resposta = (await delete(
            Uri.parse('http://10.0.0.103:8080/aluno/$matrAluno'),
            headers: headers));

        resultado = utf8.decode(resposta.bodyBytes);
        var resultadoData = json.decode(resultado);

        //Assert
        expect(resultadoData['message'], resultadoEsperado);
      });
    }
  });
}
