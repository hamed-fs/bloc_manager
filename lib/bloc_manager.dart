// ignore_for_file: cascade_invocations

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_manager/bloc/sample_bloc.dart';

abstract class BlocManagerContract {
  void register<T extends Bloc<dynamic, dynamic>>(Function predicate);

  T fetch<T extends Bloc<dynamic, dynamic>>();

  void dispose<T>();
}

class MockBlocManager extends BlocManagerContract {
  @override
  void dispose<T>() {}

  @override
  T fetch<T extends Bloc<dynamic, dynamic>>() {
    throw UnimplementedError();
  }

  @override
  void register<T extends Bloc<dynamic, dynamic>>(Function predicate) {}
}

class BlocManager extends BlocManagerContract {
  factory BlocManager() => _instance;

  BlocManager._internal();

  static final BlocManager _instance = BlocManager._internal();

  static BlocManager get instance => _instance;

  final Map<dynamic, Function> _factories = <dynamic, Function>{};
  final Map<dynamic, Bloc<dynamic, dynamic>> _repository =
      <dynamic, Bloc<dynamic, dynamic>>{};

  Bloc<dynamic, dynamic> _invoke<T>() => _repository[T] = _factories[T]();

  @override
  void register<T extends Bloc<dynamic, dynamic>>(Function predicate) =>
      _factories[T] = predicate;

  @override
  T fetch<T extends Bloc<dynamic, dynamic>>() => _repository.containsKey(T)
      ? _repository[T]
      : _factories.containsKey(T) ? _invoke<T>() : null;

  @override
  void dispose<T>() {
    if (_repository.containsKey(T)) {
      _repository[T].close();
      _repository.remove(T);
    }
  }
}

void main() {
  BlocManager.instance.register<SampleBloc>(() => SampleBloc());
  final SampleBloc sampleBloc = BlocManager.instance.fetch<SampleBloc>();

  print(sampleBloc);
}
