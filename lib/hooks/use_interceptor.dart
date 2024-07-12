import 'package:bloc_app/business/bloc/interceptor_bloc.dart';
import 'package:bloc_app/constants/screens.dart';
import 'package:bloc_app/services/auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

useInterceptor() {
  final interceptor = useBloc<InterceptorBloc>();
  useBlocListener(interceptor, (interceptor, state, context) {
    switch ((state as InterceptorState).status) {
      case InterceptorStatus.newtworkError:
        Navigator.of(context).pushNamed(Screens.noInternet);
        break;
      case InterceptorStatus.timeout:
        Navigator.of(context).pushNamed(Screens.timeout);
        break;
      case InterceptorStatus.unauthenticated:
        AuthService.of(context).logout();
        break;
      default:
    }
  });
}
