import 'package:calculadora/calculadora.dart';

void main() {
  Calculadora calculadora = Calculadora();
  try {
    print('O valor da Soma          (10 + 5) = ${calculadora.soma(10, 5)}');
    print(
        'O valor da Subtração     (10 - 5) = ${calculadora.diferenca(10, 5)}');
    print(
        'O valor da Divisão       (10 / 5) = ${calculadora.quociente(10, 0)}');
    print('O valor da Multiplicação (10 * 5) = ${calculadora.produto(10, 5)}');
  } catch (e) {
    print(e.toString());
  }
}
