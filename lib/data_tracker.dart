import 'package:flutter/material.dart';

class TrackerScope extends InheritedWidget {
  final BuildContext? parentContext;
  final Map<String, dynamic> params;

  const TrackerScope({
    super.key,
    required this.params,
    required Widget child,
    this.parentContext,
  }) : super(child: child);

  TrackerScope.builder({
    super.key,
    required this.params,
    this.parentContext,
    required WidgetBuilder builder,
  }) : super(child: Builder(key: key, builder: builder));

  @override
  bool updateShouldNotify(covariant TrackerScope oldWidget) {
    return params != oldWidget.params;
  }
}

class Tracker {
  static TrackerScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TrackerScope>()!;
  }

  /// see [findOrDefault]
  static T? find<T>(BuildContext context, String key) {
    return findOrDefault<T>(context, key);
  }

  /// Find the Value through the Key. If the Scope of the current Context
  /// cannot be found, search recursively upwards.
  /// [defaultVal] provide for defaut value.
  static T? findOrDefault<T>(
    BuildContext context,
    String key, {
    T? defaultVal,
  }) {
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
      targetContext = targetContext
          .findAncestorWidgetOfExactType<TrackerScope>()
          ?.parentContext;
    } while (retVal == null);
    return retVal ?? defaultVal;
  }

  /// Find the Value through the Keys. only search the [TrackerScope]
  /// of provide context.
  static Map<String, dynamic> findMap(BuildContext context, List<String> keys) {
    Map<String, dynamic> retVal = {};
    final mutKeys = keys.toList();

    _findInternalKeys(context, retVal, mutKeys);
    return retVal;
  }

  /// Find the Value through the Keys. If the Scope of the current Context
  /// cannot be found, search recursively upwards.
  static Map<String, dynamic> findAllMap(
      BuildContext context, List<String> keys) {
    BuildContext? targetContext = context;
    Map<String, dynamic> retVal = {};
    final mutKeys = keys.toList();
    do {
      if (targetContext == null) {
        return retVal;
      }
      _findInternalKeys(targetContext, retVal, mutKeys);

      targetContext = targetContext
          .findAncestorWidgetOfExactType<TrackerScope>()
          ?.parentContext;
    } while (mutKeys.isNotEmpty);
    return retVal;
  }

  /// Collect all value for this context's [TrackerScope]
  static Map<String, dynamic> collectSelf(BuildContext context) {
    Map<String, dynamic> retVal = {};
    _collect(context, retVal);
    return retVal;
  }

  /// Collect all value. collect recursively upwards.
  static Map<String, dynamic> collect(BuildContext context) {
    BuildContext? targetContext = context;
    Map<String, dynamic> retVal = {};
    do {
      if (targetContext == null) {
        return retVal;
      }
      _collect(targetContext, retVal);

      targetContext = targetContext
          .findAncestorWidgetOfExactType<TrackerScope>()
          ?.parentContext;
    } while (targetContext != null);
    return retVal;
  }

  static T? _findInternal<T>(BuildContext context, String key) {
    final provider = context.dependOnInheritedWidgetOfExactType<TrackerScope>();
    if (provider != null) {
      if (provider.params.containsKey(key)) {
        return provider.params[key];
      }
    }
    return null;
  }

  static T? _findInternalKeys<T>(
      BuildContext context, Map<String, dynamic> retVal, List<String> keys) {
    final provider = context.dependOnInheritedWidgetOfExactType<TrackerScope>();
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

  static _collect(BuildContext context, Map<String, dynamic> retVal) {
    final provider = context.dependOnInheritedWidgetOfExactType<TrackerScope>();
    if (provider != null) {
      for (var key in provider.params.keys) {
        if (!retVal.containsKey(key)) {
          retVal[key] = provider.params[key];
        }
      }
    }
  }
}
