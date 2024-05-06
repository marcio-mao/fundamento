
import 'package:calculadora/calculadora.dart';
import 'package:test/test.dart';

void main() {
  Calculadora calculadora = Calculadora();
  test('Deve retornar o valor da soma', () {
    // Preparação
    double resultado = 0.0;
    // Execução
    resultado = calculadora.soma(10, 5);
    // Verificação ou Validação
    expect(resultado, 15);
  });
  test('Deve retornar o valor da subtração', () {
    // Preparação
    double resultado = 0.0;
    // Execução
    resultado = calculadora.diferenca(10, 5);
    // Verificação ou Validação
    expect(resultado, 5);
  });
  test('Deve retornar o valor da multiplicação', () {
    // Preparação
    double resultado = 0.0;
    // Execução
    resultado = calculadora.produto(10, 5);
    // Verificação ou Validação
    expect(resultado, 50);
  });
  test('Deve retornar o valor da divisão', () {
    // Preparação
    double resultado = 0.0;
    // Execução
    resultado = calculadora.quociente(10, 5);
    // Verificação ou Validação
    expect(resultado, 2);
  });
/*
  test('Deve retornar o valor da divisão/0', () {
    // Preparação
    String mensagemExcecao = 'Erro: Divisão por ZERO.';
    String erro='';
    // Execução
    try {
      calculadora.quociente(10, 0); // Dividindo por zero
    } catch (e) {
      erro = e.toString();
    }
    // Verificação ou Validação
    expect(erro.replaceAll('Exception: ', ''), mensagemExcecao);
  });
*/
  test('Deve retornar o valor da divisão/0 usando callback', () {
    // Preparação
    String mensagemExcecao = 'Erro: Divisão por ZERO.';
    // Execução
    call() => calculadora.quociente(10, 0); // Dividindo por zero
    // Verificação ou Validação
    expect (
      call,
        throwsA(predicate(
          (e) => e is FormatException && e.message == mensagemExcecao))
    );
  });
  test('Deve retornar o valor da divisão com 2 negativos', () {
    // Preparação
    double resultado = 0.0;
    // Execução
    resultado = calculadora.quociente(-10, -5);
    // Verificação ou Validação
    expect(resultado, 2);
  });
  test('Deve retornar o valor da divisão com 1 negativo', () {
    // Preparação
    double resultado = 0.0;
    // Execução
    resultado = calculadora.quociente(10, -5);
    // Verificação ou Validação
    expect(resultado, -2);
  });
  test('Deve retornar o valor da potencia na base x', () {
    // Preparação
    num resultado = 0.0;
    // Execução
    resultado = calculadora.potencia(2, 3);
    // Verificação ou Validação
    expect(resultado, 8);
  });
  test('Deve retornar o valor da raiz quadrada de x', () {
    // Preparação
    double resultado = 0.0;
    // Execução
    resultado = calculadora.raizquad(9);
    // Verificação ou Validação
    expect(resultado, 3);
  });
  test('Deve retornar o valor da potencia na base 0', () {
    // Preparação
    num resultado = 0.0;
    // Execução
    resultado = calculadora.potencia(2, 0);
    // Verificação ou Validação
    expect(resultado, 1);
  });
  test('Deve retornar o módulo do valor positivo', () {
    // Preparação
    num resultado = 0.0;
    // Execução
    resultado = calculadora.modulo(5);
    // Verificação ou Validação
    expect(resultado, 5);
  });
    test('Deve retornar o módulo do valor negativo', () {
    // Preparação
    num resultado = 0.0;
    // Execução
    resultado = calculadora.modulo(-5);
    // Verificação ou Validação
    expect(resultado, 5);
  });
}
