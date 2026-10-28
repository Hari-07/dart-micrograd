import 'mlp.dart';
import 'value.dart';

void main() {
  final n = MLP(3, [4, 4, 1]);

  final xs = [
    [2.0, 3.0, -1.0],
    [3.0, -1.0, 0.5],
    [0.5, 1.0, 1.0],
    [1.0, 1.0, -1.0],
  ];
  final ys = [1.0, -1.0, -1.0, 1.0];

  for (int i = 0; i < 10000; i++) {
    final List<Value> ypred = [for (final x in xs) n(x)[0]];
    Value loss = Value(0);
    for (var i = 0; i < ys.length; i++) {
      final delta = ypred[i] - ys[i];
      loss += delta.pow(2);
    }
    for (final param in n.parameters()) {
      param.grad = 0;
    }

    loss.back();

    for (final param in n.parameters()) {
      param.data += -0.2 * param.grad;
    }
  }

  final List<Value> ypred = [for (final x in xs) n(x)[0]];

  print(ypred);
}
