import 'package:data_tracker/data_tracker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Example());
}

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TrackerScope(
      params: const {"id": 101},
      parentContext: context,
      child: const ExampleComponent(),
    );
  }
}

class ExampleComponent extends StatelessWidget {
  const ExampleComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TrackerScope(
      params: const {"name": "brook", "age": "18"},
      parentContext: context,
      child: Builder(builder: (conetxt) {
        final id = Tracker.find(conetxt, "id");
        final idOrDefault =
            Tracker.findOrDefault(context, 'id', defaultVal: "101");
        final filters = Tracker.findMap(conetxt, ['id', 'name']);
        final allFilters = Tracker.findAllMap(conetxt, ['id', 'name']);
        final currentParams = Tracker.collectSelf(conetxt);
        final allParams = Tracker.collect(conetxt);

        return Column(
          children: [
            Text('$id'),
            Text('$idOrDefault'),
            Text('$filters'),
            Text('$allFilters'),
            Text('$currentParams'),
            Text('$allParams'),
          ],
        );
      }),
    );
  }
}
