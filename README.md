[![pub package](https://img.shields.io/pub/v/data_tracker.svg)](https://pub.dartlang.org/packages/data_tracker)

A InheritedWidget that simplifies the tracker system share data for Component widget styling, Avoid multi-level parameter penetration .

## Features

Lightweight for Tracking system or Analytics by Firebase etc. Provider a quick access for data of analytics.


## Usage


```dart
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

```

### Use for dialog or another Cross-Context Scenes.

```dart
showDialog(
  context: context,
  builder: (context) {
    return TrackerScope(
      params: Tracker.collect(context),
      child: Container(),
    );
  },
);

```
