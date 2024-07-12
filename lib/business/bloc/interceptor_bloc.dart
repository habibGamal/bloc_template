import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';

class InterceptorEvent {}

class Intercept extends InterceptorEvent {
  final Object _e;
  Intercept(this._e);
}

enum InterceptorStatus {
  unknown,
  newtworkError,
  parsingError,
  idel,
  unauthenticated,
  timeout
}

extension InterceptorStatusX on InterceptorStatus {
  bool get isNetworkError => this == InterceptorStatus.newtworkError;
  bool get isParsingError => this == InterceptorStatus.parsingError;
  bool get isUnknown => this == InterceptorStatus.unknown;
  bool get isTimeout => this == InterceptorStatus.timeout;
  bool get isIdel => this == InterceptorStatus.idel;
  bool get isUnauthenticated => this == InterceptorStatus.unauthenticated;
}

class InterceptorState {
  final InterceptorStatus status;

  const InterceptorState({this.status = InterceptorStatus.idel});

  InterceptorState copyWith({InterceptorStatus? status}) {
    return InterceptorState(
      status: status ?? this.status,
    );
  }
}

class InterceptorBloc extends Bloc<InterceptorEvent, InterceptorState> {
  InterceptorBloc() : super(const InterceptorState()) {
    on<Intercept>(_intercept);
  }

  void _intercept(Intercept event, Emitter<InterceptorState> emit) async {
    final error = event._e;
    print("ERR from interceptor : $error");
    if (error is TimeoutException) {
      emit(state.copyWith(status: InterceptorStatus.timeout));
    } else if (error is OperationException) {
      final message = error.graphqlErrors.first.message;
      if (message == "Unauthenticated.") {
        emit(state.copyWith(status: InterceptorStatus.unauthenticated));
      } else {
        emit(state.copyWith(status: InterceptorStatus.newtworkError));
      }
    } else {
      emit(state.copyWith(status: InterceptorStatus.unknown));
    }
  }
}

mixin InterceptorMixen<Event, State> {
  InterceptorBloc get interceptorBloc;
  interceptor<E extends Event>(
    FutureOr<void> Function(E, Emitter<State>) handler,
  ) {
    FutureOr<void> hof(
      E event,
      Emitter<State> emit,
    ) async {
      try {
        await handler(event, emit);
      } catch (error) {
        interceptorBloc.add(Intercept(error));
      }
    }

    return hof;
  }
}
