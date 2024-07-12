import 'package:bloc_app/business/bloc/interceptor_bloc.dart';
import 'package:bloc_app/data/dataprovider/auth_ql.dart';
import 'package:bloc_app/data/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthEvent {}

class TryAuthEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent(this.email, this.password);
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;
  RegisterEvent(this.email, this.password, this.confirmPassword);
}

class Logout extends AuthEvent {}

enum AuthStatus { guest, authenticated, authenticating }

class AuthState {
  final AuthStatus status;
  final String? token;
  final String? error;
  const AuthState({this.status = AuthStatus.guest, this.token, this.error});
  AuthState copyWith({AuthStatus? status, String? token, String? error}) {
    return AuthState(
      status: status ?? this.status,
      token: token ?? this.token,
      error: error ?? this.error,
    );
  }
}

class AuthBloc extends Bloc<AuthEvent, AuthState>
    with InterceptorMixen<AuthEvent, AuthState> {
  final AuthRepo _authRepo = AuthRepo(AuthQl());
  @override
  final InterceptorBloc interceptorBloc;
  AuthBloc(this.interceptorBloc) : super(const AuthState()) {
    on<LoginEvent>(interceptor(_login));
    on<TryAuthEvent>(interceptor(_tryAuth));
    on<Logout>(interceptor(_logout));
  }

  _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.authenticating));
    final token = await _authRepo.login(event.email, event.password);
    if (token != null) {
      emit(state.copyWith(status: AuthStatus.authenticated, token: token));
    } else {
      emit(state.copyWith(
          status: AuthStatus.guest, error: 'Invalid email or password'));
    }
  }

  _tryAuth(TryAuthEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.authenticating));
    final user = await _authRepo.tryAuth();
    if (user != null) {
      emit(state.copyWith(status: AuthStatus.authenticated));
    } else {
      emit(state.copyWith(status: AuthStatus.guest));
    }
  }

  _logout(Logout event, Emitter<AuthState> emit) async {
    final isLoggedOut = await _authRepo.logout();
    if (isLoggedOut) {
      emit(state.copyWith(status: AuthStatus.guest));
    }
  }
}
