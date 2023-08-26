import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log(bloc.toString());
    log(change.toString());

    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    log(bloc.toString());

    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    log(bloc.toString());

    super.onCreate(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log(bloc.toString());
    log(error.toString());
    log(stackTrace.toString());

    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log(bloc.toString());
    log(event.toString());

    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log(bloc.toString());
    log(transition.toString());

    super.onTransition(bloc, transition);
  }
}
