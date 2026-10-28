import 'layer.dart';
import 'value.dart';

class MLP(final int nin, List<int> nouts) {
  final size = [nin, ...nouts];
  late final List<Layer> layers;

  this {
    layers = List.generate(
      nouts.length,
      (index) => Layer(size[index], size[index + 1]),
    );
  }

  call(List<dynamic> x) {
    List<Value> valueList;
    if (x is! List<Value>) {
      valueList = [for (final ele in x) Value(ele)];
    } else {
      valueList = x;
    }
    for (final layer in layers) {
      valueList = layer(valueList);
    }

    return valueList;
  }

  List<Value> parameters() {
    final List<Value> params = [];
    for (final layer in layers) {
      params.addAll(layer.parameters());
    }
    return params;
  }
}
