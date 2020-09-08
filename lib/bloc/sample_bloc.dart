import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sample_event.dart';
part 'sample_state.dart';

class SampleBloc extends Bloc<SampleEvent, SampleState> {
  SampleBloc() : super(SampleInitial());

  @override
  Stream<SampleState> mapEventToState(
    SampleEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}