import 'dart:math';

class Value(
  final double data, {
  final List<Value> children = const [],
  final String op = '',
}) {
  double grad = 0;
  Function? _back;

  @override
  String toString() {
    return "Value: $data";
  }

  Value operator +(Value other) {
    final out = Value(data + other.data, children: [this, other], op: '+');
    out._back = () {
      this.grad += 1 * out.grad;
      other.grad += 1 * out.grad;
    };
    return out;
  }

  Value operator *(Value other) {
    final out = Value(data * other.data, children: [this, other], op: '*');
    out._back = () {
      this.grad += other.data * out.grad;
      other.grad += this.data * out.grad;
    };
    return out;
  }

  Value tanh() {
    final x = this.data;
    final t = (exp(2 * x) - 1) / (exp(2 * x) + 1);
    final out = Value(t, children: [this], op: 'tanh');
    out._back = () {
      this.grad += (1 - pow(t, 2)).toDouble() * out.grad;
    };
    return out;
  }

  void back() {
    List<Value> sorted = [];
    Set<Value> visited = Set();

    final topo = _topSort(this, sorted, visited);

    this.grad = 1;
    for (final v in topo.reversed) {
      v._back?.call();
    }
  }

  List<Value> _topSort(Value v, List<Value> sorted, Set<Value> visited) {
    if (!visited.contains(v)) {
      visited.add(v);
      for (final child in v.children) {
        sorted = _topSort(child, sorted, visited);
      }
      sorted = [...sorted, v];
    }

    return sorted;
  }
}
