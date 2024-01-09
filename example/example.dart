import 'package:data_tracker/data_tracker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Example());
}

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
        // 获取单个埋点数据， 自底向上检索
        final id = Tracker.find(conetxt, "id");
        // 根据keys获取Map， 自底向上检索
        final filters = Tracker.findMap(conetxt, ['id', 'name']);
        // 获取所有埋点信息， 自底向上检索
        final allParams = Tracker.collect(conetxt);

        return Center(
          child: Text(
              "id = $id | name = ${filters['name']} | age = ${allParams['age']}"),
        );
      }),
    );
  }
}
