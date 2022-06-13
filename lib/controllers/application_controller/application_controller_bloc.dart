import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'application_controller_events.dart';
import 'application_controller_state.dart';

class ApplicationControllerBloc
    extends Bloc<ApplicationControllerEvents, ApplicationControllerState> {
  ApplicationControllerBloc() : super(ApplicationControllerStateInitial()) {
    on<ApplicationControllerEventsLoad>(_loadImage);
  }

  FutureOr<void> _loadImage(
    ApplicationControllerEventsLoad event,
    Emitter<ApplicationControllerState> emit,
  ) {
    emit(
      ApplicationControllerStateLoaded(
        properties: event.properties,
        imagePath: event.imagePath,
        answer: event.answer,
      ),
    );
  }
}
