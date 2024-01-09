A InheritedWidget that simplifies the tracker system share data for Component widget styling, Avoid multi-level parameter penetration .

## Features

Lightweight for Tracking system or Analytics by Firebase etc.


## Usage


```dart
class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tracker(
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
    return Tracker(
      params: const {"name": "brook", "age": "18"},
      parentContext: context,
      child: Builder(builder: (conetxt) {
        final id = Tracker.find(conetxt, "id");
        final filters = Tracker.findMap(conetxt, ['id', 'name']);
        final allParams = Tracker.collect(conetxt);

        return Center(
          child: Text(
              "id = $id | name = ${filters['name']} | age = ${allParams['age']}"),
        );
      }),
    );
  }
}

```
