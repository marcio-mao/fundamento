import 'package:http/http.dart';
import 'package:venda/interface/servico_cep.dart';

class AcessoApiCep implements ServicoCep {
  @override
  String obterEndereco(String cep) {
    return acessarApiCEP(cep).toString();
  }

  Future<String> acessarApiCEP(String cep) async {
    final String endereco;
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final result = await get(Uri.parse('https://viacep.com.br/ws/$cep/json/'),
        headers: headers);
    endereco = result.body;
    print(result.body);
    return endereco;
  }
}
