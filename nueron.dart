import 'dart:math';

import 'value.dart';

class Neuron(final int nin) {
  final weights = List.generate(
    nin,
    (_) => (Value(Random().nextDouble() * 2) - 1),
  );
  final bias = Value((Random().nextDouble() * 2) - 1);

  Value call(List<Value> x) {
    final sum = Iterable.generate(
      weights.length,
      (index) => weights[index] * x[index],
    ).reduce((value, ele) => value + ele);

    final act = sum + bias;
    return act.tanh();
  }

  List<Value> parameters() {
    return [...weights, bias];
  }
}
