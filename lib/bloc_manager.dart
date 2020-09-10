import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

typedef BlocManagerListenerHandler = Future<void> Function(dynamic state);

abstract class BlocManagerContract {
  void register<T extends Bloc<dynamic, dynamic>>(Function predicate);

  T fetch<T extends Bloc<dynamic, dynamic>>();

  void addListener<T extends Bloc<dynamic, dynamic>>({
    @required String key,
    @required BlocManagerListenerHandler handler,
  });

  Future<void> removeListener(String key);

  void dispose<T>();
}

class MockBlocManager extends BlocManagerContract {
  @override
  void register<T extends Bloc<dynamic, dynamic>>(Function predicate) {}

  @override
  T fetch<T extends Bloc<dynamic, dynamic>>() {
    throw UnimplementedError();
  }

  @override
  void addListener<T extends Bloc<dynamic, dynamic>>({
    @required String key,
    @required BlocManagerListenerHandler handler,
  }) {}

  @override
  Future<void> removeListener(String key) async {}

  @override
  void dispose<T>() {}
}

class BlocManager extends BlocManagerContract {
  factory BlocManager() => _instance;

  BlocManager._internal();

  static final BlocManager _instance = BlocManager._internal();

  static BlocManager get instance => _instance;

  final Map<dynamic, Function> _factories = <dynamic, Function>{};
  final Map<dynamic, Bloc<dynamic, dynamic>> _repository =
      <dynamic, Bloc<dynamic, dynamic>>{};
  final Map<String, StreamSubscription<dynamic>> _subscriptions =
      <String, StreamSubscription<dynamic>>{};

  Bloc<dynamic, dynamic> _invoke<T>() => _repository[T] = _factories[T]();

  @override
  void register<T extends Bloc<dynamic, dynamic>>(Function predicate) =>
      _factories[T] = predicate;

  @override
  T fetch<T extends Bloc<dynamic, dynamic>>() => _repository.containsKey(T)
      ? _repository[T]
      : _factories.containsKey(T) ? _invoke<T>() : null;

  @override
  void addListener<T extends Bloc<dynamic, dynamic>>({
    @required String key,
    @required BlocManagerListenerHandler handler,
  }) {
    if (_subscriptions.containsKey(key)) {
      return;
    }

    _subscriptions[key] = fetch<T>().listen((dynamic state) async {
      await handler(state);
    });
  }

  @override
  Future<void> removeListener(String key) async {
    if (!_subscriptions.containsKey(key)) {
      return;
    }

    await _subscriptions[key].cancel();
    _subscriptions.remove(key);
  }

  @override
  void dispose<T>() {
    if (_repository.containsKey(T)) {
      _repository[T].close();
      _repository.remove(T);
    }
  }
}
