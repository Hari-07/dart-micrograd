import 'dart:math';

import 'value.dart';

double randomMath(int x) {
  return pow(x, 3).toDouble();
}

void main() {
  // final a = Value(2);
  // final b = Value(-3);
  // final c = Value(10);

  // final e = a * b;
  // final d = e + c;

  // final f = Value(-2);

  // final L = d * f;

  // print(L);

  var x1 = Value(2);
  var x2 = Value(0);

  var w1 = Value(-3);
  var w2 = Value(1);

  var b = Value(6.8813735870195432);

  var x1w1 = x1 * w1;
  var x2w2 = x2 * w2;

  var x1w1x2w2 = x1w1 + x2w2;

  var n = x1w1x2w2 + b;

  var o = n.tanh();

  o.grad = 1;
  o.back();

  print(x1.grad);
  print(w1.grad);
  print(x2.grad);
  print(w2.grad);
}
