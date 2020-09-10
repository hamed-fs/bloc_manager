import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_manager/bloc/connectivity_bloc.dart';
import 'package:flutter_bloc_manager/bloc_manager.dart';
import 'package:meta/meta.dart';

part 'sample_event.dart';
part 'sample_state.dart';

class SampleBloc extends Bloc<SampleEvent, SampleState> {
  SampleBloc() : super(SampleInitial()) {
    BlocManager.instance.addListener<ConnectivityBloc>(
      key: 'Connectivity',
      handler: (dynamic state) async => print(state),
    );
  }

  @override
  Stream<SampleState> mapEventToState(
    SampleEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
