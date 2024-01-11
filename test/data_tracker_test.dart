import 'package:data_tracker/data_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'findKey',
    (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            return TrackerScope(
              params: const {"id": "101"},
              parentContext: context,
              child: const Column(
                children: [
                  Spacer(),
                  Consumer(),
                ],
              ),
            );
          },
        ),
      );
      expect(find.text('101'), findsOneWidget);
    },
  );

  testWidgets(
    "find keys",
    (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            return TrackerScope(
              params: const {"id": "101", "name": "brook", "age": "18"},
              parentContext: context,
              child: const ConsumerList(
                keys: ["id", "name", "age"],
              ),
            );
          },
        ),
      );
      expect(find.text('101'), findsOneWidget);
      expect(find.text('brook'), findsOneWidget);
      expect(find.text('18'), findsOneWidget);
    },
  );

  testWidgets(
    "find all params of current context",
    (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            return TrackerScope(
              params: const {
                "id": "101",
                "name": "brook",
              },
              parentContext: context,
              child: TrackerScope.builder(
                  params: const {"age": "18", "gender": 1},
                  builder: (context) {
                    final currentParams = Tracker.collectSelf(context);
                    return Column(
                      children: [
                        const Spacer(),
                        ...currentParams.keys.map(
                          (key) => SizedBox(
                            height: 40,
                            child: Text(
                              "${currentParams[key]}",
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            );
          },
        ),
      );
      expect(find.text('101'), findsNothing);
      expect(find.text('brook'), findsNothing);
      expect(find.text('18'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
    },
  );

  testWidgets(
    "find all params",
    (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            return TrackerScope(
              params: const {
                "id": "101",
                "name": "brook",
                "age": "18",
                "gender": 1
              },
              parentContext: context,
              child: const ConsumerAllList(),
            );
          },
        ),
      );
      expect(find.text('101'), findsOneWidget);
      expect(find.text('brook'), findsOneWidget);
      expect(find.text('18'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
    },
  );

  testWidgets(
    'findKey cross tracker scope',
    (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            return TrackerScope(
              params: const {"id": "101"},
              parentContext: context,
              child: Column(
                children: [
                  const Spacer(),
                  Builder(
                    builder: (context) {
                      return TrackerScope(
                        params: const {"name": "brook"},
                        parentContext: context,
                        child: const Consumer(),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      );
      expect(find.text('101'), findsOneWidget);
    },
  );

  testWidgets(
    'collect of this context`s TrackerScope',
    (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            return TrackerScope(
              params: const {"id": "101"},
              parentContext: context,
              child: Column(
                children: [
                  const Spacer(),
                  Builder(
                    builder: (context) {
                      return TrackerScope(
                        params: const {"name": "brook"},
                        parentContext: context,
                        child: Builder(builder: (context) {
                          final collections = Tracker.collectSelf(context);

                          return Column(
                            children: collections.keys
                                .map(
                                  (e) => SizedBox(
                                    height: 40,
                                    child: Text(
                                      collections[e],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      );
      expect(find.text('101'), findsNothing);
      expect(find.text('brook'), findsOneWidget);
    },
  );

  testWidgets(
    'collect all',
    (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            return TrackerScope(
              params: const {"id": "101"},
              parentContext: context,
              child: Column(
                children: [
                  const Spacer(),
                  Builder(
                    builder: (context) {
                      return TrackerScope(
                        params: const {"name": "brook"},
                        parentContext: context,
                        child: Builder(builder: (context) {
                          final collections = Tracker.collect(context);

                          return Column(
                            children: collections.keys
                                .map(
                                  (e) => SizedBox(
                                    height: 40,
                                    child: Text(
                                      collections[e],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      );
      expect(find.text('101'), findsOneWidget);
      expect(find.text('brook'), findsOneWidget);
    },
  );
}

class Consumer extends StatelessWidget {
  const Consumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(Tracker.find(context, 'id'), textDirection: TextDirection.ltr);
  }
}

class ConsumerList extends StatelessWidget {
  final List<String> keys;

  const ConsumerList({
    super.key,
    required this.keys,
  });

  @override
  Widget build(BuildContext context) {
    final data = Tracker.findMap(context, keys);
    return Column(
      children: keys.map((key) {
        return SizedBox(
          height: 40,
          child: Text(
            data[key],
            textDirection: TextDirection.ltr,
          ),
        );
      }).toList(),
    );
  }
}

class ConsumerAllList extends StatelessWidget {
  const ConsumerAllList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Tracker.collect(context);
    return Column(
      children: data.keys.map((key) {
        return SizedBox(
          height: 40,
          child: Text(
            data[key].toString(),
            textDirection: TextDirection.ltr,
          ),
        );
      }).toList(),
    );
  }
}
