import 'nueron.dart';
import 'value.dart';

class Layer(final int nin, final int nout) {
  final neurons = List.generate(nout, (_) => Neuron(nin));

  List<Value> call(List<Value> x) {
    final outs = [for (final n in neurons) n(x)];
    return outs;
  }

  List<Value> parameters() {
    final List<Value> params = [];
    for (final neuron in neurons) {
      params.addAll(neuron.parameters());
    }
    return params;
  }
}
