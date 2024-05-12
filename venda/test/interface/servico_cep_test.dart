import 'dart:convert';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:venda/interface/servico_cep.dart';

// Como usar o pacote do Mock
class ServicoCepFake extends Mock implements ServicoCep {}

void main() {
  // ServicoCep é uma interface
  late ServicoCep servicoCep;
  late String endereco;
  setUp(() {
    // Preparação para todos os testes
    servicoCep = ServicoCepFake();
    endereco = '''
{
  "cep": "69077-795",
  "logradouro": "Rua José de Alencar",
  "complemento": "",
  "bairro": "Japiim",
  "localidade": "Manaus",
  "uf": "AM",
  "ibge": "1302603",
  "gia": "",
  "ddd": "92",
  "siafi": "0255"
}
''';
  });
  group('Deve testar o serviço de CEP', () {
    test('Deve obter Endereço pelo CEP', () {
      // Preparação
      when(() => servicoCep.obterEndereco('69077795')).thenReturn(endereco);
      // Execução
      final enderecoResultado = servicoCep.obterEndereco('69077795');
      // Verificação
      expect(enderecoResultado, endereco);
    });
    test('Deve verificar se o endereço é do Amazonas', () {
      // Preparação
      when(() => servicoCep.obterEndereco('69077795')).thenReturn(endereco);
      // Execução
      final enderecoResultado = servicoCep.obterEndereco('69077795');
      // Transformar a String que está no formato JSON para a estrutura tipo Map
      // Dessa forma terá acesso a cada campo do endereço
      final enderecoData = json.decode(enderecoResultado);
      print(enderecoData.toString());
      // Verificação
      expect(enderecoData['uf'], 'AM');
    });
    test('Deve verificar se o endereço é de Manaus', () {
      // Preparação
      when(() => servicoCep.obterEndereco('69077795')).thenReturn(endereco);
      // Execução
      final enderecoResultado = servicoCep.obterEndereco('69077795');
      final enderecoData = json.decode(enderecoResultado);
      // Verificação
      expect(enderecoData['localidade'], 'Manaus');
    });
    test('Deve verificar se CEP é inválido', () {
      // Preparação
      endereco = '''
{
  "erro": true
}
''';
      when(() => servicoCep.obterEndereco('12345678')).thenReturn(endereco);
      // Execução
      final enderecoResultado = servicoCep.obterEndereco('12345678');
      final enderecoData = json.decode(enderecoResultado);
      // Verificação
      expect(enderecoData['erro'], true);
    });
    test('Deve testar cep invalido com numero de digitos diferente de 8',
        () async {
      // Preparação
      final cep = "12345"; // 6 dígitos
      // Execução
      final int rc;
      final headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      final result = await get(Uri.parse('https://viacep.com.br/ws/$cep/json/'),
          headers: headers);
      rc = result.statusCode;
      // Verificação
      expect(rc, 400);
    });
  });
}
