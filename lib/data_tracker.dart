import 'package:flutter/material.dart';

class Tracker extends InheritedWidget {
  final BuildContext parentContext;
  final Map<String, dynamic> params;

  const Tracker({
    super.key,
    required this.parentContext,
    required this.params,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant Tracker oldWidget) {
    return params != oldWidget.params;
  }

  static Tracker of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Tracker>()!;
  }

  static dynamic find(BuildContext context, String key) {
    return findOrDefault(context, key);
  }

  static T? findOrDefault<T>(BuildContext context, String key,
      {T? defaultVal}) {
    BuildContext? targetContext = context;
    dynamic retVal;
    do {
      if (targetContext == null) {
        return defaultVal;
      }
      retVal = _findInternal(targetContext, key);
      if (retVal != null) {
        return retVal;
      }
      targetContext =
          targetContext.findAncestorWidgetOfExactType<Tracker>()?.parentContext;
    } while (retVal == null);
    return retVal ?? defaultVal;
  }

  static Map<String, dynamic> findMap(BuildContext context, List<String> keys) {
    BuildContext? targetContext = context;
    Map<String, dynamic> retVal = {};
    final mutKeys = keys.toList();
    do {
      if (targetContext == null) {
        return retVal;
      }
      _findInternalKeys(targetContext, retVal, mutKeys);

      targetContext =
          targetContext.findAncestorWidgetOfExactType<Tracker>()?.parentContext;
    } while (mutKeys.isNotEmpty);
    return retVal;
  }

  static Map<String, dynamic> collect(BuildContext context) {
    BuildContext? targetContext = context;
    Map<String, dynamic> retVal = {};
    do {
      if (targetContext == null) {
        return retVal;
      }
      _collect(targetContext, retVal);

      targetContext =
          targetContext.findAncestorWidgetOfExactType<Tracker>()?.parentContext;
    } while (targetContext != null);
    return retVal;
  }

  static dynamic _findInternal(BuildContext context, String key) {
    final provider = context.dependOnInheritedWidgetOfExactType<Tracker>();
    if (provider != null) {
      if (provider.params.containsKey(key)) {
        return provider.params[key];
      }
    }
    return null;
  }

  static dynamic _findInternalKeys(
      BuildContext context, Map<String, dynamic> retVal, List<String> keys) {
    final provider = context.dependOnInheritedWidgetOfExactType<Tracker>();
    if (provider != null) {
      for (var key in keys) {
        if (provider.params.containsKey(key)) {
          retVal[key] = provider.params[key];
        }
      }
      keys.removeWhere((element) => retVal.containsKey(element));
    }
    return null;
  }

  static dynamic _collect(BuildContext context, Map<String, dynamic> retVal) {
    final provider = context.dependOnInheritedWidgetOfExactType<Tracker>();
    if (provider != null) {
      for (var key in provider.params.keys) {
        if (!retVal.containsKey(key)) {
          retVal[key] = provider.params[key];
        }
      }
    }
    return null;
  }
}
