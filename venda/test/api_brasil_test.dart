import 'dart:convert';
import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  late Map<String, String> headers;
  late Response resposta;
  late String resultado;
  late Map resultadoData;

  setUp(() {
    headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
  });
  group('Deve testar os serviços da APiBrasil', () {
    test('Deve verificar a Razão Social, com o CNPJ do IFAM', () async {
      //Arrange
      final ifamCnpj = '10792928000614';
      final razaoSocial = 'INSTITUTO FEDERAL DO AMAZONAS';

      //Act
      resposta = (await get(
          Uri.parse('https://brasilapi.com.br/api/cnpj/v1/$ifamCnpj'),
          headers: headers));
      resultado = utf8.decode(resposta.bodyBytes);
      resultadoData = json.decode(resultado);

      //Assert
      expect(resultadoData['razao_social'], razaoSocial);
    });
  });
}
