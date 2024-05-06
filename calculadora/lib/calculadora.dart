/*
                        Calculadora
Operações:
Adição       : 2 + 5 = 7 (2: parcela; 5: parcela; 7: soma)
Subtração    : 7 - 3 = 4 (7: aditivo; 3: subtrativo; 4: diferença)
Multiplicação: 4 x 2 = 8 (4: fator; 2: fator; 8: produto)
Divisão      : 6 / 3 = 2 (6: dividendo; 3: divisor; 2: quociente)
*/
import 'dart:math';

class Calculadora {
  double soma(double parcela1, double parcela2) {
    return parcela1 + parcela2;
  }

  double diferenca(double aditivo, double subtrativo) {
    return aditivo - subtrativo;
  }

  double produto(double fator1, double fator2) {
    return fator1 * fator2;
  }

  double quociente(double dividendo, double divisor) {
    if (divisor == 0) {
//      throw Exception('Erro: Divisão por ZERO.');
      throw FormatException('Erro: Divisão por ZERO.');
    } else {
      return dividendo / divisor;
    }
  }

  // Colocar potencia e raiz quadrada
  num potencia(double base, double expoente) {
    return pow(base, expoente);
  }

  double raizquad(double numero) {
    return sqrt(numero);
  }
  
  double modulo(double numero) {
    return numero.abs();
  }
}
