import 'dart:math';

import 'value.dart';

double randomMath(int x) {
  return pow(x, 3).toDouble();
}

void main() {
  final x1 = Value(2);
  final x2 = Value(0);

  final w1 = Value(-3);
  final w2 = Value(1);

  final b = Value(6.8813735870195432);

  final x1w1 = x1 * w1;
  final x2w2 = x2 * w2;

  final x1w1x2w2 = x1w1 + x2w2;

  final n = x1w1x2w2 + b;

  // var o = n.tanh();
  final o = ((n * 2).exp() - 1) / ((n * 2).exp() + 1);

  o.grad = 1;
  o.back();

  print(x1.grad);
  print(w1.grad);
  print(x2.grad);
  print(w2.grad);
}
