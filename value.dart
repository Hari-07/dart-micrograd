import 'dart:math' as math;

class Value(
  final num data, {
  final List<Value> children = const [],
  final String op = '',
}) {
  double grad = 0;
  Function? _back;

  @override
  String toString() {
    return "Value: $data";
  }

  Value operator +(dynamic other) {
    if (other is! Value) {
      other = Value(other);
    }

    final out = Value(data + other.data, children: [this, other], op: '+');
    out._back = () {
      this.grad += 1 * out.grad;
      other.grad += 1 * out.grad;
    };
    return out;
  }

  Value operator *(dynamic other) {
    if (other is! Value) {
      other = Value(other);
    }

    final out = Value(data * other.data, children: [this, other], op: '*');
    out._back = () {
      this.grad += other.data * out.grad;
      other.grad += this.data * out.grad;
    };
    return out;
  }

  Value operator /(dynamic other) {
    if (other is! Value) {
      other = Value(other);
    }

    return this * other.pow(-1);
  }

  Value operator -(dynamic other) {
    if (other is! Value) {
      other = Value(other);
    }

    return this + (other * -1);
  }

  Value operator -() {
    return this * -1;
  }

  Value exp() {
    final x = this.data;
    final t = math.exp(x);
    final out = Value(t, children: [this], op: 'exp');
    out._back = () {
      this.grad += t * out.grad;
    };
    return out;
  }

  Value pow(num n) {
    final x = this.data;
    final out = Value(math.pow(x, n), children: [this], op: 'pow');
    out._back = () {
      this.grad += n * math.pow(x, n - 1) * out.grad;
    };
    return out;
  }

  Value tanh() {
    final x = this.data;
    final t = (math.exp(2 * x) - 1) / (math.exp(2 * x) + 1);
    final out = Value(t, children: [this], op: 'tanh');
    out._back = () {
      this.grad += (1 - math.pow(t, 2)).toDouble() * out.grad;
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
